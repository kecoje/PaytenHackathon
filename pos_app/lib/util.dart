import 'dart:io' show Platform;

import 'package:flutter/services.dart';

const paddy = 20.0;

void printLogo() async {
  const platform = MethodChannel('com.payten.dateafterpay/ch1');

  if (Platform.isAndroid) {
    await platform.invokeMethod('printLogo');
    // try {
    //   final int result = await platform.invokeMethod('getBattery');
    //   print('Battery level at $result % .');
    // } on PlatformException catch (e) {
    //   print("Failed to get battery level: '${e.message}'.");
    // }
  }
}
