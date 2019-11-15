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
    return Container(
      color: Colors.grey.shade900,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: board.tiles.width,
        ),
        itemBuilder: (context, index) {
          int x, y = 0;
          x = (index % board.tiles.width);
          y = (index / board.tiles.height).floor();
          return TileWidget(tile: board.tiles.get(x, y));
        },
        itemCount: board.tiles.width * board.tiles.height,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is InitialGame) {
          BlocProvider.of<GameBloc>(context).add(LoadInitialBoard());
        }

        if (state is UpdateBoardEnd) {
          return _buildBoard(state.board);
        }

        return Container();
      },
    );
  }
}
