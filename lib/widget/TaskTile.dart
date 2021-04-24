import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  bool isChecked = false;
  String title = "Nothing";
  Function toggleCallback;
  Function deleteTaskCallback;
  TaskTile(
      {this.title,
      this.isChecked,
      this.toggleCallback,
      this.deleteTaskCallback});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        (title),
        style: TextStyle(
          decoration:
              isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Checkbox(
        value: isChecked,
        activeColor: Colors.blue,
        onChanged: (value) {
          toggleCallback();
        },
      ),
      onTap: () {
        toggleCallback();
      },
      onLongPress: () {
        deleteTaskCallback();
      },
    );
  }
}

// class TaskCheckBox extends StatelessWidget {
//   final bool checked;
//   final Function toggleCallback;
//
//   TaskCheckBox({@required this.checked, @required this.toggleCallback});
//   @override
//   Widget build(BuildContext context) {
//     return Checkbox(
//       value: checked,
//       activeColor: Colors.blue,
//       onChanged: toggleCallback,
//     );
//   }
// }
