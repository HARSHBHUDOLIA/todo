import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? content;
  String? todoId;
  Timestamp? dateCreated;
  bool? done;

  TodoModel({this.content, this.todoId, this.dateCreated, this.done});

  TodoModel.fromDocumentSnapshot(
    DocumentSnapshot doc,
  ) {
    todoId = doc.id;
    content = doc["content"];
    dateCreated = doc["dateCreated"];
    done = doc["done"];
  }
}
