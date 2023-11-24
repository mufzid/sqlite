import 'package:flutter_api/model/employe_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database _database;

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (Database db, int version) {
        return db.execute('''
             CREATE TABLE employee(
          id INTEGER PRIMARY KEY,
          employeeName TEXT,
          employeeSalary TEXT,
          employeeAge INTEGER,
          profileImage TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> insertData(Datum data) async {
    await _database.insert('employee', data.toMap());
  }

  Future<List<Datum>> getit() async {
    final List<Map<String, dynamic>> maps = await _database.query('employee');
    return List.generate(maps.length, (i) {
      return Datum(
          id: maps[i]['id'],
          employeeName: maps[i]['employeeName'],
          employeeSalary: maps[i]['employeeSalary'],
          employeeAge: maps[i]['employeeAge'],
          profileImage: maps[i]['profileImage']);
    });
  }
}
