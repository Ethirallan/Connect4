import 'package:connect4/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class GameStats extends HookWidget {
  const GameStats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardState = useProvider(boardProvider);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Turn counter: ${boardState.turns}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Green counter: ${boardState.greenTurns}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Blue counter: ${boardState.blueTurns}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Green took ${boardState.greenTurnTime}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Blue took ${boardState.blueTurnTime}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          if (boardState.testing)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Game: ${boardState.gameCounter <= boardState.noOfTests ? boardState.gameCounter : boardState.noOfTests}/${boardState.noOfTests}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Green wins: ${boardState.greenWins}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Blue wins: ${boardState.blueWins}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}