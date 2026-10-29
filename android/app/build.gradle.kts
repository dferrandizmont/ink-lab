import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Release signing: android/key.properties (local) or ANDROID_* env vars (CI).
// Secrets are never committed.
val keyProps = Properties().apply {
    val f = rootProject.file("key.properties")
    if (f.isFile) f.inputStream().use { load(it) }
}

fun signingValue(propName: String, envName: String): String? =
    (keyProps.getProperty(propName) ?: System.getenv(envName))?.takeIf { it.isNotBlank() }

val releaseStoreFile = signingValue("storeFile", "ANDROID_KEYSTORE_PATH")
val releaseStorePassword = signingValue("storePassword", "ANDROID_KEYSTORE_PASSWORD")
val releaseKeyAlias = signingValue("keyAlias", "ANDROID_KEY_ALIAS")
val releaseKeyPassword = signingValue("keyPassword", "ANDROID_KEY_PASSWORD")
val hasReleaseSigning = releaseStoreFile != null && releaseStorePassword != null &&
    releaseKeyAlias != null && releaseKeyPassword != null
val allowDebugSigning = project.findProperty("allowDebugSigning")?.toString() == "true"

android {
    namespace = "dev.inklab.ink_lab"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "es.inklab.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseSigning) {
            create("release") {
                // Relative store paths in key.properties resolve against android/.
                storeFile = rootProject.file(releaseStoreFile!!)
                storePassword = releaseStorePassword
                keyAlias = releaseKeyAlias
                keyPassword = releaseKeyPassword
            }
        }
    }

    buildTypes {
        release {
            signingConfig = when {
                hasReleaseSigning -> signingConfigs.getByName("release")
                allowDebugSigning -> signingConfigs.getByName("debug")
                else -> null // blocked by the task graph check below
            }
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
            ndk {
                debugSymbolLevel = "FULL"
            }
        }
    }
}

// A release build must never be accidentally unsigned or debug-signed.
gradle.taskGraph.whenReady {
    val releaseRequested = allTasks.any {
        it.project == project &&
            Regex("^(assemble|bundle|package)Release$").matches(it.name)
    }
    if (releaseRequested && !hasReleaseSigning && !allowDebugSigning) {
        throw GradleException(
            "Release signing is not configured. Provide android/key.properties " +
                "(storeFile, storePassword, keyAlias, keyPassword) or the env vars " +
                "ANDROID_KEYSTORE_PATH, ANDROID_KEYSTORE_PASSWORD, ANDROID_KEY_ALIAS, " +
                "ANDROID_KEY_PASSWORD. For a local, non-store build only, pass " +
                "-PallowDebugSigning=true (debug-signed, NOT for stores)."
        )
    }
    if (releaseRequested && !hasReleaseSigning) {
        logger.warn("WARNING: release build is DEBUG-SIGNED (allowDebugSigning=true). Not for stores.")
    }
}

dependencies {
    // On-device Gemini Nano via the ML Kit GenAI Prompt API (Android AICore).
    // https://developers.google.com/ml-kit/genai/prompt/android/get-started
    // The library needs minSdk 26 while the app stays on Flutter's default: see
    // tools:overrideLibrary in the manifest and the Build.VERSION guard in
    // OnDeviceAiChannel.kt.
    implementation("com.google.mlkit:genai-prompt:1.0.0-beta4")
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
