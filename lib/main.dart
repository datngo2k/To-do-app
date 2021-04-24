import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/screen/TaskScreen.dart';
import 'Model/taskData.dart';
import 'file:///C:/Users/Dat%20Ngo/Desktop/Learning%20Android/todoapp/lib/screen/AddTask.dart';

import 'widget/TaskTile.dart';
import 'widget/TaskTileList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyToDoApp(),
    );
  }
}
