import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import 'board_datasource.dart';

const highscoreKey = 'hive_highscore_key';

class HiveBoardDataSource implements BoardDataSource {
  final Box<int> localStorage;

  HiveBoardDataSource({@required this.localStorage}) : assert(localStorage != null);

  @override
  Future<int> getHighscore() async {
    // return score if it exists
    int output = localStorage.get(highscoreKey);
    if (output != null) {
      return output;
    }

    // if no highscore yet, save 0 and return it
    setHighscore(0);
    return 0;
  }

  @override
  Future<void> setHighscore(int score) async {
    localStorage.put(highscoreKey, score);
  }
}
