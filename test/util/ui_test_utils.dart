import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> configureScreenSize(WidgetTester tester) async {
  const size = Size(414.0, 896.0);
  await tester.binding.setSurfaceSize(size);
  tester.binding.window.physicalSizeTestValue = size;
  tester.binding.window.devicePixelRatioTestValue = 1;
}

Future<void> _loadFont(String name, String path) async {
  final fontFile = File(path);
  final fontData = await fontFile.readAsBytes();
  final fontLoader = FontLoader(name);
  fontLoader.addFont(Future.value(ByteData.view(fontData.buffer)));
  await fontLoader.load();
}

Future<void> loadFonts() async {
  await _loadFont(
    'MaterialIcons',
    // The font is somewhere in the build folder once the app is build,
    // copy-paste the file in the test/assets folder.
    'test/assets/MaterialIcons-Regular.ttf',
  );
  await _loadFont(
    'Roboto',
    // Roboto is free to use and can be downloaded from Google Font
    'test/assets/Roboto-Regular.ttf',
  );
}