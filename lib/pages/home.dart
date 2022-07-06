import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project2/pages/databasemanager.dart';

import 'CreatePost.dart';
import 'Utility.dart';
import 'users.dart';
import 'posts.dart';

class HomeScreen  extends StatelessWidget
{
  final Users user;
  final List<Post> userPosts;
  const HomeScreen({Key? key, required this.user, required this.userPosts,}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
      extendBodyBehindAppBar: true,
      appBar: AppBar
        (
        leading: Container
          (
          decoration:  BoxDecoration
            (
            shape: BoxShape.circle,
            image: DecorationImage
              (
              image: Utility.imageFromBase64String(user.image),fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(user.username, style: GoogleFonts.roboto(color: Colors.white)),
          flexibleSpace: const Image
            (
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
          ),
        //backgroundColor: Colors.lightBlueAccent,
        backgroundColor: Colors.transparent,
        toolbarHeight: 38,
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu_rounded, color: Colors.lightBlueAccent,))],
      ),

        body: Container
          (
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          decoration: const BoxDecoration
            (
            image: DecorationImage
              (
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),

          child: ListView.builder
            (
              itemCount: userPosts.length,
              itemBuilder: (context, index)
              {
                Post currentPost = userPosts[index];
                if(userPosts.isEmpty)
                {
                  return Container
                  (
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                decoration: const BoxDecoration
                (
              ),
                    child: Column
                      (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        Card
                          (
                          child: Text("No user Posts found", style: GoogleFonts.roboto(fontSize: 20)),
                        )

                      ],
                    ),
                  );


                }
                else
                {
                  return ListView
                      (
                      padding: const EdgeInsets.all(1),
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      children:
                      [
                        Card
                          (
                            child: Column
                              (
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              [
                                SizedBox
                                  (
                                  //height: 68,
                                  child: Card
                                    (
                                    child: ListTile
                                      (
                                      title: Text(user.username, style: GoogleFonts.roboto()),
                                      subtitle: Text(user.status, style: GoogleFonts.roboto()),
                                      trailing: IconButton
                                        (
                                        icon: const Icon(Icons.menu, color: Colors.black,),
                                        onPressed: (){},
                                      ),
                                      leading: CircleAvatar
                                        (
                                        backgroundImage: Utility.imageFromBase64String(user.image),
                                        radius: 20,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox
                                  (
                                  height: 185,
                                  child: Image(image: Utility.imageFromBase64String(currentPost.image), fit: BoxFit.fitWidth, width: double.infinity, height: 250,),
                                ),

                                Row
                                  (
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:
                                  [
                                    Row
                                      (
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:
                                      [

                                        IconButton
                                          (
                                          icon: const Icon(Icons.thumb_up, color: Colors.black54,),
                                          onPressed: (){},
                                        ),

                                        IconButton
                                          (
                                          icon: const Icon(Icons.thumb_down, color: Colors.black54,),
                                          onPressed: (){},
                                        ),
                                      ],
                                    ),

                                    Row
                                      (
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:
                                      [
                                        IconButton
                                          (
                                          icon: const Icon(Icons.comment, color: Colors.black54,),
                                          onPressed: (){},
                                        ),

                                      ],
                                    )

                                  ],
                                ),

                                Column
                                  (
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                  [
                                    Padding
                                      (
                                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                                      child: Text("${currentPost.likes} Likes", style: GoogleFonts.roboto() ),
                                    ),

                                    Padding
                                      (
                                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(currentPost.comment, style: GoogleFonts.roboto(),)
                                    ),

                                  ],
                                ),

                                const SizedBox(height: 10,)

                              ],
                            )
                        ),

                        const SizedBox(height: 2,),


                      ],
                    );


                }

              }
          ),

        ),

      // body:

      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePost(user: user)));
        },
        backgroundColor: Colors.lightBlueAccent,
        icon: const Icon(Icons.add),
        label: const Text("Add Post"),
      ),

    );
  }
}




