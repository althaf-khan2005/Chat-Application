import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:myapp/new_file/message.dart';

class Chatservice  extends ChangeNotifier{

  final FirebaseAuth firebase=FirebaseAuth.instance;
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;


  //send message 

  Future<void> send(String recevierid , String message) async{
    // get the current user

    final currentuser=firebase.currentUser!.uid;
    final currentemail=firebase.currentUser!.email.toString();
    final timestamp=Timestamp.now();

    // send the message we get
    Message message0=Message(
      senderemail: currentemail,
       senderid: currentuser,
        recevierid: recevierid,
         message: message,
          timestamp: timestamp,
          isRead: false,
          );


          // we going to join the user when the meet

          List<String> ids=[currentuser , recevierid];
          ids.sort();
          String chatroomid=ids.join("_");


          // store in database in could

          await _firestore.collection("Chats").doc(chatroomid).collection("Messages").add(
            message0.tomap(),
          
          );
  }



  // get messsage

  Stream<QuerySnapshot> getmessage(String userid, String otheruserid ){

    // when the two user meet they  they can chat 

    List<String> ids=[userid,otheruserid];
    ids.sort();
    String chatroomid=ids.join("_");



    return _firestore.collection("Chats").doc(chatroomid)
    .collection("Messages")
    .orderBy("timestamp",descending: false)
    .snapshots();

    
  }


// void setTyping(String receiverId) {
//   final currentUser = firebase.currentUser!;
//   _firestore.collection("Users").doc(currentUser.uid).update({
//     'isTypingWith': receiverId,
   
   
//   });
// }

// void clearTyping() {
//   final currentUser = firebase.currentUser!;
//   _firestore.collection("Users").doc(currentUser.uid).update({
//     'isTypingWith': null,
  
   
//   });
//}

  

  


 

}