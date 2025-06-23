import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/themeprovider.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade500,
      ),

      body: Column(

        children: [

          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Dark Mode",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            
                  CupertinoSwitch(value: Provider.of<Themeprovider>(context,listen: false).isdark,
                   onChanged:(value)=>{
                      Provider.of<Themeprovider>(context,listen: false).tooglegate(),
                   } ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}