import 'package:flutter/material.dart';

class Decretion extends StatelessWidget {
 final String text;
  const Decretion({super.key,
  required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [

        Icon(Icons.person,
        ),
        
        SizedBox(width: 25),

        Text(text),
      ],
    ),
    
    );
  }
}