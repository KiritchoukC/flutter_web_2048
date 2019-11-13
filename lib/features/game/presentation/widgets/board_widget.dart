

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/board.dart';
import '../bloc/bloc.dart';
import 'tile_widget.dart';

class BoardWidget extends StatefulWidget {
  @override
  _BoardWidgetState createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  Widget _buildBoard(Board board) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: board.tiles.length,
      ),
      itemBuilder: (context, index) {
        int x, y = 0;
        x = (index / board.tiles.length).floor();
        y = (index % board.tiles.length);
        return TileWidget(tile: board.tiles[x][y]);
      },
      itemCount: board.tiles.length * board.tiles.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(builder: (context, state) {
      if (state is InitialGame) {
        BlocProvider.of<GameBloc>(context).add(LoadInitialBoard());
      }

      if (state is UpdateBoardEnd) {
        return _buildBoard(state.board);
      }

      return Container();
    });
  }
}
