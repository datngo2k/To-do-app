import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Event/TodoBloc.dart';
import 'package:todoapp/Model/task.dart';
import 'package:todoapp/Model/taskData.dart';

import 'TaskTile.dart';

class TaskTileList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: TodoBloc.instance.listTaskStream,
      builder: (context, asyncData) => ListView.builder(
        itemBuilder: (context, index) {
          print(index);
          Task task = asyncData.data[index];
          return TaskTile(
            title: task.title,
            isChecked: task.isDone,
            toggleCallback: () {
              TodoBloc.instance.toggle(index);
            },
            deleteTaskCallback: () {
              TodoBloc.instance.delete(task);
            },
          );
        },
        itemCount: asyncData.data != null ? asyncData.data.length : 0,
      ),
    );
  }
}
