import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  DatabaseService._internal();

  static DatabaseService get instance => _instance;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mental_health.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE moods(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            mood TEXT,
            timestamp TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE journals(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            entry TEXT,
            timestamp TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertMood(String mood) async {
    final db = await database;
    return db.insert('moods', {'mood': mood, 'timestamp': DateTime.now().toString()});
  }

  Future<List<Map<String, dynamic>>> fetchMoods() async {
    final db = await database;
    return db.query('moods', orderBy: 'timestamp DESC');
  }

  Future<int> insertJournal(String entry) async {
    final db = await database;
    return db.insert('journals', {'entry': entry, 'timestamp': DateTime.now().toString()});
  }

  Future<List<Map<String, dynamic>>> fetchJournals() async {
    final db = await database;
    return db.query('journals', orderBy: 'timestamp DESC');
  }
}
