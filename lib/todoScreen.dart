import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/newtask.dart';
import 'Screen/contributionsScreen.dart';
import 'Screen/MainDrawer.dart';

import 'widgets/tasklist.dart';

class ToDoMain extends StatelessWidget {
  final String userName;
  ToDoMain(this.userName);
  void _addNewTask(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTAsk(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var heightSize =
        MediaQuery.of(context).size.height - AppBar().preferredSize.height;
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple[900],
            elevation: 0.0,
             actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _addNewTask(context),
            ),
          ],
          ),
          drawer: MainDrawer(userName),
          body: Container(
            height: heightSize,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      height: heightSize * 0.40,
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.blue,
                      decoration: new BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [
                            Colors.deepPurple[900],
                            Colors.purple[100],
                          ],
                              stops: [
                            0.0,
                            1.0
                          ],
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              tileMode: TileMode.repeated)),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 4, bottom: 4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.black,
                              height: heightSize * 0.3,
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Colors.deepPurple, BlendMode.color),
                                child: Image.asset(
                                  'images/todo.jpg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'To-Do',
                        style: GoogleFonts.carterOne(fontSize: 30),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.transparent,
                        height: heightSize * 0.5,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TaskList(),
                      )),
                ],
              ),
            ),
          ),
      
      
    );
  }
}
