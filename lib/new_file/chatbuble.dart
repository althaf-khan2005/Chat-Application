import 'package:flutter/material.dart';

class Chatbuble extends StatelessWidget {
  final String messsage;
  final bool iscurrent;

  const Chatbuble({super.key,
  required this.messsage,
  required this.iscurrent,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 2.5,horizontal:25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: iscurrent ? Colors.green : Colors.grey.shade500,
      ),
      child: Text(messsage,
      style: TextStyle(
        color: Colors.white,
      ),),
    );
  }
}