import 'dart:math';
import 'package:connect4/algorithms/alphabeta.dart';
import 'package:connect4/algorithms/minimax.dart';
import 'package:connect4/helpers/helper.dart';
import 'package:connect4/models/move.dart';
import 'package:connect4/models/player.dart';
import 'package:connect4/widgets/game_over_dialog.dart';
import 'package:connect4/widgets/grid_cell.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  final String title;
  final Player greenPlayer;
  final Player bluePlayer;
  Game({this.title, this.greenPlayer, this.bluePlayer});
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {

  int currentPlayer = 1;

  Random random;
  int n = 7;
  int m = 6;

  int miniMaxDepth = 7;
  int alphaBetaDepth = 9;

  int turns = 0;
  int greenTurns = 0;
  int blueTurns = 0;

  DateTime start;
  DateTime end;
  String greenTurnTime = '';
  String blueTurnTime = '';

  // Testing
  int noOfTests = 50;
  int gameCounter = 1;
  int greenWins = 0;
  int blueWins = 0;

  bool gameOver = false;
  String winText = '';

  List<List<int>> board;

  fillBoard() {
    List<List<int>> b = [];
    for (int i = 0; i < n; i++) {
      b.add([]);
      for (int j = 0; j < m; j++) {
        b[i].add(0);
      }
    }
    setState(() {
      board = b;
    });
  }

  addDisk(int col) async {
    if (gameOver || col == null) return;
    updateTime();
    currentPlayer = currentPlayer == 1 ? 2 : 1;
    for (int i = 0; i < board[col].length; i++) {
      if (board[col][i] == 0) {
        updateStats(col, i);
        if (isGameOver()) {
          finishGame();
        } else {
          start = DateTime.now();
          makeMove();
        }
        break;
      }
    }
  }

  void makeMove() async {
    Future.delayed(Duration(milliseconds: 500), () {
      if (currentPlayer == 1) {
        if (widget.greenPlayer == Player.random) {
          List<int> openCols = getOpenCols(board, m);
          addDisk(openCols[random.nextInt(openCols.length - 1)]);
        } else if (widget.greenPlayer == Player.minimax) {
          Move res = miniMax(board, n, m, miniMaxDepth, true, 1);
          addDisk(res.col);
        } else if (widget.greenPlayer == Player.alphaBeta) {
          Move res = alphaBeta(board, n, m, alphaBetaDepth, -100000000000000, 100000000000000, true, 1);
          addDisk(res.col);
        }
      } else {
        if (widget.bluePlayer == Player.random) {
          List<int> openCols = getOpenCols(board, m);
          addDisk(openCols[random.nextInt(openCols.length - 1)]);
        } else if (widget.bluePlayer == Player.minimax) {
          Move res = miniMax(board, n, m, miniMaxDepth, true, 2);
          addDisk(res.col);
        } else if (widget.bluePlayer == Player.alphaBeta) {
          Move res = alphaBeta(board, n, m, alphaBetaDepth, -100000000000000, 100000000000000, true, 2);
          addDisk(res.col);
        }
      }
    });
  }

  void updateTime() {
    end = DateTime.now();
    if (currentPlayer == 1) {
      setState(() {
        greenTurnTime = '${end.difference(start).inMilliseconds} ms';
      });
    } else {
      setState(() {
        blueTurnTime = '${end.difference(start).inMilliseconds} ms';
      });
    }
  }

  void updateStats(int col, int i) {
    setState(() {
      if (turns % 2 == 0) {
        board[col][i] = 1;
        greenTurns++;
      } else {
        board[col][i] = 2;
        blueTurns++;
      }
      turns++;
    });
  }

  bool isGameOver() {
    int state = checkGameOver(board, n, m);
    return state == 0 ? false : true;
  }

  void finishGame() {
    gameOver = true;
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        winText = turns % 2 == 0 ? 'Blue wins' : 'Green wins';
      });
      // gameOverDialog(context, winText, newGame);
      Future.delayed(Duration(milliseconds: 1000), () {
        nextTest();
      });
    });
  }

  void nextTest() {
    setState(() {
      turns % 2 == 0 ? blueWins++ : greenWins++;
      gameCounter++;
    });
    if (gameCounter <= noOfTests) {
      newGame();
    }
  }

  void newGame() {
    setState(() {
      turns = 0;
      greenTurns = 0;
      blueTurns = 0;
      gameOver = false;
      winText = '';
      greenTurnTime = '';
      blueTurnTime = '';
      currentPlayer = 1;
    });
    fillBoard();
    startGame();
  }

  void startGame() {
    makeMove();
    start = DateTime.now();
  }

  @override
  void initState() {
    super.initState();
    random = new Random();
    fillBoard();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: newGame),
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
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Turn counter: $turns',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Green counter: $greenTurns',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Blue counter: $blueTurns',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Green took $greenTurnTime',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Blue took $blueTurnTime',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Game: ${gameCounter <= noOfTests ? gameCounter : noOfTests}/$noOfTests',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Green wins: $greenWins',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Blue wins: $blueWins',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      winText,
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
                              for (int i = 0; i < board.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    if ((currentPlayer == 1 && widget.greenPlayer == Player.human) || (currentPlayer == 2 && widget.bluePlayer == Player.human)) addDisk(i);
                                  },
                                  child: Column(
                                    children: [
                                      for (int j = board[i].length - 1;
                                          j >= 0;
                                          j--)
                                        GridCell(playerColor: board[i][j])
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
