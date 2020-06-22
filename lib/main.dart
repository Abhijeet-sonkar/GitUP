import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:prototype2/MainDrawer.dart';
import 'contributionsScreen.dart';
import 'loginScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model/userName.dart';
import 'event/UserName_Event.dart';
import 'bloc/userName_bloc.dart';

void main() => runApp(MaterialApp(
    title: "Github with GraphQL",
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: MainScreen())));

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    //  BlocProvider.of<UserNameBloc>(context).add(UserNameEvent.show());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => UserNameBloc(),
        child: BlocBuilder<UserNameBloc, UserName>(
          builder: (_, userName) {
            return userName.userName == 'logOut'
                ? LogInScreen()
                : MyApp(userName.userName);
          },
        ));
  }
}

class MyApp extends StatefulWidget {
  final String userName;
  MyApp(this.userName);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String personal_access_tokens = '9e96f88ea4969fdf80f27bc0d66f3071e92149c4';

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
        uri: 'https://api.github.com/graphql',
        headers: {"authorization": "Bearer $personal_access_tokens"});

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
