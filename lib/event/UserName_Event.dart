import '../model/userName.dart';

enum EventType {logIn,logOut,show}

class UserNameEvent {
   
   UserName userName;
   EventType eventType;

   UserNameEvent.login(UserName userName)
   {
     this.userName=userName;
     this.eventType=EventType.logIn;
   }
    UserNameEvent.logOut()
   {
     
     this.eventType=EventType.logOut;

   }
    UserNameEvent.show( )
   {
     
     this.eventType=EventType.show;

   }



}