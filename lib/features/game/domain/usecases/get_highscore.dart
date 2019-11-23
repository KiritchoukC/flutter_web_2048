import 'package:meta/meta.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/board_repository.dart';

class GetHighscore implements UseCase<int, NoParams> {
  final BoardRepository boardRepository;

  GetHighscore({@required this.boardRepository})
      : assert(boardRepository != null);
  @override
  Future<int> call(NoParams params) async {
    return await boardRepository.getHighscore();
  }
}
