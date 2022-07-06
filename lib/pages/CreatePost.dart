import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project2/pages/home.dart';
import 'package:project2/pages/picture.dart';
import 'package:project2/pages/posts.dart';
import 'package:project2/pages/users.dart';
import 'package:sqflite/sqflite.dart';

import 'Utility.dart';
import 'databasemanager.dart';

int currentPostID = 0;
Photo selectedPhoto = Photo(null, postid: null, photo_name: "", userid: 0);


enum MediaType
{
  image,
  video;
}

class CreatePost extends StatefulWidget
{
  final Users user;
  const CreatePost({Key? key, required this.user}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost>
{
  TextEditingController postTextFieldController = TextEditingController();

  late DBManager handler;

  @override
  Widget build(BuildContext context)
  {
     MemoryImage imageFromBase64String(String base64String)
     {
      return MemoryImage
        (
          base64Decode(base64String)
      );
    }

    return Scaffold
      (

        body: Container
          (
          decoration: const BoxDecoration
            (
            image: DecorationImage
              (
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),

          child: ListView
            (
            children:
            [
              Padding
                (
                  padding: const EdgeInsets.fromLTRB(1, 50, 1, 1),
                  child: Container
                    (
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(10),

                    decoration: BoxDecoration
                      (
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2.5, color: Colors.lightBlueAccent,)

                    ),
                    child: Column
                      (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                         Center
                          (
                          child: CircleAvatar
                            (
                            backgroundColor: Colors.transparent,
                            radius: 30.0,
                            backgroundImage: Utility.imageFromBase64String(widget.user.image), //,
                          ),
                        ),
                        const SizedBox(height: 1,),

                        Text("Create New Post", style: GoogleFonts.dancingScript(fontSize: 24, color: Colors.black,),),

                        Padding
                          (
                          padding: const EdgeInsets.fromLTRB(35,1,35,1),
                          child: TextField
                            (
                            controller: postTextFieldController,
                            decoration: const InputDecoration
                              (

                              labelText: "Enter Post Caption",
                            ),
                            style: GoogleFonts.roboto
                              (
                              fontSize: 24,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20,),

                        ElevatedButton
                          (
                          style: ElevatedButton.styleFrom(minimumSize: const Size(90, 30)),
                          child: Text("Choose Post Picture", style: GoogleFonts.roboto(fontSize: 21,),),
                          onPressed: ()
                          {
                            ChooseImageFromGalary(ImageSource.gallery, widget.user);
                          },
                        ),

                        Row
                          (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Padding
                              (
                              //padding: EdgeInsets.all(1),
                              padding: const EdgeInsets.fromLTRB(15,22,15,0),
                              child: ElevatedButton
                                (
                                style: ElevatedButton.styleFrom(minimumSize: const Size(90, 30)),
                                child: Text("Go Back", style: GoogleFonts.roboto(fontSize: 21,),),
                                onPressed: ()
                                {
                                  Navigator.pop(context);
                                },
                              ),
                            ),

                            Padding
                              (
                              //padding: EdgeInsets.all(1),
                              padding: const EdgeInsets.fromLTRB(15,22,15,0),
                              child: ElevatedButton
                                (
                                style: ElevatedButton.styleFrom(minimumSize: const Size(90, 30)),
                                child:  Text("Add Post", style: GoogleFonts.roboto(fontSize: 20,)),
                                onPressed: ()
                                {
                                  AddPost(widget.user, context, postTextFieldController);
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              ),
            ],
          ),
        )
    );
  }
}

void ChooseImageFromGalary(ImageSource source, Users user) async
{
  MediaType _mediaType = MediaType.image;
  XFile? file;
  if (_mediaType == MediaType.image)
  {
    file = await ImagePicker().pickImage(source: source);
    String imgString = Utility.base64String(await file!.readAsBytes());


    List<Post> existingPosts = await DBManager().retrieveUserPosts(user);

    // for(int i = 0;i < existingPosts.length; i++)
    // {
    //   if(i == existingPosts.length)
    //   {
    //     currentPostID = i+1;
    //   }
    // }
    Photo photo = Photo(null,postid: null, photo_name: imgString, userid: user.id);
    selectedPhoto = Photo(null,postid: null, photo_name: imgString, userid: user.id);
    DBManager().savePicture(photo);
  }
}

Future<Future<Object?>> AddPost(Users user, context, TextEditingController postTextFieldController) async
{
  Post dummyPost = Post(comment: postTextFieldController.text, image: selectedPhoto.photo_name!, likes: 0, dislikes: 0, userID: user.id!);
  await DBManager().insertPost(dummyPost);
  List<Post> userPosts = await DBManager().retrieveUserPosts(user);

  return Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(user: user, userPosts: userPosts)));

  //return
}
