import 'package:prototype2/model/task.dart';
import '../event/todoEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TaskBloc extends Bloc<ToDoEvent, List<Task>> {
  @override
  List<Task> get initialState => List<Task>();

  @override
  Stream<List<Task>> mapEventToState(ToDoEvent event)async* {
    switch (event.eventType) {
      case EventType.add:
        List<Task> newState = List.from(state);
        if (event.task != null) {
          newState.add(event.task);
        }
        yield newState;
        break;
      case EventType.delete:
        List<Task> newState = List.from(state);
        print(newState.length);
        newState.removeWhere((tx) => tx.id == event.id);
        yield newState;
        break;
      case EventType.show:
        
        yield event.taskList;
        break;  
      default:
        throw Exception('Event not found $event');
    }
  }
}