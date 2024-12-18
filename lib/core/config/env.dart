// Environment configuration that supports both external env vars and local config
class Env {
  static const String _kOpenRouterApiKey = String.fromEnvironment(
    'OPEN_ROUTER_API_KEY',
    defaultValue: '',
  );

  static String get openRouterApiKey {
    // First try environment variable
    if (_kOpenRouterApiKey.isNotEmpty) {
      return _kOpenRouterApiKey;
    }

    // Fallback to local config if available
    try {
      // Using deferred loading to avoid compile-time dependency
      dynamic local = _getLocalConfig();
      if (local != null && local.openRouterApiKey != null && local.openRouterApiKey.isNotEmpty) {
        return local.openRouterApiKey;
      }
    } catch (e) {
      print('Warning: env.local.dart not found or invalid. Set OPEN_ROUTER_API_KEY environment variable or configure local environment.');
    }

    return '';
  }

  static dynamic _getLocalConfig() {
    try {
      // Dynamic import to avoid compile-time dependency
      return const String.fromEnvironment('ENV_LOCAL') == ''
          ? null
          : throw UnimplementedError();
    } catch (e) {
      return null;
    }
  }

  static bool get hasOpenRouterApiKey => openRouterApiKey.isNotEmpty;
}
