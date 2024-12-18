import 'env.local.dart' deferred as env_local;

class Env {
  static const String _kOpenRouterApiKey = String.fromEnvironment(
    'OPEN_ROUTER_API_KEY',
    defaultValue: '',
  );

  static String? _cachedLocalApiKey;

  static Future<void> loadLocalConfig() async {
    try {
      await env_local.loadLibrary();
      _cachedLocalApiKey = env_local.EnvLocal.openRouterApiKey;
    } catch (e) {
      print('Warning: env.local.dart not found or invalid. Set OPEN_ROUTER_API_KEY environment variable or configure local environment.');
      _cachedLocalApiKey = null;
    }
  }

  static String get openRouterApiKey {
    // First try environment variable
    if (_kOpenRouterApiKey.isNotEmpty) {
      return _kOpenRouterApiKey;
    }

    // Then try cached local config
    if (_cachedLocalApiKey != null && _cachedLocalApiKey!.isNotEmpty) {
      return _cachedLocalApiKey!;
    }

    return '';
  }

  static bool get hasOpenRouterApiKey => openRouterApiKey.isNotEmpty;
}
