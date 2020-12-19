import 'package:connect4/app.dart';
import 'package:connect4/models/player.dart';
import 'package:connect4/pages/game.dart';
import 'package:connect4/pages/game_menu.dart';
import 'package:connect4/pages/test_menu.dart';
import 'package:connect4/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class MainMenu extends HookWidget {
  const MainMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardStateNotifier = useProvider(boardParamsStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Main menu'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MenuButton(
                label: 'Player VS AI',
                fun: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: GameMenu(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              MenuButton(
                label: 'Player VS Player',
                fun: () {
                  boardStateNotifier.prepareGame(
                    Player.human,
                    Player.human,
                    false,
                  );
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: Game(
                        title: 'Player VS Player',
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              MenuButton(
                label: 'Testing',
                fun: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: TestMenu(),
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
