import 'package:chatwithme/components/Chat_Bubble.dart';
import 'package:chatwithme/components/My_TextField.dart';
import 'package:chatwithme/services/auth/auth_service.dart';
import 'package:chatwithme/services/chat/Chat_Service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget{
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key , required this.receiverEmail , required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth services
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  //for textfield focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    //add listner to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        //cause delay so that the keyboard has time to show up
        //then the amount of remaining space will be calculated
        //then  scroll down
        Future.delayed(
          const Duration(milliseconds: 500),
              () => scrollDown(),
        );
      }
    });

    //wait a bit for the listview to be built , then scroll to bottom
    Future.delayed(
      const Duration(milliseconds: 500),
          () => scrollDown(),
    );
  }



  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  //send message
  void sendMessage() async {
    //if there is something inside textfield then only send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);


      //then cler the controller
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.receiverEmail),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          elevation: 0,
          centerTitle: true,
      ),
      body: Column(
        children: [

          //display messages
          Expanded(
              child: _buildMessageList(),
          ),

          //users input
          _buildUserInput(),

        ],
      ),
    );

  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {

          //errors
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //loading
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text("Loading....");
          }

          //return list view
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
        }

    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String,dynamic> data = doc.data() as Map<String , dynamic>;

    //is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    //algin the message to right if the sender is current user otherwise left
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;


    return Container(
        alignment: alignment,
        child: ChatBubble(
          message: data["message"],
          isCurrentUser: isCurrentUser,
        )
    );

  }

  Widget _buildUserInput(){
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child:Row(
      children: [
        //textfield should take most of the space
        Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Say Something...",
              obsecureText: false,
              focusNode: myFocusNode,
            ),
        ),

        //send button
        Container(
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        margin: EdgeInsets.only(right: 25),
        child:IconButton(
            onPressed:sendMessage,
            icon: Icon(Icons.arrow_upward),
            color: Colors.white,
        )
        )
      ],
      ),
    );
  }
}