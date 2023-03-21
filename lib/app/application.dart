import 'app_settings.dart';

class Application {
  static Application? _singleton;
  late AppSettings appSettings;

  factory Application() {
    _singleton ??= Application._();
    return _singleton!;
  }

  Application._();
}
