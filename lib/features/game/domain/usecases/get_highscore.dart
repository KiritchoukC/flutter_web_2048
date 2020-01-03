import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/board_repository.dart';

class GetHighscore implements UseCase<int, NoParams> {
  final BoardRepository boardRepository;

  GetHighscore({@required this.boardRepository}) : assert(boardRepository != null);
  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return Right(await boardRepository.getHighscore());
  }
}
