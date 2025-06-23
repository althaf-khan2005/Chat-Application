
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderid;
  final String recevierid;
  final String senderemail;
  final Timestamp timestamp;
  final  String message;
  final bool isRead;


   Message({
  required this.senderemail,
  required this.senderid,
  required this.recevierid,
  required this.message,
  required this.timestamp,
  required this.isRead,
 });

 Map<String,dynamic> tomap(){
  return {
  "senderid":senderid,
  "senderemail":senderemail,
  "recevierid":recevierid,
  "message":message,
  "timestamp":timestamp,
  "isRead": isRead,
  
   
  };
 }

}

