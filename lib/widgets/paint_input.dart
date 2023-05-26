import 'package:flutter/material.dart';

class PaintInput extends StatefulWidget {
  const PaintInput({Key? key}) : super(key: key);

  @override
  State<PaintInput> createState() => _PaintInputState();
}

class _PaintInputState extends State<PaintInput> {
    List<Offset> _points = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanDown: (details) {
          setState(() {
            _points.add(details.localPosition);
          });
        },
        onPanUpdate: (details) {
          setState(() {
            _points.add(details.localPosition);
          });
        },
        onPanEnd: (details) {
          setState(() {
            _points.add(null!);
          });
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: DrawingPainter(points: _points),
          ),
        ),
      );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset> points;

  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}