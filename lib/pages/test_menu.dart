import 'package:connect4/app.dart';
import 'package:connect4/models/player.dart';
import 'package:connect4/pages/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class TestMenu extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final boardStateNotifier = useProvider(boardParamsStateProvider);
    final boardParams = useProvider(boardParamsStateProvider.state);
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing menu'),
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
                    child: Text('Random VS Minimax'),
                    color: Colors.blueGrey[700],
                    textColor: Colors.white,
                    onPressed: () {
                      boardStateNotifier.prepareGame(Player.random, Player.minimax, true);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Game(
                            title: 'Random VS Minimax',
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Random VS AlphaBeta'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () {
                    boardStateNotifier.prepareGame(Player.random, Player.alphaBeta, true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Game(
                          title: 'Random VS AlphaBeta',
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Minimax VS AlphaBeta'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () {
                    boardStateNotifier.prepareGame(Player.minimax, Player.alphaBeta, true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Game(
                          title: 'Minimax VS AlphaBeta',
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Minimax VS Random'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () {
                    boardStateNotifier.prepareGame(Player.minimax, Player.random, true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Game(
                          title: 'Minimax VS Random',
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('AlphaBeta VS Random'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () {
                    boardStateNotifier.prepareGame(Player.alphaBeta, Player.random, true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Game(
                          title: 'AlphaBeta VS Random',
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('AlphaBeta VS Minimax'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () {
                    boardStateNotifier.prepareGame(Player.alphaBeta, Player.minimax, true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Game(
                          title: 'AlphaBeta VS Minimax',
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text('MiniMax depth', style: TextStyle(color: Colors.white,),),
                Slider(
                  activeColor: Colors.greenAccent,
                  inactiveColor: Colors.white12,
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
                Text('AlphaBeta', style: TextStyle(color: Colors.white,),),
                Slider(
                  activeColor: Colors.greenAccent,
                  inactiveColor: Colors.white12,
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
                Text('Number of tests', style: TextStyle(color: Colors.white,),),
                Slider(
                  activeColor: Colors.greenAccent,
                  inactiveColor: Colors.white12,
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
          ),
        ),
      ),
    );
  }
}
