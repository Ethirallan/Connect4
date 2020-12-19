import 'package:connect4/app.dart';
import 'package:connect4/models/player.dart';
import 'package:connect4/pages/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameMenu extends HookWidget {
  const GameMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardStateNotifier = useProvider(boardParamsStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Game menu'),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        child: Center(
          child: SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RaisedButton(
                  child: Text('Easy - random AI'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () {
                    boardStateNotifier.prepareGame(Player.human, Player.random, false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Game(
                          title: 'Easy - random AI',
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Medium - Minimax AI'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () {
                    boardStateNotifier.prepareGame(Player.human, Player.minimax, false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Game(
                          title: 'Medium - Minimax AI',
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Hard - AlphaBeta AI'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () {
                    boardStateNotifier.prepareGame(
                        Player.human, Player.alphaBeta, false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Game(
                          title: 'Hard - AlphaBeta AI',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
