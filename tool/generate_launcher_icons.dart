// Rebuild mobile launcher assets: flutter test tool/generate_launcher_icons.dart
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> saveIcon(String path, int size, {bool adaptive = false}) async {
  final svg = await File('assets/app_logo_splash/app_logo.svg').readAsString();
  final logo = await vg.loadPicture(SvgStringLoader(svg), null);
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  if (!adaptive) canvas.drawColor(const ui.Color(0xFFFFFFFF), ui.BlendMode.src);
  // The adaptive layer reserves space for launcher masks and motion.
  final extent = size * (adaptive ? 0.56 : 0.72);
  canvas.translate((size - extent) / 2, (size - extent) / 2);
  canvas.scale(extent / logo.size.width, extent / logo.size.height);
  canvas.drawPicture(logo.picture);
  final picture = recorder.endRecording();
  final image = await picture.toImage(size, size);
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  final output = File(path);
  await output.parent.create(recursive: true);
  await output.writeAsBytes(bytes!.buffer.asUint8List());
  image.dispose();
  picture.dispose();
  logo.picture.dispose();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Generate mobile launcher icons from the Health Track logo', () async {
    await saveIcon('assets/app_logo_splash/launcher_icon.png', 1024);
    const densities = {
      'mdpi': 1.0,
      'hdpi': 1.5,
      'xhdpi': 2.0,
      'xxhdpi': 3.0,
      'xxxhdpi': 4.0,
    };
    for (final density in densities.entries) {
      final directory = 'android/app/src/main/res/mipmap-${density.key}';
      await saveIcon(
        '$directory/ic_launcher.png',
        (48 * density.value).round(),
      );
      await saveIcon(
        '$directory/ic_launcher_foreground.png',
        (108 * density.value).round(),
        adaptive: true,
      );
    }
    const ios = 'ios/Runner/Assets.xcassets/AppIcon.appiconset';
    final catalog = jsonDecode(
      await File('$ios/Contents.json').readAsString(),
    ) as Map<String, dynamic>;
    for (final entry in catalog['images'] as List<dynamic>) {
      final size = double.parse((entry['size'] as String).split('x').first);
      final scale = double.parse(
        (entry['scale'] as String).replaceAll('x', ''),
      );
      await saveIcon('$ios/${entry['filename']}', (size * scale).round());
    }
  });
}
