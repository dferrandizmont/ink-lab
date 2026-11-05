package dev.inklab.ink_lab

import android.util.Log
import com.google.mlkit.genai.common.DownloadStatus
import com.google.mlkit.genai.common.FeatureStatus
import com.google.mlkit.genai.prompt.GenerativeModel
import com.google.mlkit.genai.prompt.Generation

/**
 * Thin wrapper over the ML Kit GenAI Prompt API
 * (https://developers.google.com/ml-kit/genai/prompt/android/get-started).
 *
 * Only instantiate on API 26+ (see [OnDeviceAiChannel]).
 */
internal class GeminiNanoClient {
    private var cachedModel: GenerativeModel? = null
    private var callsInFlight = 0
    private val retired = mutableListOf<GenerativeModel>()

    private fun model(): GenerativeModel =
        cachedModel ?: Generation.getClient().also { cachedModel = it }

    /** Called on Main after a download; the next call must use a fresh client. */
    fun reset() {
        val old = cachedModel
        cachedModel = null
        if (old != null) {
            if (callsInFlight == 0) old.close() else retired.add(old)
        }
    }

    private fun finishCall() {
        callsInFlight--
        if (callsInFlight == 0) {
            retired.forEach { it.close() }
            retired.clear()
        }
    }

    /** One of "unavailable", "downloadable", "downloading", "available". */
    suspend fun status(): String {
        callsInFlight++
        try {
            return when (model().checkStatus()) {
                FeatureStatus.AVAILABLE -> "available"
                FeatureStatus.DOWNLOADABLE -> "downloadable"
                FeatureStatus.DOWNLOADING -> "downloading"
                else -> "unavailable"
            }
        } finally {
            finishCall()
        }
    }

    /** Runs the download, forwarding each step as a map for the event channel. */
    suspend fun download(emit: (Map<String, Any>) -> Unit) {
        var total = 0L
        model().download().collect { status ->
            when (status) {
                is DownloadStatus.DownloadStarted -> {
                    total = status.bytesToDownload
                    emit(mapOf("type" to "started", "total" to total))
                }
                is DownloadStatus.DownloadProgress ->
                    emit(
                        mapOf(
                            "type" to "progress",
                            "bytes" to status.totalBytesDownloaded,
                            "total" to total,
                        ),
                    )
                DownloadStatus.DownloadCompleted -> emit(mapOf("type" to "completed"))
                is DownloadStatus.DownloadFailed -> {
                    Log.w(
                        "InkLabOnDevice",
                        "${status.e.javaClass.simpleName}: ${status.e.message.orEmpty()}",
                    )
                    emit(mapOf("type" to "failed", "message" to (status.e.message ?: "")))
                }
            }
        }
    }

    /** The first candidate's text for a text-only prompt, or null. */
    suspend fun generate(prompt: String): String? {
        callsInFlight++
        try {
            return model().generateContent(prompt).candidates.firstOrNull()?.text
        } finally {
            finishCall()
        }
    }
}
