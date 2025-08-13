import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart' show Color;

/// Core class for generating GitHub-style identicons
class GitHubIdenticonGenerator {
  final String seed;
  final double size;
  final bool showGrid;
  final Color? color;

  /// Creates a GitHub identicon generator
  ///
  /// [seed] : Unique identifier for the avatar
  /// [size] : Output image size in pixels
  /// [showGrid] : Whether to display the 5x5 grid lines (default: false)
  /// [color] : Optional color for the identicon. If it's null, color is generated from hash.
  GitHubIdenticonGenerator({
    required this.seed,
    required this.size,
    this.showGrid = false,
    this.color,
  });

  /// Generates the identicon as a UI Image
  Future<ui.Image> generate() async {
    final bytes = utf8.encode(seed);
    final digest = md5.convert(bytes);
    final hashHex = digest.toString();

    final Color useColor =
        (color != null)
            ? color!
            : Color(0xFF000000 | int.parse(hashHex.substring(0, 6), radix: 16));

    const gridSize = 5;
    final cellSize = (size / gridSize).floor();
    final canvasSize = cellSize * gridSize;

    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(
      recorder,
      ui.Rect.fromLTWH(0, 0, canvasSize.toDouble(), canvasSize.toDouble()),
    );

    final bgPaint = ui.Paint()..color = const ui.Color(0xFFFFFFFF);
    canvas.drawRect(
      ui.Rect.fromLTWH(0, 0, canvasSize.toDouble(), canvasSize.toDouble()),
      bgPaint,
    );

    final binStr = BigInt.parse('0x${hashHex.substring(6)}').toRadixString(2);
    final hashBinary = binStr.padLeft(15, '0').substring(0, 15);

    if (showGrid) {
      final gridPaint =
          ui.Paint()
            ..color = const ui.Color(0xFFE0E0E0)
            ..strokeWidth = 0.5
            ..style = ui.PaintingStyle.stroke;

      for (int i = 1; i < gridSize; i++) {
        canvas.drawLine(
          ui.Offset(i * cellSize.toDouble(), 0),
          ui.Offset(i * cellSize.toDouble(), canvasSize.toDouble()),
          gridPaint,
        );
        canvas.drawLine(
          ui.Offset(0, i * cellSize.toDouble()),
          ui.Offset(canvasSize.toDouble(), i * cellSize.toDouble()),
          gridPaint,
        );
      }
    }

    final paint = ui.Paint()..color = useColor;

    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < (gridSize / 2).ceil(); x++) {
        final idx = y * 3 + x;
        if (idx < 15 && hashBinary[idx] == '1') {
          _drawCell(canvas, x, y, cellSize, paint);

          if (x < 2) {
            final mirrorX = gridSize - 1 - x;
            _drawCell(canvas, mirrorX, y, cellSize, paint);
          }
        }
      }
    }

    final picture = recorder.endRecording();
    return await picture.toImage(canvasSize, canvasSize);
  }

  /// Draws a single grid cell
  void _drawCell(ui.Canvas canvas, int x, int y, int cellSize, ui.Paint paint) {
    final left = x * cellSize;
    final top = y * cellSize;

    canvas.drawRect(
      ui.Rect.fromLTWH(
        left.toDouble(),
        top.toDouble(),
        cellSize.toDouble(),
        cellSize.toDouble(),
      ),
      paint,
    );
  }

  /// Generates image bytes in PNG format
  Future<Uint8List> generateImageBytes() async {
    final image = await generate();
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}
