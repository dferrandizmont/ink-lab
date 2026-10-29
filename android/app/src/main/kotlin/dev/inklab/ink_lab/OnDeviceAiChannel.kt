package dev.inklab.ink_lab

import android.os.Build
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.TimeoutCancellationException
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import kotlinx.coroutines.withTimeout

/**
 * Bridge between Dart and the on-device Gemini Nano model (ML Kit GenAI Prompt
 * API, served by Android AICore).
 *
 * Everything runs locally: AICore owns the model and its download, and this
 * path never opens a network connection of its own. No call here throws to
 * Dart for an expected failure: `status` degrades to "unavailable", and
 * `generate` answers with a typed error code that Dart maps to a fallback.
 *
 * Methods on `ink_lab/on_device_ai`:
 *  - `status`   -> "unavailable" | "downloadable" | "downloading" | "available"
 *  - `download` -> "started"; progress and the outcome arrive as events on
 *                  `ink_lab/on_device_ai/download`. The download runs in
 *                  [OnDeviceDownloads], an application-scoped coroutine: it is
 *                  not tied to this channel, the Activity or the call, so it
 *                  survives leaving the screen and recreating the Activity.
 *  - `generate` -> the generated text (argument: the prompt string)
 *  - `cancel`   -> cancels the running `generate`, if any
 */
class OnDeviceAiChannel(messenger: BinaryMessenger) :
    MethodChannel.MethodCallHandler, EventChannel.StreamHandler {

    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.Main)
    private val methods = MethodChannel(messenger, METHOD_CHANNEL)
    private val events = EventChannel(messenger, EVENT_CHANNEL)

    // The ML Kit classes need API 26; they are only ever touched behind this
    // check, so the app still starts on API 24 and 25.
    private val client: GeminiNanoClient? by lazy {
        if (Build.VERSION.SDK_INT >= MIN_SDK) GeminiNanoClient() else null
    }

    private var generateJob: Job? = null

    init {
        methods.setMethodCallHandler(this)
        events.setStreamHandler(this)
    }

    fun dispose() {
        methods.setMethodCallHandler(null)
        events.setStreamHandler(null)
        // Only this channel's listener goes; the download keeps running.
        OnDeviceDownloads.detach(this)
        scope.cancel()
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "status" -> status(result)
            "download" -> download(result)
            "generate" -> generate(call.arguments as? String, result)
            "cancel" -> {
                generateJob?.cancel()
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun status(result: MethodChannel.Result) {
        val nano = client
        if (nano == null) {
            result.success(UNAVAILABLE)
            return
        }
        scope.launch {
            val value = try {
                withTimeout(STATUS_TIMEOUT_MS) { nano.status() }
            } catch (e: TimeoutCancellationException) {
                UNAVAILABLE
            } catch (e: CancellationException) {
                throw e
            } catch (_: Throwable) {
                UNAVAILABLE
            }
            result.success(value)
        }
    }

    private fun download(result: MethodChannel.Result) {
        val nano = client
        if (nano == null) {
            result.error("unavailable", "Gemini Nano needs Android 8.0 or newer", null)
            return
        }
        OnDeviceDownloads.start(nano)
        result.success("started")
    }

    private fun generate(prompt: String?, result: MethodChannel.Result) {
        val nano = client
        if (nano == null) {
            result.error("unavailable", "Gemini Nano needs Android 8.0 or newer", null)
            return
        }
        if (prompt.isNullOrBlank()) {
            result.error("invalid_prompt", "The prompt is empty", null)
            return
        }
        generateJob?.cancel()
        generateJob = scope.launch {
            try {
                val text = withTimeout(GENERATE_TIMEOUT_MS) { nano.generate(prompt) }
                if (text.isNullOrBlank()) {
                    result.error("empty", "The model returned no text", null)
                } else {
                    result.success(text)
                }
            } catch (e: TimeoutCancellationException) {
                result.error("timeout", "The model took too long", null)
            } catch (e: CancellationException) {
                result.error("cancelled", "The request was cancelled", null)
                throw e
            } catch (e: Throwable) {
                result.error("generate_failed", e.message ?: e.javaClass.simpleName, null)
            }
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        OnDeviceDownloads.attach(this, events)
    }

    override fun onCancel(arguments: Any?) {
        // The download itself keeps running in AICore and in the application
        // scope; only the listener goes.
        OnDeviceDownloads.detach(this)
    }

    private companion object {
        const val METHOD_CHANNEL = "ink_lab/on_device_ai"
        const val EVENT_CHANNEL = "ink_lab/on_device_ai/download"
        const val MIN_SDK = Build.VERSION_CODES.O // API 26, required by genai-prompt
        const val STATUS_TIMEOUT_MS = 10_000L
        const val GENERATE_TIMEOUT_MS = 30_000L
        const val UNAVAILABLE = "unavailable"
    }
}

/**
 * The one on-device model download of the process.
 *
 * Android (AICore) may keep a requested download queued for a long time,
 * waiting for Wi-Fi, charging and idle. The collection therefore runs in an
 * application-scoped coroutine, never in the Activity or a method call, and
 * reports progress to whichever event listener is attached right now (none is
 * fine: the Dart side re-reads the status on resume).
 */
internal object OnDeviceDownloads {
    private val appScope = CoroutineScope(SupervisorJob() + Dispatchers.Main.immediate)
    private var job: Job? = null
    private var owner: Any? = null
    private var sink: EventChannel.EventSink? = null
    private var last: Map<String, Any>? = null

    fun attach(who: Any, events: EventChannel.EventSink?) {
        owner = who
        sink = events
        // A listener that arrives mid-download gets the latest step at once.
        if (job?.isActive == true) last?.let { events?.success(it) }
    }

    fun detach(who: Any) {
        if (owner === who) {
            owner = null
            sink = null
        }
    }

    fun start(nano: GeminiNanoClient) {
        if (job?.isActive == true) return
        last = null
        job = appScope.launch {
            try {
                nano.download { event ->
                    last = event
                    sink?.success(event)
                }
            } catch (e: CancellationException) {
                throw e
            } catch (e: Throwable) {
                sink?.success(mapOf("type" to "failed", "message" to (e.message ?: "")))
            }
        }
    }
}
