import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../app/application.dart';

@module
abstract class DIModule {

  @Named('baseUrl')
  String get baseUrl => Application().appSettings.url;

  http.Client get client => http.Client();
}
