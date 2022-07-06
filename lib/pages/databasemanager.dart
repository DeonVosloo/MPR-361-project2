import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:project2/pages/users.dart';
import 'package:sqflite/sqflite.dart';
import 'picture.dart';
import 'posts.dart';

class DBManager
{
  Future<Database> initializedDB() async
  {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'fluttergalaxy.db'),
      version: 1,
      onCreate: (Database db, int version) async
      {
        await db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT , username TEXT NOT NULL,status TEXT, image TEXT, email TEXT NOT NULL, password TEXT NOT NULL )",
        );

        await db.execute(
          "CREATE TABLE posts(id INTEGER PRIMARY KEY AUTOINCREMENT , comment TEXT,image TEXT NOT NULL,likes INTEGER,dislikes  INTEGER NOT NULL, userid INTEGER, FOREIGN KEY(userid) REFERENCES users(id), FOREIGN KEY(imageid) REFERENCES images(id))",
        );

        await db.execute("CREATE TABLE images(id INTEGER PRIMARY KEY AUTOINCREMENT, image TEXT, userid INTEGER, postid INTEGER, FOREIGN KEY(userid) REFERENCES users(id), FOREIGN KEY(postid) REFERENCES posts(id)) ");
      },
    );
  }

// insert user
  Future<void> insertUser(Users user) async
  {
    final Database db = await initializedDB();
      await db.insert
        (
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    //retrieve users
  Future<List<Users>> retrieveUsers() async
  {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => Users.fromMap(e)).toList();
  }

  // Update user
  Future<void> updateUser(Users user) async
  {
    final Database db = await initializedDB();

    await db.update
      (
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async
  {
    final db = await initializedDB();
    await db.delete(
      'users',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> insertPost(Post post) async
  {
    final Database db = await initializedDB();

    await db.insert(
      'posts',
      post.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //retrieve users
  Future<List<Post>> retrieveUserPosts(Users user) async
  {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('posts', where: 'userid = ?', whereArgs: [user.id]);
    return queryResult.map((e) => Post.fromMap(e)).toList();
  }

  // Update user
  Future<void> updatePost(Post post) async
  {
    final Database db = await initializedDB();

    await db.update(
      'posts',
      post.toMap(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
  }

// delete user
  Future<void> deletePost(int id) async
  {
    final db = await initializedDB();
    await db.delete(
      'posts',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  void savePicture(Photo picture) async
  {
    final Database db = await initializedDB();
    await db.insert("image", picture.toMap());
  }

  Future<List<Photo>> getPictures() async
  {
    final Database db = await initializedDB();
    final List<Map<String, Object?>> queryResult = await db.query('images');
    return queryResult.map((e) => Photo.fromMap(e)).toList();
  }

  // Future<List<Photo>> getPicture(Photo picture) async
  // {
  //   final Database db = await initializedDB();
  //   final List<Map<String, Object?>> queryResult = await db.query
  //     (
  //     'images',
  //     where: 'id = ?',
  //     whereArgs: [picture.id],
  //   );
  //   return queryResult.map((e) => Photo.fromMap(e)).toList();
  // }

  Future<void> updatePicture(Photo picture) async
  {
    final Database db = await initializedDB();

    await db.update
      (
      'images',
      picture.toMap(),
      where: 'id = ?',
      whereArgs: [picture.id],
    );
  }

  Future<void> deletePicture(int id) async
  {
    final db = await initializedDB();
    await db.delete(
      'images',
      where: "id = ?",
      whereArgs: [id],
    );
  }

}



