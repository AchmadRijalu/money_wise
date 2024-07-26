
import 'package:money_wise/models/expense_model.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseDb {
  static ExpenseDb? _instance;
  static Database? _database;

  ExpenseDb._internal() {
    _instance = this;
  }

  factory ExpenseDb() => _instance ?? ExpenseDb._internal();

  // Database Key
  static const String _expenseKey = "expense";

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase("$path/expenseapp.db", onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE $_expenseKey(
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        category TEXT, 
        imageCategory TEXT,
        date TEXT,
        amount TEXT,
        colorCategory INTEGER
      )
    ''');
    }, version: 1);
    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<void> insertExpense(ExpenseModel expense) async {
    final db = await database;
    if (db == null) {
      throw Exception("Database is not initialized");
    }

    await db.insert(
      _expenseKey,
      expense.toDatabaseJson(),
    );
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    final db = await database;
    if (db == null) {
      throw Exception("Database is not initialized");
    }
    List<Map<String, dynamic>> results = await db.query(_expenseKey);
    return results.map((res) => ExpenseModel.fromDatabaseJson(res)).toList();
  }

  Future<void> deleteExpense(int id) async {
    final db = await database;
    if (db == null) {
      throw Exception("Database is not initialized");
    }

    await db.delete(
      _expenseKey,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    final db = await database;
    if (db == null) {
      throw Exception("Database is not initialized");
    }

    await db.update(
      _expenseKey,
      expense.toDatabaseJson(),
      where: "id = ?",
      whereArgs: [expense.id],
    );
  }
}
