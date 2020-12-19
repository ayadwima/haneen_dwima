import 'package:ass2/DBManger.dart';

class Task {
  int id;
  String taskName;
  bool isCompleteTask;

  Task({this.id, this.taskName, this.isCompleteTask});

  toJson() {
    return {
      DBManger.taskIdColumnName: this.id,
      DBManger.taskNameColumnName: this.taskName,
      DBManger.taskIsCompleteColumnName: this.isCompleteTask ? 1 : 0
    };
  }
}
