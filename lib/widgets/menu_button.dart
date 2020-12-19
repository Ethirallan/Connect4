import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final VoidCallback fun;
  MenuButton({this.label, this.fun});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50,),
      child: RaisedButton(
        child: Text(label),
        onPressed: fun,
      ),
    );
  }
}