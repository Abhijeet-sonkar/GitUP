import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'model/userName.dart';
import 'event/UserName_Event.dart';
import 'bloc/userName_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var _userNameController = TextEditingController();
  var userName;
  void _submitData() {
    userName = _userNameController.text;
    if (userName.isEmpty) return;
   
   print('one');
    UserName userNameAlias=UserName(userName);
    
   // BlocProvider.of<UserNameBloc>(context).add(UserNameEvent.login(userNameAlias));
    print('two');
    Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp(userName)),
        );
    print('three');
  }

  @override
  void initState() {
    userName = Null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[100],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.black,
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
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: CircleAvatar(
                            radius: 125,
                            backgroundImage: AssetImage('images/logo1.png'),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'GitUP',
                          style: GoogleFonts.carterOne(
                              fontSize: 40, color: Colors.deepPurple),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: 'Enter yout Github Username'),
                            controller: _userNameController,
                            onSubmitted: (_) => _submitData(),
                            // onChanged: (val) {
                            //   titleInput = val;
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: _submitData,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.purple[400],
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Center(
                                  child: Text(
                                'Log in',
                                style: GoogleFonts.caveatBrush(
                                    fontSize: 25, color: Colors.white),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      
    );
  }
}
