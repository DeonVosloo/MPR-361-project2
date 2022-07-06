import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:project2/pages/SignUp.dart';
import 'package:project2/pages/posts.dart';
import 'package:project2/pages/users.dart';
import 'databasemanager.dart';
import 'home.dart';

class Login extends StatefulWidget
{
  @override
  State<Login> createState() => _LoginState();


}

class _LoginState extends State<Login>
{
  TextEditingController usernameTextFieldController = TextEditingController();

  TextEditingController passwordTextFieldController = TextEditingController();

  late DBManager handler;

  // Future<void> addDummyUser() async
  // {
  //   Users dummyUser = Users(username: "test123", status: "test123", email: "test123@test123.com", image: "assets/default_pfp.png", password: "test123");
  //
  //   showDialog
  //     (
  //       context: context,
  //       builder: (BuildContext context)
  //       {
  //         return const AlertDialog(
  //           title: Text("User Added"),
  //           content: Text("Added dummy user"),
  //         );
  //       });
  //
  //   return await handler.insertUser(dummyUser);
  // }
  //
  // Future<void> addDummyPost1() async
  // {
  //   Post dummyPost = Post(comment: "Hello New York City!!", image: "assets/nyc.jpg", likes: 37, dislikes: 2, userID: 1);
  //
  //   showDialog
  //     (
  //       context: context,
  //       builder: (BuildContext context)
  //       {
  //         return const AlertDialog(
  //           title: Text("User Post Added"),
  //           content: Text("Added dummy user post"),
  //         );
  //       });
  //
  //   return await handler.insertPost(dummyPost);
  // }
  //
  // Future<void> addDummyPost2() async
  // {
  //   Post dummyPost = Post(comment: "What a beautiful photo of an elephant!!", image: "assets/pfp.jpg", likes: 19, dislikes: 1, userID: 1);
  //
  //   showDialog
  //     (
  //       context: context,
  //       builder: (BuildContext context)
  //       {
  //         return const AlertDialog(
  //           title: Text("User Post Added"),
  //           content: Text("Added dummy user post"),
  //         );
  //       });
  //
  //   return await handler.insertPost(dummyPost);
  // }
  //
  // Future<void> addDummyPost3() async
  // {
  //   Post dummyPost = Post(comment: "Look at these cute tigers!!", image: "assets/post.jpg", likes: 8, dislikes: 0, userID: 1);
  //
  //   showDialog
  //     (
  //       context: context,
  //       builder: (BuildContext context)
  //       {
  //         return const AlertDialog(
  //           title: Text("User Post Added"),
  //           content: Text("Added dummy user post"),
  //         );
  //       });
  //
  //   return await handler.insertPost(dummyPost);
  // }
  //
  // Future<void> RemoveDummyUser(int id) async
  // {
  //
  //   showDialog
  //     (
  //       context: context,
  //       builder: (BuildContext context)
  //       {
  //         return const AlertDialog(
  //           title: Text("Users Removed"),
  //           content: Text("Removed dummy users"),
  //         );
  //       });
  //
  //   return await handler.deleteUser(id);
  // }
  //
  // @override
  // void initState()
  // {
  //   super.initState();
  //   handler = DBManager();
  //   handler.initializedDB().whenComplete(() async
  //   {
  //     /* All of the dummy users and posts added here are just for testing purposes */
  //     //await RemoveDummyUser(1);
  //     //await addDummyUser();
  //     //await addDummyPost1();
  //     //await addDummyPost2();
  //     //await addDummyPost3();
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      body: ListView
        (
        children:
        [
          Padding
            (
            padding: const EdgeInsets.fromLTRB(1, 50, 1, 1),
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
                    radius: 90.0,
                    backgroundImage: AssetImage('assets/flutter.png'),
                  ),
                ),
                const SizedBox(height: 8,),

                Text("Flutter Galaxy", style: GoogleFonts.dancingScript(fontSize: 24, color: Colors.black,),),

                Padding
                  (
                  padding: const EdgeInsets.fromLTRB(45,1,45,1),
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
                    padding: const EdgeInsets.fromLTRB(45,1,45,1),
                  child: TextField
                    (
                    controller: passwordTextFieldController,
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
                        child: Text("Login", style: GoogleFonts.roboto(fontSize: 20),),
                        onPressed: ()
                        {
                          LoginVerification(context, usernameTextFieldController, passwordTextFieldController );
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
                        child:  Text("Sign Up", style: GoogleFonts.roboto(fontSize: 20)),
                        onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// ignore: non_constant_identifier_names
LoginVerification(BuildContext context, TextEditingController usernameTextFieldController, TextEditingController passwordTextFieldController )
async
{
  String username = usernameTextFieldController.text;
  String password = passwordTextFieldController.text;

  Users user = Users(null,username: username, status: "", email: "", image: "", password: password);
  bool validUser = false;



   List<Users> existingUsers = await DBManager().retrieveUsers();

  for(int i = 0;i < existingUsers.length; i++)
  {
    if(user.username == existingUsers[i].username && user.password == existingUsers[i].password)
    {
      user = existingUsers[i];
      validUser = true;

      List<Post> userPosts = await DBManager().retrieveUserPosts(user);
      // ignore: use_build_context_synchronously
      return Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(user: user, userPosts: userPosts)));
    }
  }
    // usernameTextFieldController.clear();
    // passwordTextFieldController.clear();

    if(validUser == false)
    {
      showDialog
        (
          context: context,
          builder: (BuildContext context)
          {
            return const AlertDialog(
              title: Text("Incorrect username or password"),
              content: Text("Incorrect username or password, if you don't have an Flutter Galaxy account you can create one with the signup button"),
            );
          });
    }


  }



