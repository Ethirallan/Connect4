import 'package:connect4/models/board_params.dart';
import 'package:connect4/models/player.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BoardParamsState extends StateNotifier<BoardParams> {
  BoardParamsState(): super(BoardParams());

  void prepareGame(Player greenPlayer, Player bluePlayer, bool testing) {
    state = BoardParams(greenPlayer: greenPlayer, bluePlayer: bluePlayer, testing: testing, noOfTests: state.noOfTests, miniMaxDepth: state.miniMaxDepth, alphaBetaDepth: state.alphaBetaDepth);
  }

  void swapPlayers() {
    if (!state.testing) {
      state = BoardParams(greenPlayer: state.bluePlayer, bluePlayer: state.greenPlayer, testing: state.testing, noOfTests: state.noOfTests, miniMaxDepth: state.miniMaxDepth, alphaBetaDepth: state.alphaBetaDepth);
    }
  }

  void changeNoOfTests(int noOfTests) {
    state = BoardParams(greenPlayer: state.greenPlayer, bluePlayer: state.bluePlayer, testing: state.testing, noOfTests: noOfTests, miniMaxDepth: state.miniMaxDepth, alphaBetaDepth: state.alphaBetaDepth);
  }

  void changeMiniMaxDepth(int newDepth) {
    state = BoardParams(greenPlayer: state.greenPlayer, bluePlayer: state.bluePlayer, testing: state.testing, noOfTests: state.noOfTests, miniMaxDepth: newDepth, alphaBetaDepth: state.alphaBetaDepth);
  }

  void changeAlphaBetaDepth(int newDepth) {
    state = BoardParams(greenPlayer: state.greenPlayer, bluePlayer: state.bluePlayer, testing: state.testing, noOfTests: state.noOfTests, miniMaxDepth: state.miniMaxDepth, alphaBetaDepth: newDepth);
  }

  void reset() {
    state = BoardParams();
  }
}
