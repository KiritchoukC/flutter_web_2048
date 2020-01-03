import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/board.dart';
import '../repositories/board_repository.dart';

class ResetBoard implements UseCase<Board, NoParams> {
  final BoardRepository boardRepository;

  ResetBoard({@required this.boardRepository}) : assert(boardRepository != null);
  @override
  Future<Either<Failure, Board>> call(NoParams params) async {
    // reset board
    await boardRepository.resetBoard();
    // return a new board
    return Right(await boardRepository.getCurrentBoard());
  }
}
