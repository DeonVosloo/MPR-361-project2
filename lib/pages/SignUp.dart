import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:project2/pages/home.dart';
import 'package:project2/pages/picture.dart';
import 'package:project2/pages/posts.dart';
import 'package:project2/pages/users.dart';
import 'package:sqflite/sqflite.dart';
import 'package:image_picker/image_picker.dart';

import 'CreatePost.dart';
import 'Utility.dart';
import 'databasemanager.dart';

Photo selectedPhoto = Photo(null, postid: null, photo_name: "", userid: 0);

class SignUp extends StatefulWidget
{
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameTextFieldController = TextEditingController();
  TextEditingController passwordTextFieldController1 = TextEditingController();
  TextEditingController passwordTextFieldController2 = TextEditingController();
  TextEditingController emailTextFieldController = TextEditingController();

  late DBManager handler;

  @override
  Widget build(BuildContext context)
  {
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
                      const Center
                        (
                        child: CircleAvatar
                          (
                          backgroundColor: Colors.transparent,
                          radius: 30.0,
                          backgroundImage: AssetImage('assets/flutter.png'),
                        ),
                      ),
                      const SizedBox(height: 1,),

                      Text("Sign Up", style: GoogleFonts.dancingScript(fontSize: 24, color: Colors.black,),),

                      Padding
                        (
                        padding: const EdgeInsets.fromLTRB(35,1,35,1),
                        child: TextField
                          (
                          controller: usernameTextFieldController,
                          decoration: const InputDecoration
                            (

                            labelText: "Enter username",
                          ),
                          style: GoogleFonts.roboto
                            (
                            fontSize: 24,
                          ),
                        ),
                      ),

                      Padding
                        (
                        padding: const EdgeInsets.fromLTRB(35,1,35,1),
                        child: TextField
                          (
                          controller: passwordTextFieldController1,
                          obscureText: true,
                          decoration: const InputDecoration
                            (
                            labelText: "Enter password",
                          ),
                          style: GoogleFonts.roboto
                            (
                            fontSize: 24,
                          ),
                        ),
                      ),

                      Padding
                        (
                        padding: const EdgeInsets.fromLTRB(35,1,35,1),
                        child: TextField
                          (
                          controller: passwordTextFieldController2,
                          obscureText: true,
                          decoration: const InputDecoration
                            (
                            labelText: "Enter password again",
                          ),
                          style: GoogleFonts.roboto
                            (
                            fontSize: 24,
                          ),
                        ),
                      ),

                      Padding
                        (
                        padding: const EdgeInsets.fromLTRB(35,1,35,1),
                        child: TextField
                          (
                          controller: emailTextFieldController,
                          obscureText: true,
                          decoration: const InputDecoration
                            (
                            labelText: "Enter email",
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
                        child: Text("Choose Profile Picture", style: GoogleFonts.roboto(fontSize: 21,),),
                        onPressed: ()
                        {
                          ChooseImageFromGalary(ImageSource.gallery);
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
                              child:  Text("Sign Up", style: GoogleFonts.roboto(fontSize: 20,)),
                              onPressed: ()
                              {
                                Signup(context, usernameTextFieldController, passwordTextFieldController1, passwordTextFieldController2, emailTextFieldController);
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


Signup(BuildContext context, TextEditingController usernameTextFieldController, TextEditingController passwordTextFieldController1
    , TextEditingController passwordTextFieldController2, TextEditingController emailTextFieldController)
async
{
  String username = usernameTextFieldController.text;
  String password1 = passwordTextFieldController1.text;
  String password2 = passwordTextFieldController2.text;
  String email = emailTextFieldController.text;

  bool isNewUser = true;

  final db = await DBManager().initializedDB();
  List<Users> existingUsers = await DBManager().retrieveUsers();

  Users user = Users(null,username: username, status: "New to flutter galaxy", email: email, image: selectedPhoto.photo_name!, password: password1);

  for(int i = 0;i < existingUsers.length; i++)
  {
    if (user.username == existingUsers[i].username ||
        user.email == existingUsers[i].email)
    {
      isNewUser = false;
      if(user.email == existingUsers[i].email)
        {
          showDialog
            (
              context: context,
              builder: (BuildContext context)
              {
                return const AlertDialog
                  (
                  title: Text("email is already registered"),
                  content: Text("email is already registered with flutter galaxy"),
                );
              });
        }
      else if(user.username == existingUsers[i].username)
        {
          showDialog
            (
              context: context,
              builder: (BuildContext context)
              {
                return const AlertDialog
                  (
                  title: Text("Username taken"),
                  content: Text("Username is already registered with flutter galaxy"),
                );
              });
        }
    }
  }

  if(isNewUser == true)
  {
    if(CheckPasswordsMatch(password1, password2, context) == true)
    {
      DBManager().insertUser(user);

      List<Users> existingUsers = await DBManager().retrieveUsers();

      for(int i = 0;i < existingUsers.length; i++)
      {
        if(user.username == existingUsers[i].username)
        {
          user = existingUsers[i];
        }
      }

      List<Post> userPosts = await DBManager().retrieveUserPosts(user);

      showDialog
        (
          context: context,
          builder: (BuildContext context)
          {
            return AlertDialog(
              title: const Text("User Added"),
              content: Text("User: $username \nAdded to flutter Galaxy Database \n isNewUserValue"),
            );
          });
      // ignore: use_build_context_synchronously
      return Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(user: user, userPosts: userPosts)));
    }
  }
  else
  {
    if(CheckPasswordsMatch(password1,password2, context) == true);
  }
  }

// ignore: non_constant_identifier_names
bool CheckPasswordsMatch(String password1, String password2, context)
{
  if(password1 == password2)
    {
      return true;
    }
  else
    {
      showDialog
        (
          context: context,
          builder: (BuildContext context)
          {
            return const AlertDialog(
              title: Text("Passwords don't match"),
              content: Text("The passwords don't match, please make sure the passwords match"),
            );
          });

      return false;
    }
}

void ChooseImageFromGalary(ImageSource source) async
{
  MediaType _mediaType = MediaType.image;
  XFile? file;
  if (_mediaType == MediaType.image)
  {
    file = await ImagePicker().pickImage(source: source);
    String imgString = Utility.base64String(await file!.readAsBytes());


    List<Photo> existingImages = await DBManager().getPictures();

    Photo photo = Photo(null, postid: null, photo_name: imgString);
    selectedPhoto = Photo(null, postid: null, photo_name: imgString);
    DBManager().savePicture(photo);
  }
}