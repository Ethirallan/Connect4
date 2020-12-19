import 'package:connect4/app.dart';
import 'package:connect4/models/player.dart';
import 'package:connect4/pages/game.dart';
import 'package:connect4/pages/game_menu.dart';
import 'package:connect4/pages/test_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainMenu extends HookWidget {
  const MainMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardStateNotifier = useProvider(boardParamsStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Main menu'),
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
                    child: Text('Player VS AI'),
                    color: Colors.blueGrey[700],
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameMenu(),
                        ),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                    child: Text('Player VS Player'),
                    color: Colors.blueGrey[700],
                    textColor: Colors.white,
                    onPressed: () {
                      boardStateNotifier.prepareGame(Player.human, Player.human, false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Game(
                            title: 'Player VS Player',
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                    child: Text('Testing'),
                    color: Colors.blueGrey[700],
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestMenu(),
                        ),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}