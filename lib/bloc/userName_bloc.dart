import 'package:flutter_bloc/flutter_bloc.dart';
import '../event/UserName_Event.dart';
import '../model/userName.dart';

class UserNameBloc extends Bloc<UserNameEvent, UserName> {
  @override
  UserName get initialState => UserName('logOut');

  @override
  Stream<UserName> mapEventToState(UserNameEvent event)async* {
    switch (event.eventType) {
      case EventType.logIn:
        yield event.userName;
        break;

      case EventType.logOut:
        UserName newState = state;
        newState.userName='logOut';
        yield newState;
        break;
      case EventType.show:
        UserName newState = state;
        yield newState;
        break;
      default:
        throw Exception('Event not found $event');
    }
  }
}