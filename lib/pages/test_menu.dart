import 'package:connect4/app.dart';
import 'package:connect4/models/player.dart';
import 'package:connect4/pages/game.dart';
import 'package:connect4/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:page_transition/page_transition.dart';

class TestMenu extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final boardStateNotifier = useProvider(boardParamsStateProvider);
    final spacing = useState(30.0);
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing menu'),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MenuButton(
                  label: 'Random VS Minimax',
                  fun: () {
                    boardStateNotifier.prepareGame(Player.random, Player.minimax, true);
                    Navigator.push(
                      context,
                      PageTransition(type: PageTransitionType.fade, child: Game(
                        title: 'Random VS Minimax',
                      ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: spacing.value,
                ),
                MenuButton(
                  label: 'Random VS AlphaBeta',
                  fun: () {
                    boardStateNotifier.prepareGame(Player.random, Player.alphaBeta, true);
                    Navigator.push(
                      context,
                      PageTransition(type: PageTransitionType.fade, child: Game(
                        title: 'Random VS AlphaBeta',
                      ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: spacing.value,
                ),
                MenuButton(
                  label: 'Minimax VS AlphaBeta',
                  fun: () {
                    boardStateNotifier.prepareGame(Player.minimax, Player.alphaBeta, true);
                    Navigator.push(
                      context,
                      PageTransition(type: PageTransitionType.fade, child: Game(
                        title: 'Minimax VS AlphaBeta',
                      ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: spacing.value,
                ),
                MenuButton(
                  label: 'Minimax VS Random',
                  fun: () {
                    boardStateNotifier.prepareGame(Player.minimax, Player.random, true);
                    Navigator.push(
                      context,
                      PageTransition(type: PageTransitionType.fade, child: Game(
                        title: 'Minimax VS Random',
                      ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: spacing.value,
                ),
                MenuButton(
                  label: 'AlphaBeta VS Random',
                  fun: () {
                    boardStateNotifier.prepareGame(Player.alphaBeta, Player.random, true);
                    Navigator.push(
                      context,
                      PageTransition(type: PageTransitionType.fade, child: Game(
                        title: 'AlphaBeta VS Random',
                      ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: spacing.value,
                ),
                MenuButton(
                  label: 'AlphaBeta VS Minimax',
                  fun: () {
                    boardStateNotifier.prepareGame(Player.alphaBeta, Player.minimax, true);
                    Navigator.push(
                      context,
                      PageTransition(type: PageTransitionType.fade, child: Game(
                        title: 'AlphaBeta VS Minimax',
                      ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: spacing.value,
                ),
                Sliders(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Sliders extends HookWidget {
  const Sliders({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardStateNotifier = useProvider(boardParamsStateProvider);
    final boardParams = useProvider(boardParamsStateProvider.state);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Text('MiniMax depth'),
          Slider(
            min: 1,
            max: 6,
            divisions: 6,
            onChanged: (double val) {
              boardStateNotifier.changeMiniMaxDepth(val.toInt());
            },
            value: boardParams.miniMaxDepth.toDouble(),
            label: boardParams.miniMaxDepth.toString(),
          ),
          SizedBox(
            height: 10,
          ),
          Text('AlphaBeta'),
          Slider(
            min: 1,
            max: 9,
            divisions: 9,
            onChanged: (double val) {
              boardStateNotifier.changeAlphaBetaDepth(val.toInt());
            },
            value: boardParams.alphaBetaDepth.toDouble(),
            label: boardParams.alphaBetaDepth.toString(),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Number of tests'),
          Slider(
            min: 1,
            max: 100,
            divisions: 100,
            onChanged: (double val) {
              boardStateNotifier.changeNoOfTests(val.toInt());
            },
            value: boardParams.noOfTests.toDouble(),
            label: boardParams.noOfTests.toString(),
          ),
          Center(
            child: IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.white,
              onPressed: () => boardStateNotifier.reset(),
            ),
          ),
        ],
      ),
    );
  }
}