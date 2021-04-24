import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoapp/Model/task.dart';

class DBProvider {
  static final DBProvider db = DBProvider();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, "toDoList.db");
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE ToDoList (id INTEGER PRIMARY KEY, title TEXT, isDone INTEGER)');
    });
  }

  insertDB(String title, bool isDone) async {
    int done = isDone ? 1 : 0;
    final db = await initDB();
    try {
      return await db.rawInsert(
          'INSERT INTO ToDoList(title, isDone) VALUES("$title", $done);');
    } catch (e) {
      print(e);
    } finally {}
  }

  Future<dynamic> getDB() async {
    final db = await initDB();
    List<Map> listTasks = await db.rawQuery('SELECT * FROM ToDoList');
    print(listTasks);
    if (listTasks.isEmpty)
      return null;
    else
      return listTasks;
  }

  Future deleteDB(id) async {
    final db = await initDB();
    await db.rawDelete('DELETE FROM ToDoList WHERE id = ?', ['$id']);
  }

  Future updateDB(id, isDone) async {
    final db = await initDB();
    var res = await db.rawUpdate(
        'UPDATE ToDoList SET isDone = ? WHERE id = ?', ['$isDone', '$id']);
  }
}
