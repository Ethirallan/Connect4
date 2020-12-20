# Connect 4

A classic game, written in Flutter. The main goal of this project was implementation of the minimax algorithm and alphabeta pruning. Side goals were building the app using specific packages: [flutter_hooks](https://pub.dev/packages/flutter_hooks), [hooks_riverpod](https://pub.dev/packages/hooks_riverpod) and to deploy the app on the web in the end.

Web app is hosted [here](http://connect4.ethirallan.com/).

## Features

Multiple game modes:
- Player VS Player
- Player VS AI

Testing env for compering multiple algorithms:
- random
- minimax
- minimax with alphabeta pruning

## Running

First thing first, you will need Flutter SDK installed on you machine. If you haven't done that yet, you should head [here](https://flutter.dev/docs/get-started/install) first and follow the instructions.
_Note: If you want to build and run for web, at the time of writting, you will need to switch to beta channel of SDK!_

For running the app you need to have at lease one connected device (Andoid phone/emulator, iOS device/simulator or a webserver). Available devices can we listed with:
```zsh
flutter devices
```  
After that you can run the app with (optional flag: `--release` - run production build):
```zsh
flutter run
``` 
To make build silmply run next command (where platform is one of: apk/ios/web):
```zsh
flutter build platform --release
```  

