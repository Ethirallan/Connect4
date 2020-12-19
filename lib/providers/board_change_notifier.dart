import 'dart:math';
import 'package:connect4/algorithms/alphabeta.dart';
import 'package:connect4/algorithms/minimax.dart';
import 'package:connect4/helpers/helper.dart';
import 'package:connect4/models/move.dart';
import 'package:connect4/models/player.dart';
import 'package:connect4/widgets/game_over_dialog.dart';
import 'package:flutter/material.dart';

class BoardChangeNotifier extends ChangeNotifier {
  final GlobalKey gameKey = new GlobalKey();
  List<List<int>> _board;

  // Settings
  int _n;
  int _m;
  int _miniMaxDepth;
  int _alphaBetaDepth;
  Player _greenPlayer;
  Player _bluePlayer;

  // Game state
  int _currentPlayer = 1;
  int _turns = 0;
  int _greenTurns = 0;
  int _blueTurns = 0;
  bool _gameOver = false;
  String _winText = '';

  // Time
  DateTime _startDateTime;
  DateTime _endDateTime;
  String _greenTurnTime = '';
  String _blueTurnTime = '';

  // Testing
  bool _testing;
  int _noOfTests;
  int _gameCounter = 1;
  int _greenWins = 0;
  int _blueWins = 0;

  // Utils
  Random _random = new Random();
  bool _disposed = false;

  BoardChangeNotifier();

  void init({
    int n,
    int m,
    int miniMaxDepth,
    int alphaBetaDepth,
    bool testing,
    int noOfTests,
    Player greenPlayer,
    Player bluePlayer,
  }) {
    _n = n;
    _m = m;
    _miniMaxDepth = miniMaxDepth;
    _alphaBetaDepth = alphaBetaDepth;
    _testing = testing;
    _noOfTests = noOfTests;
    _greenPlayer = greenPlayer;
    _bluePlayer = bluePlayer;
  }

  void newGame() {
    _swapPlayers();
    _turns = 0;
    _greenTurns = 0;
    _blueTurns = 0;
    _gameOver = false;
    _winText = '';
    _greenTurnTime = '';
    _blueTurnTime = '';
    _currentPlayer = 1;
    _fillBoard();
    notifyListeners();
    _startGame();
  }

  void _swapPlayers() {
    if (!_testing) {
      Player tempPlayer = _greenPlayer;
      _greenPlayer = _bluePlayer;
      _bluePlayer = tempPlayer;
    }
  }

  void _fillBoard() {
    List<List<int>> b = [];
    for (int i = 0; i < _n; i++) {
      b.add([]);
      for (int j = 0; j < _m; j++) {
        b[i].add(0);
      }
    }
    _board = b;
  }

  void _startGame() {
    _makeMove();
    _startDateTime = DateTime.now();
  }

  void _makeMove() async {
    Future.delayed(Duration(milliseconds: 500), () {
      if (_currentPlayer == 1) {
        if (_greenPlayer == Player.random) {
          List<int> openCols = getOpenCols(_board, _m);
          addDisk(openCols[_random.nextInt(openCols.length - 1)]);
        } else if (_greenPlayer == Player.minimax) {
          Move res = miniMax(_board, _n, _m, _miniMaxDepth, true, 1);
          addDisk(res.col);
        } else if (_greenPlayer == Player.alphaBeta) {
          Move res = alphaBeta(_board, _n, _m, _alphaBetaDepth,
              -100000000000000, 100000000000000, true, 1);
          addDisk(res.col);
        }
      } else {
        if (_bluePlayer == Player.random) {
          List<int> openCols = getOpenCols(_board, _m);
          addDisk(openCols[_random.nextInt(openCols.length - 1)]);
        } else if (_bluePlayer == Player.minimax) {
          Move res = miniMax(_board, _n, _m, _miniMaxDepth, true, 2);
          addDisk(res.col);
        } else if (_bluePlayer == Player.alphaBeta) {
          Move res = alphaBeta(_board, _n, _m, _alphaBetaDepth,
              -100000000000000, 100000000000000, true, 2);
          addDisk(res.col);
        }
      }
    });
  }

  void addDisk(int col) async {
    if (_gameOver || col == null) return;
    _updateTime();
    _currentPlayer = _currentPlayer == 1 ? 2 : 1;
    for (int i = 0; i < _board[col].length; i++) {
      if (_board[col][i] == 0) {
        _updateStats(col, i);
        notifyListeners();
        if (_isGameOver()) {
          _finishGame();
        } else {
          _startDateTime = DateTime.now();
          _makeMove();
        }
        break;
      }
    }
  }

  void _updateTime() {
    _endDateTime = DateTime.now();
    if (_currentPlayer == 1) {
      _greenTurnTime = '${_endDateTime.difference(_startDateTime).inMilliseconds} ms';
    } else {
      _blueTurnTime = '${_endDateTime.difference(_startDateTime).inMilliseconds} ms';
    }
  }

  void _updateStats(int col, int i) {
    if (_turns % 2 == 0) {
      _board[col][i] = 1;
      _greenTurns++;
    } else {
      _board[col][i] = 2;
      _blueTurns++;
    }
    _turns++;
  }

  bool _isGameOver() {
    if (getOpenCols(_board, _m).length == 0) return true;
    int state = checkGameOver(_board, _n, _m);
    return state == 0 ? false : true;
  }

  void _finishGame() {
    _gameOver = true;

    Future.delayed(Duration(milliseconds: 300), () {
      if (getOpenCols(_board, _m).length != 0) {
        _winText = _turns % 2 == 0 ? 'Blue wins' : 'Green wins';
      } else {
        _winText = 'Draw';
      }
      notifyListeners();
      if (_testing) {
        Future.delayed(Duration(milliseconds: 1000), () {
          _nextTest();
        });
      } else {
        gameOverDialog(gameKey.currentContext, winText, newGame);
      }
    });
  }

  void _nextTest() {
    if (getOpenCols(_board, _m).length != 0) {
      _turns % 2 == 0 ? _blueWins++ : _greenWins++;
    }
    _gameCounter++;
    notifyListeners();
    if (_gameCounter <= _noOfTests) {
      newGame();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  List<List<int>> get board => _board;

  int get blueWins => _blueWins;

  int get greenWins => _greenWins;

  int get gameCounter => _gameCounter;

  int get noOfTests => _noOfTests;

  String get greenTurnTime => _greenTurnTime;

  String get winText => _winText;

  int get blueTurns => _blueTurns;

  int get greenTurns => _greenTurns;

  int get turns => _turns;

  int get currentPlayer => _currentPlayer;

  Player get greenPlayer => _greenPlayer;

  Player get bluePlayer => _bluePlayer;

  String get blueTurnTime => _blueTurnTime;

  bool get testing => _testing;

  bool get gameOver => _gameOver;
}