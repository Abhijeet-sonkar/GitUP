import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'event/todoEvent.dart';
import 'task.dart';
import 'bloc/TaskBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'database/database_provider.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  void initState() {
    super.initState();
     DatabaseProvider.db.getTask().then(
      (taskList) {
          print("initialising database");
        BlocProvider.of<TaskBloc>(context).add(ToDoEvent.show(taskList));
     
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, List<Task>>(
        buildWhen: (List<Task> previous, List<Task> current) {
      return true;
    }, listenWhen: (List<Task> previous, List<Task> current) {
      if (current.length > previous.length) {
        return true;
      }

      return false;
    },
    
     listener: (BuildContext context, taskList) {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('Added!')),
      );
    },
     builder: (context, taskList) {
      return taskList.isEmpty
          ? Center(
              child: Text(
                'No task  added yet!',
                style: GoogleFonts.homemadeApple(
                    color: Colors.black, fontSize: 20),
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Card(
                    color: Colors.purple[50],
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              '#${index + 1}',
                              style: GoogleFonts.autourOne()
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        taskList[index].taskNAme,
                      ),
                      subtitle: Text(
                          'Due date: ${taskList[index].date}',style: TextStyle(color: Colors.purple),),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => 
                        DatabaseProvider.db.delete(taskList[index].id).then((_) {
                        BlocProvider.of<TaskBloc>(context).add(
                      ToDoEvent.delete(taskList[index].id),
                      );})
                    ),
                  )
                  ),
                );
              },
              itemCount: taskList.length,
            );
    });
  }
}
