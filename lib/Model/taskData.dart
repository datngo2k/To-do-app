import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/Model/task.dart';
import 'package:todoapp/Utils/DBProvider.dart';

class TaskData extends ChangeNotifier {
  List<Task> tasks = [];
  TaskData() {
    loadDB();
  }

  void loadDB() async {
    var tasksDB = await DBProvider.db.getDB() as List<Map<String, dynamic>>;
    if (tasksDB != null) {
      tasks = (tasksDB.map(
        (e) => Task(
            title: e['title'],
            isDone: e['dat'] == 0 ? false : true,
            id: e['id']),
      )).toList();
    }
  }

  void toggle(index) async {
    var task = tasks[index];
    var value = tasks[index].isDone ? 0 : 1;
    tasks[index].toggle();
    await DBProvider.db.updateDB(task.id, value);
    notifyListeners();
  }

  void delete(task) async {
    tasks.remove(task);
    var tasksDB = await DBProvider.db.deleteDB(task.id);
    notifyListeners();
  }

  void addTask(Task task) async {
    tasks.add(task);
    var tasksDB = await DBProvider.db.getDB();
    await DBProvider.db.insertDB(task.title, task.isDone);
    notifyListeners();
  }
}
