import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/new_file/chatbuble.dart';
import 'package:myapp/new_file/chatservice.dart';
import 'package:myapp/pages/textfiled.dart';

class Chatpage extends StatefulWidget {
  final String recevireemail;
  final String recevireUid;



  const Chatpage({
    super.key,
    required this.recevireemail,
    required this.recevireUid,
  });

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Chatservice _chatservice = Chatservice();
  final text = TextEditingController();
  String? lastMessageId;


  final AudioPlayer player= AudioPlayer();
  final AudioPlayer players= AudioPlayer();


   // play the notifaction sound when send 
  Future<void> playsound() async{
        
    await player.play(AssetSource('songs.mp3'));
 
  }

  
   // recive the notifaction sound when come
  Future<void> recives() async{
        
    await players.play(AssetSource('recives.wav'));
 
  }



 // focus node

  final FocusNode _myfocusnode=FocusNode();


@override
 void  initState(){
 super.initState();

 // add lister to focus node

 _myfocusnode.addListener((){
  if(_myfocusnode.hasFocus){

    Future.delayed(Duration(milliseconds: 500),
    ()=>scrolldown(),
    );
  }
  
 });

  Future.delayed(Duration(milliseconds: 500),
  ()=>scrolldown()
  );


 }

   @override
  void dispose() {
   _myfocusnode.dispose();
   text.dispose();
    super.dispose();
  }
 



    // scroll controller

  final ScrollController scrollController=ScrollController();

  void scrolldown(){
    scrollController.animateTo(scrollController.position.maxScrollExtent,
     duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      );
  }


  void sendmessage()  {
    // if something is there it will send other wise no!

    if (text.text.trim().isNotEmpty)  {
       _chatservice.send(widget.recevireUid, text.text);

       
       playsound();

      // after sending the message the message want to clear

      text.clear();

    

      
    }
      scrolldown();
  }

 


 
  

  String _getMonthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade500,
         actions: [
           Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(onPressed: (){

            }, icon: Icon(Icons.call,
            color: Theme.of(context).brightness==Brightness.dark
            ? Colors.white : Colors.black,
            ),
            ),
           ),

           
         ],
        title: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(widget.recevireUid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text(widget.recevireemail);
              }

              final data = snapshot.data!.data() as Map<String, dynamic>;
              final isOnline = data['isOnline'] ?? false;
              final Timestamp? lastSeen = data['lastSeen'];
              final String? isTypingWith = data['isTypingWith'];
              final bool isTypingToMe =
                  isTypingWith == FirebaseAuth.instance.currentUser!.uid;

              String statusText;

              if (isTypingToMe) {
                statusText = "Typing...";
              } else if (isOnline) {
                statusText = "🟢 Online";
              } else if (lastSeen != null) {
                final time = lastSeen.toDate();
                final now = DateTime.now();
                final difference = now.difference(time).inDays;

                String dayText;
                if (difference == 0) {
                  dayText = "Today";
                } else if (difference == 1) {
                  dayText = "Yesterday";
                } else {
                  final month = _getMonthName(time.month);
                  dayText = "$month ${time.day}";
                }

                final hour = time.hour > 12
                    ? time.hour - 12
                    : time.hour == 0
                        ? 12
                        : time.hour;
                final minute = time.minute.toString().padLeft(2, '0');
                final ampm = time.hour >= 12 ? "PM" : "AM";

                statusText = "Last seen: $dayText at $hour:$minute $ampm";
              } else {
                statusText = "Offline";
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recevireemail,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    statusText,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).brightness==Brightness.dark
                        ? Colors.white :Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }),
      ),
      body: Column(
        children: [
          // message

          Expanded(child: builduserlist()),

          // userinput
          _builderuserinput(),

          SizedBox(height: 25),
        ],
      ),
    );
  }

  // bulid message list

  Widget builduserlist() {
    return StreamBuilder(
        stream: _chatservice.getmessage(
            widget.recevireUid, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshots) {
          // if snapshots has error

          if (snapshots.hasError) {
            return Text("Error : ${snapshots.hasError}");
          }

          //if snapshots has connection state

          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }

         final docs = snapshots.data!.docs;
         
         if (docs.isNotEmpty) {
        final latestDoc = docs.last;
        final messageId = latestDoc.id;
        final messageData = latestDoc.data() as Map<String, dynamic>;

        // ⚠ Only play sound if:
        // - it's a new message
        // - it's NOT from current user (it's received)
        if (messageId != lastMessageId &&
            messageData['senderid'] != _firebaseAuth.currentUser!.uid) {
          lastMessageId = messageId;
           recives();
        }
      }


          // if snapshots has data

           WidgetsBinding.instance.addPostFrameCallback((_) => scrolldown());


          return ListView(
            
            controller: scrollController,
            children: snapshots.data!.docs
                .map((doucment) => _builderuseritem(doucment))
                .toList(),
          );
        });
  }

  //bulid message item

  Widget _builderuseritem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // we going to align the current user is messaging it will display in right otherwise the reciver
    // email will show in left

    bool currentUser = (data["senderid"] == _firebaseAuth.currentUser!.uid);

    var alignmenet = currentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignmenet,
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment:
              (data["senderid"] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            //Text(data["senderemail"]),

            //  SizedBox(height: 5),

            Chatbuble(messsage: data["message"], iscurrent: currentUser),
          ],
        ),
      ),
    );
  }

  // bulid message input

  Widget _builderuserinput() {
    return Row(
      children: [
        // texflied
        Expanded(
          child: textfiled(
            text1: text,
            name: "Send a Message",
            obscureText: false,
            focusNode: _myfocusnode,
           // onSubmitted: (value) 
          ),
        ),

        // send button

        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
            onTap: sendmessage,
            child: Icon(
              Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
