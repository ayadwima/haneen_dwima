import 'package:flutter/material.dart';
import 'package:ass2/DBManger.dart';
import 'package:ass2/Task.dart';

import 'HomePage.dart';

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  Widget build(BuildContext context) {
    var db = DBManger();
    var selectAllTasks = db.selectAllTasks();

    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<List>(
          future: selectAllTasks,
          initialData: List(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, int position) {
                      final item = snapshot.data[position];
                      bool isComplete = false;
                      if (snapshot.data[position].row[2] == 1) {
                        isComplete = true;
                      } else {
                        isComplete = false;
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        return Container(
                          height: 70,
                          child: Center(
                            child: ListTile(
                              title: Text("${snapshot.data[position].row[1]}"),
                              trailing: Checkbox(
                                  activeColor: Colors.red,
                                  checkColor: Colors.white,
                                  value: isComplete,
                                  onChanged: (value) {
                                    setState(() {
                                      db.updateTask(Task(
                                        id: snapshot.data[position].row[0],
                                        taskName:
                                            snapshot.data[position].row[1],
                                        isCompleteTask: value,
                                      ));
                                    });
                                  }),
                              leading: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Widget cancelDelete = FlatButton(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                    Widget continueDelete = FlatButton(
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        db.deleteTask(
                                            snapshot.data[position].row[0]);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()),
                                        );
                                      },
                                    );

                                    AlertDialog alert = AlertDialog(
                                      title: Text("Delete Task?"),
                                      content: Text(
                                          "Are you want to delete this Task?"),
                                      actions: [
                                        cancelDelete,
                                        continueDelete,
                                      ],
                                    );

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  });
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }
}
