import 'package:flutter/material.dart';

void gameOverDialog(BuildContext context, String winText, VoidCallback newGame) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: Text(
        'Game over',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: Text(
        winText,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Show board',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            newGame();
          },
          child: Text(
            'New game',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
