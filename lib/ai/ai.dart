/// AI advisor layer.
///
/// Advisors answer one question — "given this context, suggest palettes" — and
/// return the same domain types as the local engine. Every advisor is optional
/// and replaceable; the default app path never touches the network.
///
/// Import `package:ink_lab/ai/ai.dart` to get the whole surface.
library;

export 'ai_service.dart';
export 'ai_settings_controller.dart';
export 'api_key_provider.dart';
export 'fallback_palette_advisor.dart';
export 'on_device_ai_platform.dart';
export 'on_device_download.dart';
export 'on_device_prompt.dart';
export 'open_router_client.dart';
export 'open_router_palette_advisor.dart';
export 'palette_advisor.dart';
export 'platform_on_device_palette_advisor.dart';
