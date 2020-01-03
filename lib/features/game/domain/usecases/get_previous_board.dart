import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/board.dart';
import '../repositories/board_repository.dart';

class GetPreviousBoard implements UseCase<Board, NoParams> {
  final BoardRepository boardRepository;

  GetPreviousBoard({@required this.boardRepository}) : assert(boardRepository != null);
  @override
  Future<Either<Failure, Board>> call(NoParams params) async {
    return Right(await boardRepository.getPreviousBoard());
  }
}
