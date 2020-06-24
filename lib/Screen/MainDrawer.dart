import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'package:prototype2/main.dart';
import '../widgets/option_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todoScreen.dart';


class MainDrawer extends StatelessWidget {
  final String userName;
  MainDrawer(this.userName);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(),
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                // color: Colors.yellow,
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('images/logo1.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                      Colors.white,
                      Colors.purple[200],
                    ],
                        stops: [
                      0.0,
                      1.0
                    ],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        tileMode: TileMode.repeated)),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      OptionWidget("Contribution", Icons.redeem, () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyApp(userName)),
                        );
                      }),
                       OptionWidget("To-Do", Icons.rate_review, () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ToDoMain(userName)),
                        );
                      }),
                      OptionWidget("Logout", Icons.navigate_before, () {
                        storeUserName() async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('userName', 'logOut');
                        }

                        storeUserName();
                        
                        print('this is also executing');
            
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()),
                        );
                      })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
