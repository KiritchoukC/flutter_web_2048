

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/direction.dart';
import '../bloc/bloc.dart';
import 'board_widget.dart';
import 'direction_listener.dart';

class GameWidget extends StatefulWidget {
  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
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
        child: DirectionListener(
          child: BoardWidget(),
          onDown: () {
            print('DOWN');
            _bloc.add(Move(direction: Direction.down));
          },
          onLeft: () {
            print('LEFT');
            _bloc.add(Move(direction: Direction.left));
          },
          onRight: () {
            print('RIGHT');
            _bloc.add(Move(direction: Direction.right));
          },
          onUp: () {
            print('UP');
            _bloc.add(Move(direction: Direction.up));
          },
        ));
  }
}