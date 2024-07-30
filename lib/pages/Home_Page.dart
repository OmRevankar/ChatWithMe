import 'package:chatwithme/components/My_Drawer.dart';
import 'package:chatwithme/services/auth/auth_service.dart';
import 'package:chatwithme/services/chat/Chat_Service.dart';
import 'package:chatwithme/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:chatwithme/components/User_Tile.dart';
import 'package:chatwithme/pages/Chat_Page.dart';

class HomePage extends StatelessWidget{
  HomePage({super.key});

final ChatService _chatService = ChatService();
final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : const Text('HOME'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        centerTitle: true,
      ),
        drawer: MyDrawer(),
        body: _buildUserList(),
      );
  }

  //build a list of users execpt for the current logged in user
  Widget _buildUserList(){
    return StreamBuilder<List<Map<String,dynamic>>>(
        stream: _chatService.getUsersStream(),
        builder: (context,snapshot){

          //ERROR
          if(snapshot.hasError){
            return Text("ERROR");
          }
          //LOADING
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text("LOADING...");
          }
          //RETURN LIST VIEW
          return ListView(
            children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData ,context)).toList(),
          );

        }
    );
  }

  //build individual list tile for user
  Widget _buildUserListItem(
      Map<String , dynamic> userData , BuildContext context){
        //display all users except current user
        if(userData["email"] != _authService.getCurrentUser()!.email){
          return UserTile(
              text: userData["email"],
              onTap:(){
                Navigator.push(context, MaterialPageRoute(
                    builder:(context) => ChatPage(
                      receiverEmail: userData["email"],
                      receiverID: userData["uid"]
                    )
                )
                );
              },
          );
        }
        else{
          return Container();
        }
  }

}