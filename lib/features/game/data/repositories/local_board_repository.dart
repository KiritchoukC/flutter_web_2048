import 'package:meta/meta.dart';

import '../../../../core/enums/direction.dart';
import '../../domain/entities/board.dart';
import '../../domain/entities/tile.dart';
import '../../domain/entities/traversal.dart';
import '../../domain/entities/vector.dart';
import '../../domain/repositories/board_repository.dart';
import '../datasources/board_datasource.dart';

class LocalBoardRepository implements BoardRepository {
  final BoardDataSource datasource;

  Board _currentBoard;

  LocalBoardRepository({@required this.datasource}) : assert(datasource != null);

  /// Get the starting board with a single random '2' tile in it.
  @override
  Future<Board> getCurrentBoard() async {
    // Initialize the current board if it does not exist yet.
    _currentBoard = _currentBoard ?? Board.initialize();

    return _currentBoard;
  }

  /// Update the [board] by moving the tiles in the given [direction]
  @override
  Future<Board> updateBoard(Board board, Direction direction) async {
    final int size = 4;
    final vector = Vector.fromDirection(direction);
    final traversal = Traversal.fromVector(vector, size);
    bool hasBoardMoved = false;

    // reset merged tiles
    board.resetMergedTiles();

    // traverse the grid
    for (var i = 0; i < size; i++) {
      int x = traversal.x[i];
      for (var j = 0; j < size; j++) {
        int y = traversal.y[j];

        // get the tile at the current position [x][y]
        var currentTile = board.tiles.get(x, y);

        // skip empty cell
        if (currentTile == null) {
          continue;
        }

        // get the tile final destination
        var destination = board.getTileDestination(currentTile, vector);

        // skip if tile does not move
        if (!destination.hasMoved) {
          continue;
        }

        // check if the board moved only if it has not been moved yet
        hasBoardMoved = hasBoardMoved || destination.hasMoved;

        // empty the current cell
        board.tiles.set(currentTile.x, currentTile.y, null);

        // get the new tile
        final newTile = Tile.fromDestination(currentTile.value, destination);

        // move the tile in its new cell
        board.tiles.set(destination.x, destination.y, newTile);
      }
    }

    if (hasBoardMoved) {
      // if the board has moved, add a new tile randomly
      board.addRandomTile();
    }

    // update the board score
    board.updateScore();

    // persist high score if game is over
    if (board.over) {
      await _updateHighscore(board.score);
    }

    return board;
  }

  @override
  Future<void> resetBoard() async {
    _currentBoard = null;
  }

  /// get persisted high score
  Future<int> getHighscore() async {
    // get high score from data source
    return datasource.getHighscore();
  }

  Future<void> _updateHighscore(int highscore) async {
    // get the current highscore
    final currentHighscore = await getHighscore();

    print({
      'currentHighscore': currentHighscore,
      'newHighscore': highscore,
      'update': currentHighscore < highscore,
    });

    if (currentHighscore < highscore) {
      print('called');
      // if the new highscore is greater than the current one then save it
      await datasource.setHighscore(highscore);
    }
  }
}
