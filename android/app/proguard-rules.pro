# Flutter embedding is kept by the Flutter Gradle plugin's own consumer rules.
# flutter_secure_storage, image_picker and shared_preferences ship consumer
# ProGuard rules / need no extra keeps. Add rules here only if R8 reports
# missing classes or a release-only crash.

# Play Core is optional for Flutter deferred components; not used by this app.
-dontwarn com.google.android.play.core.**

# ML Kit GenAI (Gemini Nano): R8 must keep the component registrars, which are
# instantiated by reflection (otherwise: NoSuchMethodException
# CommonComponentRegistrar.<init> at startup in release builds).
-keep class com.google.mlkit.** { *; }
-keep class * implements com.google.firebase.components.ComponentRegistrar { <init>(); }
-dontwarn com.google.mlkit.**
