package dev.inklab.ink_lab

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
    private val model: GenerativeModel by lazy { Generation.getClient() }

    /** One of "unavailable", "downloadable", "downloading", "available". */
    suspend fun status(): String = when (model.checkStatus()) {
        FeatureStatus.AVAILABLE -> "available"
        FeatureStatus.DOWNLOADABLE -> "downloadable"
        FeatureStatus.DOWNLOADING -> "downloading"
        else -> "unavailable"
    }

    /** Runs the download, forwarding each step as a map for the event channel. */
    suspend fun download(emit: (Map<String, Any>) -> Unit) {
        var total = 0L
        model.download().collect { status ->
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
                is DownloadStatus.DownloadFailed ->
                    emit(mapOf("type" to "failed", "message" to (status.e.message ?: "")))
            }
        }
    }

    /** The first candidate's text for a text-only prompt, or null. */
    suspend fun generate(prompt: String): String? =
        model.generateContent(prompt).candidates.firstOrNull()?.text
}
