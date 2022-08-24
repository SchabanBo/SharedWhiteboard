import 'package:flutter/material.dart' hide Path;
import 'package:flutter/material.dart' as flutter_path;

import '../../dart_signalR.g.dart';

class BoardPainter extends CustomPainter {
  final List<Path> paths;

  BoardPainter(this.paths);

  @override
  void paint(Canvas canvas, Size size) {
    for (var path in paths) {
      final paint = Paint()
        ..color = Color(int.parse(path.color!))
        ..strokeCap = StrokeCap.round
        ..strokeWidth = path.stroke!
        ..style = PaintingStyle.stroke;

      final newPath = flutter_path.Path();
      newPath.moveTo(path.points[0].x!, path.points[0].y!);
      for (var i = 1; i < path.points.length; i++) {
        newPath.lineTo(path.points[i].x!, path.points[i].y!);
      }

      canvas.drawPath(newPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
