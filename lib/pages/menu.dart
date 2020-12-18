import 'package:connect4/models/player.dart';
import 'package:connect4/pages/board.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main menu'),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        child: Center(
          child: SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RaisedButton(
                  child: Text('Random VS Minimax'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Game(
                        title: 'Random VS Minimax',
                        greenPlayer: Player.random,
                        bluePlayer: Player.minimax,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Random VS AlphaBeta'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Game(
                        title: 'Random VS AlphaBeta',
                        greenPlayer: Player.random,
                        bluePlayer: Player.alphaBeta,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Minimax VS AlphaBeta'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Game(
                        title: 'Minimax VS AlphaBeta',
                        greenPlayer: Player.minimax,
                        bluePlayer: Player.alphaBeta,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Minimax VS Random'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Game(
                        title: 'Minimax VS Random',
                        greenPlayer: Player.minimax,
                        bluePlayer: Player.random,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('AlphaBeta VS Random'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Game(
                        title: 'AlphaBeta VS Random',
                        greenPlayer: Player.alphaBeta,
                        bluePlayer: Player.random,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('AlphaBeta VS Minimax'),
                  color: Colors.blueGrey[700],
                  textColor: Colors.white,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Game(
                        title: 'AlphaBeta VS Minimax',
                        greenPlayer: Player.alphaBeta,
                        bluePlayer: Player.minimax,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
