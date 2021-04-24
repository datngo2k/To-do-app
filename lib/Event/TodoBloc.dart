import 'dart:async';

import 'package:todoapp/Model/task.dart';
import 'package:todoapp/Utils/DBProvider.dart';

class TodoBloc {
  static TodoBloc _instance;

  static get instance {
    if (_instance == null) {
      _instance = new TodoBloc();
    }
    return _instance;
  }

  static set instance(instance) {
    _instance = instance;
  }

  List<Task> tasks = [];
  StreamController _streamController = StreamController<List<Task>>.broadcast();
  Stream<List<Task>> get listTaskStream => _streamController.stream;

  TodoBloc() {
    loadDB();
  }
  bool convert(num) {
    if (num == 0)
      return false;
    else
      return true;
  }

  void loadDB() async {
    var tasksDB = await DBProvider.db.getDB() as List<Map<String, dynamic>>;
    if (tasksDB != null) {
      tasks += tasksDB
          .map(
            (e) => Task(
                title: e['title'], isDone: convert(e['isDone']), id: e['id']),
          )
          .toList();
    }
    _streamController.sink.add(tasks);
  }

  int numOfTasks() {
    return tasks.length;
  }

  void toggle(index) async {
    var task = tasks[index];
    var value = tasks[index].isDone ? 0 : 1;
    tasks[index].toggle();
    await DBProvider.db.updateDB(task.id, value);
    _streamController.sink.add(tasks);
  }

  void delete(task) async {
    tasks.remove(task);
    var tasksDB = await DBProvider.db.deleteDB(task.id);
    _streamController.sink.add(tasks);
  }

  void addTask(Task task) async {
    tasks.add(task);
    var tasksDB = await DBProvider.db.getDB();
    await DBProvider.db.insertDB(task.title, task.isDone);
    _streamController.sink.add(tasks);
  }

  void dispose() {
    _streamController.close();
  }
}
