import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';

abstract class BoardRepository{
  Future<Board> getInitialBoard();
  Future<Board> updateBoard(Direction direction);
}