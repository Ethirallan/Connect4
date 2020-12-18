import 'dart:math';

import 'package:connect4/helpers/helper.dart';
import 'package:connect4/helpers/scoring.dart';
import 'package:connect4/models/move.dart';

Random random = new Random();

Move alphaBeta(List<List<int>> board, int n, int m, int depth, int alpha, int beta, bool maximizingPlayer, int player) {
  List<int> openCols = getOpenCols(board, m);
  int gameOver = checkGameOver(board, n, m);
  bool isTerminal = openCols.length == 0 || (gameOver == 0 ? false : true);

  if (depth == 0 || isTerminal) {
    if (isTerminal) {
      if (gameOver == player) {
        return Move(null, 100000000000000);
      } else {
        return Move(null, -100000000000000);
      }
    } else {
      return Move(null, getBoardScore(board, n, m, player));
    }
  } else if (maximizingPlayer) {
    Move bestMove;
    if (openCols.length > 1) {
      bestMove = new Move(openCols[random.nextInt(openCols.length - 1)], -100000000000000);
    } else {
      bestMove = new Move(openCols[0], -100000000000000);
    }

    for (int col in openCols) {
      List<List<int>> clone = cloneBoard(board);
      int row = findOpenRow(board, col);

      clone[col][row] = player;

      Move possibleMove = alphaBeta(clone, n, m, depth - 1, alpha, beta, false, player);
      if (possibleMove.score > bestMove.score) {
        bestMove.score = possibleMove.score;
        bestMove.col = col;
      }
      alpha = max(alpha, bestMove.score);
      if (alpha >= beta) {
        break;
      }
      if (alpha >= beta) {
        print('after break');
      }
    }
    return bestMove;
  } else {
    Move bestMove;
    if (openCols.length > 1) {
      bestMove = new Move(openCols[random.nextInt(openCols.length - 1)], 100000000000000);
    } else {
      bestMove = new Move(openCols[0], 100000000000000);
    }

    for (int col in openCols) {
      List<List<int>> clone = cloneBoard(board);
      int row = findOpenRow(board, col);

      clone[col][row] = (player == 1 ? 2 : 1);

      Move possibleMove = alphaBeta(clone, n, m, depth - 1, alpha, beta, true, player);
      if (possibleMove.score < bestMove.score) {
        bestMove.score = possibleMove.score;
        bestMove.col = col;
      }
      beta = min(beta, bestMove.score);
      if (alpha >= beta) {
        break;
      }
    }
    return bestMove;
  }
}