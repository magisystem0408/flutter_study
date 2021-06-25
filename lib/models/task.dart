import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String title;
  bool isDone;
  Timestamp createdTime;
  Timestamp updatedTime;

  Task({this.title,this.isDone,this.createdTime,this.updatedTime});

}
