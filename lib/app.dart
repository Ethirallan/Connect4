import 'package:connect4/helpers/swatch_helper.dart';
import 'package:connect4/pages/main_menu.dart';
import 'package:connect4/providers/board_change_notifier.dart';
import 'package:connect4/providers/board_params_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: createMaterialColor(Colors.greenAccent[700]),
        primaryColor: Colors.greenAccent[700],
        accentColor: Colors.greenAccent[700],
        fontFamily: 'Neue Haas Grotesk Display Pro',
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          height: 64,
          buttonColor: Colors.greenAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(fontSize: 26.0, color: Colors.grey[900]),
          ),
        ),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 20.0, fontFamily: 'Neue Haas Grotesk Display Pro'),
          button: TextStyle(fontSize: 26, fontFamily: 'Neue Haas Grotesk Display Pro', color: Colors.grey[900]),
        ),
      ),
      builder: (context, child) => Container(
        color: Colors.grey[900],
        child: ResponsiveWrapper.builder(
          child,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
        ),
      ),
      home: MainMenu(),
    );
  }
}
