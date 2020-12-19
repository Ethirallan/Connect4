import 'package:connect4/app.dart';
import 'package:connect4/models/player.dart';
import 'package:connect4/widgets/game_stats.dart';
import 'package:connect4/widgets/grid_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Game extends HookWidget {
  final String title;
  const Game({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardState = useProvider(boardProvider);
    final boardStateNotifier = useProvider(boardParamsStateProvider);
    return Scaffold(
      key: boardState.gameKey,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(icon: Icon(Icons.refresh),
            onPressed: () {
              boardStateNotifier.swapPlayers();
              boardState.newGame.call();
            },
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GameStats(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      boardState.winText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int i = 0; i < boardState.board.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    if ((boardState.currentPlayer == 1 && boardState.greenPlayer == Player.human) || (boardState.currentPlayer == 2 && boardState.bluePlayer == Player.human))
                                      boardState.addDisk(i);
                                  },
                                  child: Column(
                                    children: [
                                      for (int j = boardState.board[i].length - 1; j >= 0; j--)
                                        GridCell(
                                          playerColor: boardState.board[i][j],
                                        )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
