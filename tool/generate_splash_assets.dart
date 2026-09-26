// Rasterize the existing SVG design for native launch screens:
// flutter test tool/generate_splash_assets.dart
// dart run flutter_native_splash:create
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsi_ind_pr_2/design_system/app_colors.dart';

const _directory = 'assets/app_logo_splash';

Future<void> _drawSvg(ui.Canvas canvas, String name, Rect target) async {
  final svg = await File('$_directory/$name.svg').readAsString();
  final picture = await vg.loadPicture(SvgStringLoader(svg), null);
  final sizes = applyBoxFit(BoxFit.contain, picture.size, target.size);
  final destination = Alignment.center.inscribe(sizes.destination, target);
  canvas.save();
  canvas.translate(destination.left, destination.top);
  canvas.scale(destination.width / picture.size.width);
  canvas.drawPicture(picture.picture);
  canvas.restore();
  picture.picture.dispose();
}

Future<void> _save(
  String name,
  int width,
  int height,
  Future<void> Function(ui.Canvas) draw,
) async {
  final recorder = ui.PictureRecorder();
  await draw(ui.Canvas(recorder));
  final picture = recorder.endRecording();
  final image = await picture.toImage(width, height);
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  await File('$_directory/$name.png').writeAsBytes(bytes!.buffer.asUint8List());
  image.dispose();
  picture.dispose();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Generate native splash assets from the SVG design', () async {
    await _save('native_background', 1440, 3200, (canvas) async {
      const rect = Rect.fromLTWH(0, 0, 1440, 3200);
      canvas.drawRect(
        rect,
        Paint()..shader = AppColors.degradadoAzul.createShader(rect),
      );
    });
    // Original 189 x 256 composition at 4x density.
    await _save('native_logo', 756, 1024, (canvas) async {
      await _drawSvg(
        canvas,
        'splash_logo',
        const Rect.fromLTWH(0, 0, 756, 760),
      );
      await _drawSvg(
        canvas,
        'splash_health_track',
        const Rect.fromLTWH(18, 868, 720, 156),
      );
    });
    // Keep the welcome layout (logo, 27 px gap, text) in one central image.
    // Fit the artwork inside Android's 768 px safe circle. Shift it slightly
    // upward so the wider text at the bottom is not clipped by the mask.
    await _save('native_android12', 1152, 1152, (canvas) async {
      const scale = 0.66;
      canvas.translate(
        (1152 - 756 * scale) / 2,
        (1152 - 1024 * scale) / 2 - 24,
      );
      canvas.scale(scale);
      await _drawSvg(
        canvas,
        'splash_logo',
        const Rect.fromLTWH(0, 0, 756, 760),
      );
      await _drawSvg(
        canvas,
        'splash_health_track',
        const Rect.fromLTWH(18, 868, 720, 156),
      );
    });
  });
}
