abstract class BoardDataSource {
  Future<void> setHighscore(int score);
  Future<int> getHighscore();
}
