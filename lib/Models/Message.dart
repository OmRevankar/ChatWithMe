import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message{
  final String message;
  final String receiverID;
  final String senderEmail;
  final String senderID;
  final Timestamp timestamp;

  Message({
    required this.message,
    required this.receiverID,
    required this.senderEmail,
    required this.senderID,
    required this.timestamp,
  });

  //convert to map
Map<String,dynamic>toMap(){
  return{
    'message' : message,
    'receiverID' : receiverID,
    'senderEmail' : senderEmail,
    'senderID' : senderID,
    'timestamp' : timestamp,
  };
}

}