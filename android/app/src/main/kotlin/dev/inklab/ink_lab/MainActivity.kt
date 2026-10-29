package dev.inklab.ink_lab

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    private var onDeviceAi: OnDeviceAiChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        onDeviceAi = OnDeviceAiChannel(flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        onDeviceAi?.dispose()
        onDeviceAi = null
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
