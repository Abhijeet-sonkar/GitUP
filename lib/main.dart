import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'Screen/MainDrawer.dart';
import 'Screen/contributionsScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/TaskBloc.dart';
import 'Screen/loginScreen.dart';
import 'access_token.dart';

void main() => runApp(BlocProvider<TaskBloc>(
      create: (context) => TaskBloc(),
      child: MaterialApp(
          title: "Github with GraphQL",
          debugShowCheckedModeBanner: false,
          home: Scaffold(body: MainScreen())),
    ));

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  // String stringValue;

  Future<String> a;
  void initState() {
    getUserName() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String value = prefs.getString('userName') ?? 'logOut';
      return value;
    }

    a = getUserName();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(a);
    return FutureBuilder(
        future: a,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == 'logOut') {
              return LogInScreen();
            } else {
              return MyApp(snapshot.data);
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class MyApp extends StatefulWidget {
  final String userName;
  MyApp(this.userName);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
        uri: 'https://api.github.com/graphql',
        headers: {"authorization": "Bearer $accessToken"});

    ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(
            link: httpLink,
            cache:
                OptimisticCache(dataIdFromObject: typenameDataIdFromObject)));

    return GraphQLProvider(
      client: client,
      child: MyHomePage(widget.userName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String userName;
  MyHomePage(this.userName);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    String readRepositories = """
     query Flutter_Github_GraphQL{
            user(login: "${widget.userName}") {
                 avatarUrl(size: 200)
     repositoriesContributedTo{
      
      totalCount
    }
      repositories{
        totalCount
      }

    
      contributionsCollection{
      contributionCalendar{
        totalContributions
      }
        contributionYears
        issueContributions{
          totalCount
        }
        totalCommitContributions
      pullRequestContributions{
          totalCount
        }
        totalRepositoryContributions
    
      }
           
                name
               
    }
          }
      """;

    return Scaffold(
      //  / drawer: MainDrawer(),
      body: Query(
        options: QueryOptions(
          documentNode: gql(readRepositories),
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.exception != null) {
            return AlertDialog(
              title: Text('Warning'),
              content: const Text('Invalid Username'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Go Back'),
                  onPressed: () {
                    // BlocProvider.of<UserNameBloc>(context).add(UserNameEvent.logOut());
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LogInScreen()),
                    );
                  },
                ),
              ],
            );
          }

          final userDetails = result.data['user'];

          return Contributions(userDetails);
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        elevation: 0.0,
      ),
      drawer: MainDrawer(widget.userName),
    );
  }
}
