import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_web_2048/features/game/domain/entities/tile.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/board.dart';

class GenerateInitialBoard implements UseCase<Board, NoParams> {
  @override
  Future<Either<Failure, Board>> call(NoParams params) async {
    try {
      int randomIndex = _getRandomIndex();
      var tiles = _generateTiles(randomIndex);
      return Right(Board(tiles));
    } catch (e) {
      return Left(
        ApplicationFailure(
          message: 'Something went wrong while generating the initial board',
        ),
      );
    }
  }

  /// Get a random int between 0 and 15
  int _getRandomIndex() {
    var random = Random();
    return random.nextInt(16);
  }

  /// Generate the board tiles with the first tile positionned at the given index
  List<Tile> _generateTiles(int firstTileIndex) {
    return List<Tile>.generate(
      16,
      (index) {
        if (index == firstTileIndex) {
          return Tile(2);
        }
        return Tile(0);
      },
      growable: false,
    );
  }
}
