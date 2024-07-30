import 'package:chatwithme/Models/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService{
  //get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get users stream
       //( firebase console looks like a map)
  Stream<List<Map<String , dynamic>>> getUsersStream(){
    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        //go through each individual user
        final user = doc.data() as Map<String, dynamic>;

        //return user
        return user;
      }).toList();
    });
  }
  //send messeges
  Future<void> sendMessage(String receiverID , message) async{

    //get user current info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
        message: message,
        receiverID: receiverID,
        senderEmail: currentUserEmail,
        senderID: currentUserID,
        timestamp: timestamp,
    );

    //construct chat room ID for the two users(sorted to ensure uniqueness)
    List<String> ids = [currentUserID , receiverID];
    ids.sort();//sort the ids (this ensure the chatroomID is the same for any 2 people)
    String ChatRoomID = ids.join('_');

    //add the message to the database
    await _firestore.collection("chat_rooms").doc(ChatRoomID).collection("message").add(newMessage.toMap());
  }

  //get messeges
  Stream<QuerySnapshot> getMessages(String userID , otherUserID){
    //contruct a chatrrom ID for the two users
    List<String> ids = [userID , otherUserID];
    ids.sort();
    String ChatRoomID = ids.join('_');

    return _firestore.collection("chat_rooms").doc(ChatRoomID).collection("message").orderBy("timestamp" , descending: false).snapshots();
  }
}