import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/board.dart';

class GenerateInitialBoard implements UseCase<Board, NoParams>{
  @override
  Future<Either<Failure, Board>> call(NoParams params) async {
    return null;
  }
}