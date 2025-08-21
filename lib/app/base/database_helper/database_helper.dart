import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:newapps_task/app/screens/home/model/employee_management_response.dart';

class DatabaseHelper {
  late Database _database;

  Future<void> openDB() async {
    _database = await openDatabase(
        join(await getDatabasesPath(), 'employee_database.db'),
        onCreate: (db, version) {
          return db.execute("""
                CREATE TABLE employee_table (
                    id INTEGER PRIMARY KEY,
                    email STRING UNIQUE,
                    first_name STRING,
                    last_name STRING, avatar STRING)
              """);
        }, version: 1);
  }

  Future<void> insertData(Datum data) async {
    await _database.insert('employee_table', data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertAllData(List<Datum> data) async {
    for (var info in data) {
      await _database.insert('employee_table', info.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  getEmployeeDetails(int id) async {
    var employeeData =
    await _database.rawQuery("SELECT * FROM employee_table WHERE id=$id");
    debugPrint("Employee Data : $employeeData");
    return employeeData;
  }

  Future<List<Datum>> getData() async {
    final List<Map<String, dynamic>> maps =
    await _database.query('employee_table');

    return List.generate(maps.length, (i) {
      return Datum(
        id: maps[i]['id'],
        email: maps[i]['email'],
        firstName: maps[i]['first_name'],
        lastName: maps[i]['last_name'],
        avatar: maps[i]['avatar'],
      );
    });
  }

  Future<void> updateRecord(
      int id, String firstName, String lastName, String email) async {
    await _database.execute(
        "UPDATE employee_table SET first_name = ?, last_name = ?, email = ? WHERE id=$id", [firstName, lastName, email]);
  }

  Future<void> deleteRecord(int id) async {
    await _database.execute("DELETE FROM employee_table WHERE id=$id");
  }
}
