import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_web_2048/core/enums/direction.dart';
import 'package:flutter_web_2048/core/error/failures.dart';
import 'package:flutter_web_2048/core/usecases/usecase.dart';
import 'package:flutter_web_2048/features/game/domain/entities/board.dart';
import 'package:meta/meta.dart';

class UpdateBoard implements UseCase<Board, Params>{
  @override
  Future<Either<Failure, Board>> call(Params params) async {
    return null;
  }
  
}

class Params extends Equatable {
  final Direction direction;

  Params({@required this.direction});

  @override
  List<Object> get props => [direction];
}
