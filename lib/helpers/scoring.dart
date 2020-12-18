import 'package:connect4/helpers/helper.dart';

final int centerRow = 10;
final int lineOfTwo = 3;
final int lineOfThree = 10;
final int win = 10000;
final int lose = -10000;
final int opponentLineOfTwo = 6;
final int opponentLineOfThree = 15;

getBoardScore(List<List<int>> board, int n, int m, int color) {
  int score = 0;

  score += checkLineOfTwo(board, n, m, color) * lineOfTwo;
  score += checkCenterRow(board, n, m, color) * centerRow;
  score += checkLineOfThree(board, n, m, color) * lineOfThree;
  score -= checkLineOfTwoOpponent(board, n, m, color == 1 ? 2 : 1) * opponentLineOfTwo;
  score -= checkLineOfThreeOpponent(board, n, m, color == 1 ? 2 : 1) * opponentLineOfThree;

  if (checkWinState(board, n, m, color)) {
    score += win;
  } else if (checkLostState(board, n, m, color == 1 ? 2 : 1)) {
    score += lose;
  }

  return score;
}

bool checkWinState(List<List<int>> board, int n, int m, int color) {
  int gameOverState = checkGameOver(board, n, m);
  return gameOverState == color;
}

int checkLineOfTwo(List<List<int>> board, int m, int color, int col) {
  int counter = 0;
  counter += countInHorizontalRow(board, m, color, col, 2, false);
  counter += countInVerticalRow(board, m, color, col, 2, false);
  counter += countInSlashRow(board, m, color, col, 2, false);
  counter += countInBackSlashRow(board, m, color, col, 2, false);
  return counter;
}

int checkLineOfThree(List<List<int>> board, int n, int m, int color) {
  int counter = 0;
  counter += countInHorizontalRow(board, n, m, color, 3, false);
  counter += countInVerticalRow(board, n, m, color, 3, false);
  counter += countInSlashRow(board, n, m, color, 3, false);
  counter += countInBackSlashRow(board, n, m, color, 3, false);
  return counter;
}

int checkLineOfTwoOpponent(List<List<int>> board, int m, int color, int col) {
  int counter = 0;
  counter += countInHorizontalRow(board, m, color, col, 2, true);
  counter += countInVerticalRow(board, m, color, col, 2, true);
  counter += countInSlashRow(board, m, color, col, 2, true);
  counter += countInBackSlashRow(board, m, color, col, 2, true);
  return counter;
}

int checkLineOfThreeOpponent(List<List<int>> board, int n, int m, int color) {
  int counter = 0;
  counter += countInHorizontalRow(board, n, m, color, 3, true);
  counter += countInVerticalRow(board, n, m, color, 3, true);
  counter += countInSlashRow(board, n, m, color, 3, true);
  counter += countInBackSlashRow(board, n, m, color, 3, true);
  return counter;
}

int checkCenterRow(List<List<int>> board, int n, int m, int color) {
  int counter = 0;
  for (int i = 0; i < m; i++) {
    if (board[(n / 2).floor()][i] == color) {
      counter++;
    }
  }
  return counter;
}

bool checkLostState(List<List<int>> board, int n, int m, int color) {
  int counter = 0;
  counter += countInHorizontalRow(board, n, m, color, 4, true);
  counter += countInVerticalRow(board, n, m, color, 4, true);
  counter += countInSlashRow(board, n, m, color, 4, true);
  counter += countInBackSlashRow(board, n, m, color, 4, true);
  return counter > 0;
}

int countInHorizontalRow(List<List<int>> board, int n, int m, int color, int size, bool checkIfValid) {
  int counterGlobal = 0;
  for (int i = 0; i < n - 3; i++) {
    for (int j = 0; j < m - 2; j++) {
      // if (board[i][j] != color) continue;
      int counter = 0;

      for (int k = 0; k < 4; k++) {
        int field = board[i + k][j];
        if (field == color) {
          counter++;
        } else if (field == (color == 1 ? 2 : 1)) {
          counter--;
        }
      }

      if (checkIfValid && counter == size - 1) {
        for (int k = 0; k < 4; k++) {
          int field = board[i + k][j];
          if (field == 0) {
            if (j == 0 || board[i + k][j - 1] != 0) {
              counter++;
            }
          }
        }
      }

      if (counter >= size) counterGlobal++;
    }
  }
  return counterGlobal;
}

int countInVerticalRow(List<List<int>> board, int n, int m, int color, int size, bool checkIfValid) {
  int counterGlobal = 0;
  for (int i = 0; i < n - 3; i++) {
    for (int j = 0; j < m - 3; j++) {
      // if (board[i][j] != color) continue;
      int counter = 0;

      for (int k = 0; k < 4; k++) {
        int field = board[i][j + k];
        if (field == color) {
          counter++;
        } else if (field == (color == 1 ? 2 : 1)) {
          counter--;
        }
      }

      if (checkIfValid && counter == size - 1) {
        for (int k = 0; k < 4; k++) {
          int field = board[i][j + k];
          if (field == 0) {
            counter++;
          }
        }
      }

      if (counter >= size) counterGlobal++;
    }
  }
  
  return counterGlobal;
}

int countInSlashRow(List<List<int>> board, int n, int m, int color, int size, bool checkIfValid) {
  int counterGlobal = 0;
  for (int i = 0; i < n - 3; i++) {
    for (int j = 0; j < m - 3; j++) {
      // if (board[i][j] != color) continue;
      int counter = 0;

      for (int k = 0; k < 4; k++) {
        int field = board[i + k][j + k];
        if (field == color) {
          counter++;
        } else if (field == (color == 1 ? 2 : 1)) {
          counter--;
        }
      }

      if (checkIfValid && counter == size - 1) {
        for (int k = 0; k < 4; k++) {
          int field = board[i + k][j + k];
          if (field == 0) {
            if (j == 0 || board[i + k][j] != 0) {
              counter++;
            }
          }
        }
      }

      if (counter >= size) counterGlobal++;
    }
  }
  return counterGlobal;
}

int countInBackSlashRow(List<List<int>> board, int n, int m, int color, int size, bool checkIfValid) {
  int counterGlobal = 0;
  for (int i = 3; i < n - 3; i++) {
    for (int j = 0; j < m - 3; j++) {
      // if (board[i][j] != color) continue;
      int counter = 0;

      for (int k = 0; k < 4; k++) {
        int field = board[i - k][j + k];
        if (field == color) {
          counter++;
        } else if (field == (color == 1 ? 2 : 1)) {
          counter--;
        }
      }

      if (checkIfValid && counter == size - 1) {
        for (int k = 0; k < 4; k++) {
          int field = board[i - k][j + k];
          if (field == 0) {
            if (j == 0 || board[i - k][j] != 0) {
              counter++;
            }
          }
        }
      }

      if (counter >= size) counterGlobal++;
    }
  }
  return counterGlobal;
}
