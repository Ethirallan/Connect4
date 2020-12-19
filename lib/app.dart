import 'package:connect4/pages/main_menu.dart';
import 'package:connect4/providers/board_change_notifier.dart';
import 'package:connect4/providers/board_params_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final boardParamsStateProvider = StateNotifierProvider<BoardParamsState>((ref) {
  return BoardParamsState();
});

final boardProvider = ChangeNotifierProvider<BoardChangeNotifier>((ref) {
  final params = ref.watch(boardParamsStateProvider.state);
  BoardChangeNotifier boardProvider = new BoardChangeNotifier();
  boardProvider.init(
    n: params.n,
    m: params.m,
    miniMaxDepth: params.miniMaxDepth,
    alphaBetaDepth: params.alphaBetaDepth,
    testing: params.testing,
    noOfTests: params.noOfTests,
    greenPlayer: params.greenPlayer,
    bluePlayer: params.bluePlayer,
  );
  boardProvider.newGame();
  return boardProvider;
});

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainMenu(),
    );
  }
}