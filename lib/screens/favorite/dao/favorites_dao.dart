import 'package:sqflite/sqflite.dart';
import 'package:video_games/screens/favorite/models/res_favorite.dart';

class FavoritesDao {
  final Database _db;
  FavoritesDao(this._db);

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY,
        name TEXT,
        photo TEXT,
        release_date TEXT
      )
  ''');
  }

  Future<int> addFavorites(ResFavorite favorite) async {
    return await _db.insert('favorites', favorite.toMap());
  }

  Future<int> removeFavorite(int id) async {
    return await _db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ResFavorite>> getAllFavorite() async {
    final List<Map<String, dynamic>> maps = await _db.query('favorites');
    return List.generate(maps.length, (i) {
      return ResFavorite.fromMap(maps[i]);
    });
  }
}
