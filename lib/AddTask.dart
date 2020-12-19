import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ass2/DBManger.dart';
import 'package:ass2/HomePage.dart';
import 'package:ass2/Task.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final db = DBManger();

  @override
  Widget build(BuildContext context) {
    String newTaskName;
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New Task',

                  style: TextStyle(color: Colors.redAccent, fontSize: 25),
                ),
                TextField(
                  cursorColor: Colors.red,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    newTaskName = value;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                FlatButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    db.insertNewTask(
                        Task(taskName: newTaskName, isCompleteTask: false));
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Add Task',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),

        ),
      ),
    );
  }
}
