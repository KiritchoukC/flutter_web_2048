import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipedetector/swipedetector.dart';

import '../../../../core/enums/direction.dart';
import '../../../../core/layouts/default_layout.dart';
import '../../domain/entities/board.dart';
import '../../domain/entities/tile.dart';
import '../bloc/bloc.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '2048',
      body: _buildBody(context),
    );
  }

  AspectRatio _buildBody(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: SwipeDetector(
        onSwipeDown: () {
          BlocProvider.of<GameBloc>(context)
              .add(Move(direction: Direction.down));
        },
        onSwipeUp: () {
          BlocProvider.of<GameBloc>(context).add(Move(direction: Direction.up));
        },
        onSwipeRight: () {
          BlocProvider.of<GameBloc>(context)
              .add(Move(direction: Direction.right));
        },
        onSwipeLeft: () {
          BlocProvider.of<GameBloc>(context)
              .add(Move(direction: Direction.left));
        },
        child: TileBoard(),
      ),
    );
  }
}

class TileBoard extends StatefulWidget {
  @override
  _TileBoardState createState() => _TileBoardState();
}

class _TileBoardState extends State<TileBoard> {
  Widget _buildBoard(Board board) {
    return GridView.count(
      primary: true,
      physics: new NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: board.tiles.map((Tile tile) {
        return TileWidget(tile: tile);
      }).toList(),
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

      return _buildBoard(Board(List<Tile>()));
    });
  }
}

class TileWidget extends StatelessWidget {
  final Tile tile;

  const TileWidget({Key key, this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTile(tile);
  }

  Widget _buildTile(Tile tile) {
    var children = <Widget>[];
    children.add(
      Container(
        color: tile.color,
      ),
    );

    if (tile.value > 0) {
      children.add(
        Text(
          tile.value.toString(),
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Stack(alignment: AlignmentDirectional.topEnd, children: children),
    );
  }
}
