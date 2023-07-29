// @dart = 2.8
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/src/deprecated.dart';
import 'package:homerent/main.dart' as app;

import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter/services.dart';

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/image_picker');

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    ByteData data = await rootBundle.load('images/placeholder.jpg');
    Uint8List bytes = data.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();
    File file = await File(
      '${tempDir.path}/tmp.tmp',
    ).writeAsBytes(bytes);
    print(file.path);
    return file.path;
  });

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
