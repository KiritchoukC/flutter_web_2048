import '../../../../core/enums/direction.dart';
import '../entities/board.dart';

abstract class BoardRepository{
  Future<Board> getCurrentBoard();
  Future resetBoard();
  Future<Board> updateBoard(Board board, Direction direction);
}