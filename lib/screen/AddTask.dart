import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Event/TodoBloc.dart';
import 'package:todoapp/Model/task.dart';
import 'package:todoapp/Model/taskData.dart';

class AddTask extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  List<Task> taskList;
  Function addCallback;
  Task newTask;
  AddTask({this.taskList, this.addCallback});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25.0),
            topLeft: Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
          child: Column(
            children: [
              Text(
                "Add Task",
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      autofocus: true,
                      onChanged: (value) {
                        newTask = Task(title: value ?? "Empty", isDone: false);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          TodoBloc.instance.addTask(newTask);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      color: Colors.blue,
                      minWidth: double.infinity,
                      height: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
