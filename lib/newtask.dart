import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'event/todoEvent.dart';
import 'bloc/TaskBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task.dart';
import 'database/database_provider.dart';
class NewTAsk extends StatefulWidget {


  @override
  _NewTAskState createState() => _NewTAskState();
}

class _NewTAskState extends State<NewTAsk> {
  final _titleController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _selectedDate == null) {
      return;
    }
        print("event1");
        String formattedDate=_selectedDate.toString();
    Task task=Task(date:formattedDate.substring(0,10) ,taskNAme: enteredTitle);

       DatabaseProvider.db.insert(task).then(
                              (storedTask) =>  BlocProvider.of<TaskBloc>(context).add(
      ToDoEvent.add(storedTask),
    ));
    print(enteredTitle);
    print("event2");
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    
    showDatePicker(
      
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2021),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Task Name'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Add Due Date',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.purple),
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add New Task'),
              color: Colors.purple,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
