import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_2048/core/usecases/usecase.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/generate_initial_board.dart';

void main(){
  GenerateInitialBoard usecase;

  setUp((){
    usecase = GenerateInitialBoard();
  });

  group('GenerateInitialBoard', (){
    test('should return a list of 16 items', ()async {
      // ARRANGE
      
      // ACT
      var actual = await usecase(NoParams());
      // ASSERT
      actual.fold((_){}, (board){
        expect(board.tiles.length, 16);
      });
    });
  });
}
