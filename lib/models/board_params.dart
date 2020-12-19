import 'package:connect4/models/player.dart';

class BoardParams {
  int n;
  int m;
  int miniMaxDepth;
  int alphaBetaDepth;
  bool testing;
  int noOfTests;
  Player greenPlayer;
  Player bluePlayer;

  BoardParams(
      {this.n = 7,
        this.m = 6,
        this.miniMaxDepth = 5,
        this.alphaBetaDepth = 7,
        this.testing = true,
        this.noOfTests = 10,
        this.greenPlayer = Player.minimax,
        this.bluePlayer = Player.alphaBeta});
}
