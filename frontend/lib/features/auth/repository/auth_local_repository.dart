import 'package:frontend/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AuthLocalRepository {
  String tableName = "users";

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    final dBpath = await getDatabasesPath();
    final path = join(dBpath, "auth.db");
    return openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute('''CREATE TABLE $tableName
           (id TEXT PRIMARY KEY, 
           email TEXT not null, 
           name TEXT not null, 
           token TEXT not null, 
           createdAt int not null, 
           updatedAt int not null)''');
    });
  }

  Future<void> insertUser(UserModel userModel) async {
    final db = await database;
    await db.insert(tableName, userModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<UserModel?> getUser() async {
    final db = await database;
    final result = await db.query(tableName);
    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }
}
