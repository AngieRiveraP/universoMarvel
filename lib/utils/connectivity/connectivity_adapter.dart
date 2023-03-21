import 'dart:developer';
import 'dart:io';

import 'package:injectable/injectable.dart';


@Injectable(as: Connectivity)
class ConnectivityAdapter implements Connectivity {
  @override
  Future<bool> isConnected() async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (e) {
      log(e.message, name: 'isConnected', error: e);
    }
    return false;
  }
}

mixin Connectivity {
  Future<bool> isConnected();
}
