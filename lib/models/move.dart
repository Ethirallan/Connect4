class Move {
  int _col;
  int _score;

  Move(this._col, this._score);

  int get score => _score;

  set score(int value) {
    _score = value;
  }

  int get col => _col;

  set col(int value) {
    _col = value;
  }
}