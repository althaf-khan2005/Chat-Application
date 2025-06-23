import 'package:flutter/material.dart';

ThemeData ligthmode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.grey.shade400,
        primary: Colors.grey.shade300,
        secondary: Colors.grey.shade200,
        inversePrimary: Colors.grey.shade600,
        
       ));

      
ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme:ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade100,
        

   
  ),
);
