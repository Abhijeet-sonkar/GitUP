import '../task.dart';

enum EventType { add, delete ,show}

class ToDoEvent {
  Task task;
  int id;
  EventType eventType;

  ToDoEvent.add(Task task) {
    this.eventType = EventType.add;
    this.task = task;
  }

  ToDoEvent.delete(int  id) {
    this.eventType = EventType.delete;
    this.id = id;
  }
  List<Task> taskList;
  ToDoEvent.show( List<Task> tasks)
  {
     this.eventType = EventType.show;
     this.taskList=tasks;

  }
}
