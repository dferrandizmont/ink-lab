package dev.inklab.ink_lab

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    private var onDeviceAi: OnDeviceAiChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        onDeviceAi = OnDeviceAiChannel(flutterEngine.dartExecutor.binaryMessenger)
    }

    // A widget tap that brings back an activity whose process had died arrives
    // here, not in onCreate: keep it as the activity's intent so the app still
    // finds the idea it was asked to open (home_widget reads activity.intent).
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        onDeviceAi?.dispose()
        onDeviceAi = null
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
