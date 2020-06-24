import 'package:flutter/foundation.dart';
import 'database/database_provider.dart';
class Task {
   int id;
   String taskNAme;
   String date;
  
 

  Task({
  this.id,
    @required this.taskNAme,
       @required this.date,
  
  });
    Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.TASK_NAME: taskNAme,
      DatabaseProvider.DATE: date,
  
    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    } 
    return map;
  }
    
  
    Task.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    taskNAme = map[DatabaseProvider.TASK_NAME];
    date = map[DatabaseProvider.DATE];

}
}