import 'package:flutter/material.dart';


class RepeatCode extends StatelessWidget {
  RepeatCode({@required this.colour, this.CardChild, this.onpress});

  final Color colour;
  final Widget CardChild;
  final Function onpress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        child: CardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

