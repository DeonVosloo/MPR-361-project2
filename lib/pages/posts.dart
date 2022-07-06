import 'package:flutter/material.dart';
import 'package:project2/pages/databasemanager.dart';
import 'package:project2/pages/users.dart';

class Post
{
  int? id;
  String comment;
  String image;
  dynamic likes;
  dynamic dislikes;
  dynamic userID;


  Post({this.id, required this.comment, required this.image, required this.likes, required this.dislikes, required this.userID});

  Post.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        comment = result["comment"],
        image = result["image"],
        likes = result["likes"],
        dislikes = result["dislikes"],
        userID = result["userID"];

  Map<String, Object> toMap()
  {
    return
      {
      'comment': comment,
      'image': image,
      'likes': likes,
      'dislikes': dislikes,
      'userID': userID,
    };
  }
}