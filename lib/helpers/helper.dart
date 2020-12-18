import 'dart:math';

int checkGameOver(List<List<int>> board, int n, int m) {
  int horizontal = checkHorizontal(board, n, m);
  int vertical = checkVertical(board, n, m);
  int slashDiagonal = checkSlashDiagonal(board, n, m);
  int backSlashDiagonal = checkBackSlashDiagonal(board, n, m);

  if (horizontal != 0) {
    return horizontal;
  } else if (vertical != 0) {
    return vertical;
  } else if (slashDiagonal != 0) {
    return slashDiagonal;
  } else if (backSlashDiagonal != 0) {
    return backSlashDiagonal;
  }
  return 0;
}

int checkHorizontal(List<List<int>> board, int n, int m) {
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < m - 2; j++) {
      int color = board[j][i];
      if (color == 0) continue;
      if (board[j][i] == color && board[j + 1][i] == color && board[j + 2][i] == color && board[j + 3][i] == color) {
        return color;
      }
    }
  }
  return 0;
}

int checkVertical(List<List<int>> board, int n, int m) {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m - 3; j++) {
      int color = board[i][j];
      if (color == 0) continue;
      if (board[i][j] == color && board[i][j + 1] == color && board[i][j + 2] == color && board[i][j + 3] == color) {
        return color;
      }
    }
  }
  return 0;
}

int checkSlashDiagonal(List<List<int>> board, int n, int m) {
  for (int i = 0; i < n - 3; i++) {
    for (int j = 0; j < m - 3; j++) {
      int color = board[i][j];
      if (color == 0) continue;
      if (board[i][j] == color && board[i + 1][j + 1] == color && board[i + 2][j + 2] == color && board[i + 3][j + 3] == color) {
        return color;
      }
    }
  }
  return 0;
}

int checkBackSlashDiagonal(List<List<int>> board, int n, int m) {
  for (int i = 3; i < n; i++) {
    for (int j = 0; j < m - 3; j++) {
      int color = board[i][j];
      if (color == 0) continue;
      if (board[i][j] == color && board[i - 1][j + 1] == color && board[i - 2][j + 2] == color && board[i - 3][j + 3] == color) {
        return color;
      }
    }
  }
  return 0;
}

List<int> getOpenCols(List<List<int>> board, int m) {
  List<int> openCols = [];
  for (int i = 0; i < board.length; i++) {
    if (board[i][m - 1] == 0) {
      openCols.add(i);
    }
  }
  return openCols;
}

findOpenRow(List<List<int>> board, int col) {
  for (int i = 0; i < board[col].length; i++) {
    if (board[col][i] == 0) {
      return i;
    }
  }
  return 0;
}

List<List<int>> cloneBoard(List<List<int>> board) {
  List<List<int>> clone = [];
  for (int i = 0; i < board.length; i++) {
    clone.add([]);
    for (int j = 0; j < board[i].length; j++) {
      clone[i].add(board[i][j]);
    }
  }
  return clone;
}

void printBoard(List<List<int>> board, int depth, int score) {
  print('___________________________________');
  print('Depth: $depth, score: $score');
  for (int i = 5; i >= 0; i--) {
    List<int> row = [];
    for (int j = 0; j < 7; j++) {
      row.add(board[j][i]);
    }
    print(row);
  }
  print('___________________________________');
}