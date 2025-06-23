import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/pages/auth.dart';
import 'package:myapp/pages/themeprovider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(create:(context)=>
    Themeprovider(),
    child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setOnlineStatus(true); 
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _setOnlineStatus(false);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final user = _auth.currentUser;
    if (user != null) {
      if (state == AppLifecycleState.resumed) {
        _setOnlineStatus(true); 
      } else {
        _setOnlineStatus(false); 
      }
    }
  }

  void _setOnlineStatus(bool isOnline) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('Users').doc(user.uid).update({
        'isOnline': isOnline,
        'lastSeen': Timestamp.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Auth(),
      theme: Provider.of<Themeprovider>(context).themedata
    );
  }
}
