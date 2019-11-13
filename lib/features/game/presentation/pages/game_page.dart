import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_2048/core/util/tile_color_converter.dart';
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
      body: GameBody(),
    );
  }
}

class GameBody extends StatefulWidget {
  @override
  _GameBodyState createState() => _GameBodyState();
}

class _GameBodyState extends State<GameBody> {
  GameBloc _bloc;
  FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<GameBloc>(context);
    FocusScope.of(context).requestFocus(_focusNode);
    return AspectRatio(
      aspectRatio: 1,
      child: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey.keyId == KeyCode.DOWN) {
              print('key DOWN');
              _bloc.add(Move(direction: Direction.down));
            }
            if (event.logicalKey.keyId == KeyCode.UP) {
              print('key UP');
              _bloc.add(Move(direction: Direction.up));
            }
            if (event.logicalKey.keyId == KeyCode.RIGHT) {
              print('key RIGHT');
              _bloc.add(Move(direction: Direction.right));
            }
            if (event.logicalKey.keyId == KeyCode.LEFT) {
              print('key LEFT');
              _bloc.add(Move(direction: Direction.left));
            }
          }
        },
        child: GestureDetector(
          onTap: () {
            print(_focusNode);
            FocusScope.of(context).requestFocus(_focusNode);
            print(_focusNode);
          },
          child: SwipeDetector(
            onSwipeDown: () {
              _bloc.add(Move(direction: Direction.down));
            },
            onSwipeUp: () {
              _bloc.add(Move(direction: Direction.up));
            },
            onSwipeRight: () {
              _bloc.add(Move(direction: Direction.right));
            },
            onSwipeLeft: () {
              _bloc.add(Move(direction: Direction.left));
            },
            child: TileBoard(),
          ),
        ),
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
        color: TileColorConverter.mapTileValueToColor(tile?.value),
      ),
    );

    if (tile != null) {
      children.add(
        Text(
          tile.value.toString(),
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
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
