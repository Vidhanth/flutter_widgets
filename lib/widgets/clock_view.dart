import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:widgets/animations.dart';
import 'package:widgets/main.dart';

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

var _timer;

class _ClockViewState extends State<ClockView> {
  String tag = "clock";
  bool showHands = false;

  @override
  void initState() {
    _timer = null;
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        showHands = true;
      });
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timer is int) {
        timer.cancel();
      } else {
        if (_timer == null) _timer = timer;
        if (_timer != null) {
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(getContext()).size;
    var cX = size.width / 2;
    var cY = size.height / 2;
    double radius = min(cX, cY);

    return WillPopScope(
      onWillPop: () {
        tag = "";
        if (_timer != null) {
          _timer.cancel();
          _timer = null;
        } else {
          _timer = 1;
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Center(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 40,
                      ),
                    ],
                  ),
                  height: radius * 1.1,
                ),
              ),
              Center(
                child: Hero(
                  tag: tag,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 40,
                        ),
                      ],
                    ),
                    height: radius * 1.0,
                  ),
                ),
              ),
              ZoomIn(
                child: Center(
                  child: CustomPaint(
                    painter: DashPainter(),
                  ),
                ),
              ),
              Center(
                child: Transform.rotate(
                  angle: -pi / 2,
                  child: AnimatedOpacity(
                    opacity: showHands ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: CustomPaint(
                      painter: ClockPainter(),
                    ),
                  ),
                ),
              ),
              Center(
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  height: showHands ? radius * 0.1 : 0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    size = MediaQuery.of(getContext()).size;
    var cX = size.width / 2;
    var cY = size.height / 2;
    double radius = min(cX, cY);

    Offset center = Offset(0, 0);

    Paint fillBrush = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    double outerCircle = radius * 0.8;
    double innerCircle = radius * 0.7;
    double outerSmallCircle = radius * 0.75;
    double innerSmallCircle = radius * 0.7;

    int count = -1;

    for (double i = 0; i < 360; i += 6) {
      count++;
      if (count % 5 == 0) {
        var x1 = outerCircle * cos(i * pi / 180);
        var y1 = outerCircle * sin(i * pi / 180);
        var x2 = innerCircle * cos(i * pi / 180);
        var y2 = innerCircle * sin(i * pi / 180);

        canvas.drawLine(
            Offset(x1, y1),
            Offset(x2, y2),
            fillBrush
              ..strokeWidth = 2
              ..color = Colors.grey[600]);
      } else {
        var x1 = outerSmallCircle * cos(i * pi / 180);
        var y1 = outerSmallCircle * sin(i * pi / 180);
        var x2 = innerSmallCircle * cos(i * pi / 180);
        var y2 = innerSmallCircle * sin(i * pi / 180);

        canvas.drawLine(
            Offset(x1, y1),
            Offset(x2, y2),
            fillBrush
              ..strokeWidth = 1
              ..color = Colors.grey[600]);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ClockPainter extends CustomPainter {
  DateTime _dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    size = MediaQuery.of(getContext()).size;
    var cX = size.width / 2;
    var cY = size.height / 2;
    double radius = min(cX, cY);

    Offset center = Offset(0, 0);

    Paint secHand = Paint()
      ..shader = RadialGradient(colors: [Colors.blue, Colors.greenAccent])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = radius * 0.025;

    Paint minHand = Paint()
      ..shader = RadialGradient(colors: [Colors.red, Colors.deepPurple])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = radius * 0.04;

    Paint hourHand = Paint()
      ..shader = RadialGradient(colors: [Colors.orange, Colors.deepPurple])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeWidth = radius * 0.04;

    var secHandX = (radius * 0.45) * cos(_dateTime.second * 6 * (pi / 180));
    var secHandY = (radius * 0.45) * sin(_dateTime.second * 6 * (pi / 180));

    var minHandX = (radius * 0.35) * cos(_dateTime.minute * 6 * pi / 180);
    var minHandY = (radius * 0.35) * sin(_dateTime.minute * 6 * pi / 180);

    var hourHandX = (radius * 0.3) *
        cos((_dateTime.hour * 30 + _dateTime.minute * 0.5) * pi / 180);
    var hourHandY = (radius * 0.3) *
        sin((_dateTime.hour * 30 + _dateTime.minute * 0.5) * pi / 180);

    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHand);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHand);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHand);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
