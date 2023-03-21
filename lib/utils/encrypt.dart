

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:universo_marvel/utils/constants.dart';

class Encrypt{

  static Future<String> encryptMD5() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    var bytes = utf8.encode("$timestamp${Constants.privateKey}${Constants.publicKey}");
    var hash = md5.convert(bytes);
    return hash.toString();
  }

}
