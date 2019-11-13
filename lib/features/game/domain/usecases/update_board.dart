import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/enums/direction.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/board.dart';
import '../repositories/board_repository.dart';

class UpdateBoard implements UseCase<Board, Params> {
  final BoardRepository boardRepository;

  UpdateBoard({@required this.boardRepository})
      : assert(boardRepository != null);

  @override
  Future<Board> call(Params params) async {
    return await boardRepository.updateBoard(params.board, params.direction);
  }
}

class Params extends Equatable {
  final Direction direction;
  final Board board;

  Params({
    @required this.direction,
    @required this.board,
  });

  @override
  List<Object> get props => [direction, board];
}
