import 'package:connect4/app.dart';
import 'package:connect4/models/player.dart';
import 'package:connect4/pages/game.dart';
import 'package:connect4/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class GameMenu extends HookWidget {
  const GameMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardStateNotifier = useProvider(boardParamsStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Game menu'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MenuButton(
                label: 'Easy - random AI',
                fun: () {
                  boardStateNotifier.prepareGame(Player.human, Player.random, false);
                  Navigator.push(
                    context,
                    PageTransition(type: PageTransitionType.fade, child: Game(
                      title: 'Easy - random AI',
                    ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              MenuButton(
                label: 'Medium - Minimax AI',
                fun: () {
                  boardStateNotifier.prepareGame(Player.human, Player.minimax, false);
                  Navigator.push(
                    context,
                    PageTransition(type: PageTransitionType.fade, child: Game(
                      title: 'Medium - Minimax AI',
                    ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              MenuButton(
                label: 'Hard - AlphaBeta AI',
                fun: () {
                  boardStateNotifier.prepareGame(
                      Player.human, Player.alphaBeta, false);
                  Navigator.push(
                    context,
                    PageTransition(type: PageTransitionType.fade, child: Game(
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
    );
  }
}
