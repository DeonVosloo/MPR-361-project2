import 'dart:typed_data';

// ignore: camel_case_types
class Photo
{
  int? id;
  int? userid;
  int? postid;
  String? photo_name;

  Photo(this.id ,{required this.photo_name, this.userid, this.postid});

  Map<String, dynamic> toMap()
  {
    var map = <String, dynamic>{
      'id': id,
      'userid': id,
      'postid': id,
      'photo_name': photo_name,
    };
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map)
  {
    id = map['id'];
    userid = map['userid'];
    postid = map['postid'];
    photo_name = map['photo_name'];
  }
}