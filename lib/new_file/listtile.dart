import 'package:flutter/material.dart';
import 'package:myapp/new_file/profile.dart';
import 'package:myapp/new_file/setting.dart';

class Listtile extends StatelessWidget {
  const Listtile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            onTap: () {
               Navigator.pop(context);
            },
            title: Text('Home'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting()));
              
            },
            title: Text('Setting'),
          ),
          ListTile(
            leading: Icon(Icons.person_3_rounded),
            onTap: () {
               Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
            },
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
