import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:video_games/screens/favorite/dao/favorites_dao.dart';

class SqfliteHelper {
  static const _databaseName = 'videogames.db';
  static const _databaseVersion = 12;

  SqfliteHelper._privateConstructor();
  static final SqfliteHelper instance = SqfliteHelper._privateConstructor();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await FavoritesDao.createTable(db);
  }
}
