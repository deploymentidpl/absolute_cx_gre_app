import 'dart:developer';

import 'package:flutter/foundation.dart';

void devPrint(Object? object) {
  if (kDebugMode) {
  print('$object');
  }
}

void devLog(Object? object) {
  // if (kDebugMode) {
  log('$object');
  // }
}
