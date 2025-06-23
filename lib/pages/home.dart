import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/new_file/chatpage.dart';
import 'package:myapp/new_file/decretion.dart';
import 'package:myapp/new_file/listtile.dart';
import 'package:myapp/pages/authservices.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,


      drawer: Drawer(
        child: Column(

          children: [
            DrawerHeader(
              child: Icon(
                
                Icons.message_rounded,
                size: 50,
                color: Colors.grey,
              ),
              

            ),

           

           Padding(
            padding: EdgeInsets.only(left: 25),
            child: Listtile()),

            Spacer(),

             Padding(
            padding: EdgeInsets.only(left: 25),
            child: ListTile(
              leading: Icon(Icons.logout),
              onTap: (){
                Authservices().logout();
              },
              title: Text("Logout"),
              
            ),
            
            ),

            SizedBox(height: 20),

          

          
        ],
          
        
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Chats",
        style: TextStyle(
        fontWeight: FontWeight.bold,
        ),),
        
        
      ),
      body: userlist(),
    );
  }

  Widget userlist() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshots) {
          // if snapshots has error

          if (snapshots.hasError) {
            return Text("Error :${snapshots.hasError}");
          }

          // if snapshots has in connection state

          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }

          return ListView(
            children: snapshots.data!.docs
                .map<Widget>((doc) => _buliduserlist(doc))
                .toList(),
          );
        });
  }

  Widget _buliduserlist(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (user.email != data["email"]) {
      return ListTile(
        splashColor: Colors.transparent,
        title: Decretion(
          text: data["email"],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chatpage(
                        recevireemail: data["email"],
                        recevireUid: data["uid"],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
