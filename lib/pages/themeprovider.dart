import 'package:flutter/material.dart';
import 'package:myapp/pages/theme.dart';

class Themeprovider with ChangeNotifier {

 ThemeData _themeData= ligthmode;

  ThemeData get themedata=> _themeData;

  bool get isdark=> _themeData==darkmode;

  set themedata(ThemeData theme){
    _themeData=theme;
      notifyListeners();
  }
  

  void tooglegate(){
    if(_themeData==ligthmode){
      themedata=darkmode;
    }
    else{
      themedata = ligthmode;
    }
    
  }
  



}