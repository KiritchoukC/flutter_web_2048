import 'package:equatable/equatable.dart';
import 'package:flutter_web_2048/features/game/domain/repositories/board_repository.dart';
import 'package:meta/meta.dart';

import '../../../../core/enums/direction.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/board.dart';

class UpdateBoard implements UseCase<Board, Params> {
  final BoardRepository boardRepository;

  UpdateBoard({@required this.boardRepository})
      : assert(boardRepository != null);

  @override
  Future<Board> call(Params params) async {
    return null;
  }
}

class Params extends Equatable {
  final Direction direction;

  Params({@required this.direction});

  @override
  List<Object> get props => [direction];
}
