import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class RectPainter extends CustomPainter {
  final List<Rect> rects;
  final ui.Image image;

  RectPainter({
    @required this.rects,
    this.image,
  });

  final _painter = Paint()
    ..color = Colors.amber
    ..strokeWidth = 3
    ..style = PaintingStyle.stroke;

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    if (image != null) {
      canvas.drawImage(image, Offset.zero, Paint());
    }

    if (rects != null) {
      rects.forEach((rect) {
        canvas.drawRect(rect, _painter);
      });
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
