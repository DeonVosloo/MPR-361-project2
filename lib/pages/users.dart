import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'picture.dart';

class Users
{
  int? id;
  String username;
  String status;
  String image;
  String email;
  String password;

  Users(this.id,{required this.username, required this.status, required this.image, required this.email, required this.password});

  Users.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        username = result["username"],
        status = result["status"],
        image = result["image"],
        email = result["email"],
        password = result["password"];

  Map<String, Object> toMap() {
    return
      {
        'username': username,
        'status': status,
        'image': image,
        'email': email,
        'password': password,
      };
  }

}