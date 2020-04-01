import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/board.dart';
import '../bloc/bloc.dart';
import 'tiles/tile_widget.dart';

class BoardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      condition: (previousState, state) {
        if (state is HighscoreLoadedState) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state is InitialGameState) {
          BlocProvider.of<GameBloc>(context).add(LoadInitialBoardEvent());
        }

        if (state is UpdateBoardEndState) {
          return GameBoardWidget(board: state.board);
        }

        if (state is GameOverState) {
          return GameBoardWidget(board: state.board, isOver: true);
        }

        return Container();
      },
    );
  }
}

class GameBoardWidget extends StatelessWidget {
  final Board board;
  final bool isOver;
  final List<Widget> _children = <Widget>[];

  GameBoardWidget({
    Key key,
    @required this.board,
    this.isOver = false,
  }) : super(key: key) {
    // add the grid
    _children.add(GridWidget(board: board));
    if (isOver) {
      // if game over add the overlay
      _children.add(GameOverOverlay());
    }
  }

  @override
  Widget build(BuildContext context) => Stack(children: _children);
}

class GridWidget extends StatelessWidget {
  final Board board;

  const GridWidget({
    Key key,
    @required this.board,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade900,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: board.tiles.width,
        ),
        itemBuilder: (context, index) {
          int x, y = 0;
          x = index % board.tiles.width;
          y = (index / board.tiles.height).floor();
          final tile = board.tiles.get(x, y);
          return TileWidget(tile: tile);
        },
        itemCount: board.tiles.width * board.tiles.height,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}

class GameOverOverlay extends StatefulWidget {
  @override
  _GameOverOverlayState createState() => _GameOverOverlayState();
}

class _GameOverOverlayState extends State<GameOverOverlay> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        color: const Color.fromARGB(50, 0, 0, 0),
        alignment: Alignment.center,
        child: const Text(
          'GAME OVER',
          semanticsLabel: 'The game is over',
          style: TextStyle(color: Colors.white, fontSize: 40.0),
        ),
      ),
    );
  }
}
