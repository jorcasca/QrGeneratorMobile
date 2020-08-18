import 'package:qrgenerator/ui/widgets/theme.dart';
import 'package:flutter/material.dart';

class ButtonBlue extends StatefulWidget {
  final String text;
  final Function onPressed;
  final width;

  ButtonBlue(
      {Key key,
      @required this.text,
      @required this.onPressed,
      this.width = 200.0});

  @override
  _ButtonBlueState createState() => _ButtonBlueState();
}

class _ButtonBlueState extends State<ButtonBlue> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: SizedBox(
            width: widget.width,
            height: 40,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onPressed: widget.onPressed,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              color: theme().primaryColor,
              child: Text(widget.text, style: theme().textTheme.button),
            )));
  }
}
