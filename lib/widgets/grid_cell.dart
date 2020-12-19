import 'package:flutter/material.dart';

class GridCell extends StatelessWidget {
  final int playerColor;
  GridCell({this.playerColor});
  @override
  Widget build(BuildContext context) {
    Color color = playerColor == 0
        ? Colors.blueGrey
        : playerColor == 1
        ? Colors.greenAccent
        : Colors.blueAccent;
    Color color2 = playerColor == 0
        ? Colors.blueGrey
        : playerColor == 1
        ? Colors.greenAccent[700]
        : Colors.blueAccent[700];
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
      margin: EdgeInsets.all(4),
      height: MediaQuery.of(context).size.width > 1000 ? 70 : 50,
      width: MediaQuery.of(context).size.width > 1000 ? 70 : 50,
      // height: MediaQuery.of(context).size.width / 10,
      // width: MediaQuery.of(context).size.width / 10,
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: color,
        ),
        shape: BoxShape.circle,
        color: color2,
      ),
    );
  }
}
