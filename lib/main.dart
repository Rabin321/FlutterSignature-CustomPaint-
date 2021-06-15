import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    ));

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              final RenderBox object = context.findRenderObject() as RenderBox;
              Offset _localPosition =
                  object.globalToLocal(details.globalPosition);
              _points = new List.from(_points)..add(_localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add,
          child: new CustomPaint(
            painter: new Signature(points: _points),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40.0),
        child: Row(
          children: [
            FloatingActionButton(
              onPressed: () => _points.clear(),
              child: Icon(Icons.cut),
            ),
            SizedBox(
              width: 200,
            ),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.save),
            )
          ],
        ),

        // child: Icon(Icons.cut),
        // onPressed: () => _points.clear(),
      ),
    );
  }
}

//
class Signature extends CustomPainter {
  List<Offset> points;
  Signature({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.yellow
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}
