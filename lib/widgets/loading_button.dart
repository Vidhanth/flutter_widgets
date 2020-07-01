import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingButton extends StatefulWidget {
  final Function onPressed;
  final Function onCompleted;
  final String title;
  final String completedTitle;
  final Gradient gradient;
  final Gradient completedGradient;
  final double radius;

  LoadingButton({
    this.onPressed,
    this.onCompleted,
    this.title = "Show clock",
    this.completedTitle = "Done!",
    this.gradient = const LinearGradient(
      colors: [Colors.red, Colors.purple],
    ),
    this.completedGradient = const LinearGradient(
      colors: [Colors.green, Colors.teal],
    ),
    this.radius = 300,
  });

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  Duration duration = Duration(milliseconds: 600);
  Curve curve = Curves.fastOutSlowIn;
  bool loading = false;
  bool shapeCircle = false;
  bool loadingComplete = false;
  String tag = "clock";
  bool showText = true;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: Hero(
        tag: tag,
        child: AnimatedContainer(
          height: 60,
          width: loading ? 60 : 300,
          decoration: BoxDecoration(
            shape: shapeCircle ? BoxShape.circle : BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 10,
              ),
            ],
            gradient:
                loadingComplete ? widget.completedGradient : widget.gradient,
          ),
          duration: duration,
          curve: curve,
          child: IgnorePointer(
            ignoring: loading,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  loading = true;
                  showText = !loading;
                });

                if (widget.onPressed != null)
                  Future.delayed(duration, () {
                    widget.onPressed();
                  });

                Future.delayed(Duration(seconds: 1), () async {

                  setState(() {
                    shapeCircle = true;
                  });
                  if (widget.onCompleted != null) await widget.onCompleted();
                  Future.delayed(duration, () async {
                    setState(() {
                      shapeCircle = false;
                      Future.delayed(Duration(milliseconds: 200), () {
                        setState(() {
                          loadingComplete = false;
                          loading = false;
                        });
                        Future.delayed(Duration(milliseconds: 500), () {
                          setState(() {
                            showText = !loading;
                          });
                        });
                      });
                    });
                  });
                });
              },
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: !loading
                    ? Container(
                        child: AnimatedDefaultTextStyle(
                          duration: Duration(milliseconds: 600),
                          curve: Curves.fastOutSlowIn,
                          style: TextStyle(
                            fontFamily: "sans-serif-light",
                            color:
                                !showText ? Colors.transparent : Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          child: Text(
                            widget.title,
                          ),
                        ),
                      )
                    : loadingComplete
                        ? FittedBox(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                AnimatedContainer(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5),
                                  child: AutoSizeText(
                                    widget.completedTitle,
                                    style: TextStyle(
                                      fontFamily: "sans-serif-light",
                                      color: Colors.white,
                                      fontSize: 150,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 1500),
                                  curve: curve,
                                  height: 40,
                                  width: loadingComplete ? 80 : 0,
                                ),
                              ],
                            ),
                          )
                        : SpinKitDoubleBounce(
                            color: Colors.white,
                            size: 30,
                          ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
