import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
   const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Get the current user's UID
    final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUserUid) // Directly get document using UID
            .snapshots(),
        builder: (context, snapshot) {
          // Handle errors
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          // Show loading spinner
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          // When data is available
          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data() as Map<String, dynamic>;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Icon(Icons.person_4_rounded, size: 80, color: Theme.of(context).brightness==Brightness.dark
                   ? Colors.white : Colors.black),
                   SizedBox(height: 20),
                  Text(
                    "Email: ${data["email"] }",
                    style:  TextStyle(color: Theme.of(context).brightness==Brightness.dark
                    ? Colors.white :  Colors.black,
                    fontWeight: FontWeight.bold,
                     fontSize: 20),
                  ),
                   SizedBox(height: 10),

                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness==Brightness.dark
                      ? Colors.grey[600] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "UID: ${data["uid"] }",
                      style:  TextStyle(color: Theme.of(context).brightness==Brightness.dark
                      ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return  Center(child: Text("User not found"));
        },
      ),
    );
  }
}
