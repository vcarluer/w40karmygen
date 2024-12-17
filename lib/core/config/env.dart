import 'env.local.dart';

class Env {
  static String get openRouterApiKey {
    try {
      return EnvLocal.openRouterApiKey;
    } catch (e) {
      print('Warning: env.local.dart not found. Please copy env.local.template.dart to env.local.dart and set your API key.');
      return '';
    }
  }

  static bool get hasOpenRouterApiKey => openRouterApiKey.isNotEmpty;
}
