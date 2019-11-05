import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';

abstract class BoardRepository{
  Future<Board> getCurrentBoard();
  Future resetBoard();
  Future<Board> updateBoard(Board board, Direction direction);
}