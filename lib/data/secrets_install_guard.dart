import '../ai/api_key_provider.dart' show openRouterApiKeyName;
import 'key_value_store.dart';
import 'secret_store.dart';

/// Settings key that marks secrets as belonging to this installation.
const String secretsInstallMarkerKey = 'secrets_install_marker_v1';

/// Removes secrets an earlier installation left behind.
///
/// The iOS Keychain keeps items after the app is deleted, but the app's
/// settings do not survive. So the first launch of a fresh installation finds
/// no [secretsInstallMarkerKey]: any API key in the secret store then belongs
/// to a deleted copy of the app and is removed before anything can read it.
/// The marker is written only once the delete succeeded, so a failed delete
/// is tried again on the next launch.
///
/// Call it only on iOS. On Android the Keystore data goes with the app, and a
/// user updating from a version without the marker must keep their key.
Future<void> clearSecretsLeftByEarlierInstall({
  required KeyValueStore store,
  required SecretStore secrets,
}) async {
  if (await store.containsKey(secretsInstallMarkerKey)) return;
  try {
    await secrets.delete(openRouterApiKeyName);
  } on Object {
    return;
  }
  await store.setBool(secretsInstallMarkerKey, true);
}
