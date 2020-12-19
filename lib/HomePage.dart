import 'package:flutter/material.dart';
import 'package:ass2/AddTask.dart';
import 'package:ass2/AllTasks.dart';
import 'package:ass2/CompleteTasks.dart';
import 'package:ass2/InCompleteTasks.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            drawer: Drawer(),
            appBar: AppBar(
              title: Text('TO DO'),
              backgroundColor: Colors.red,
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    text: 'All Tasks',
                  ),
                  Tab(
                    text: 'complete Tasks',
                  ),
                  Tab(
                    text: 'incomplete  Tasks',
                  )
                ],
                isScrollable: true,
              ),
            ),


            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddTask()),
                );
              },
              child: Icon(Icons.add),
            ),


            body: TabBarView(
              children: [ AllTasks(),
                CompleteTasks(),
                InCompleteTasks()
              ],
            )
        )
    );
  }
}
