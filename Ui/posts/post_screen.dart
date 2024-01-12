import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:FirebasePractice/Ui/auth/login_Screen.dart';
import 'package:FirebasePractice/Ui/posts/add_post.dart';
import 'package:FirebasePractice/Utils/Utils.dart';

class Postscreen extends StatefulWidget {
  const Postscreen({super.key});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Test');
  final searchcontroller = TextEditingController();
  final editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Post_Screen"),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
            }).onError((error, stackTrace){
              Utils().toastmessage(error.toString());
            });
          }, icon: const Icon(Icons.logout_outlined)),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
             child: TextFormField(
               controller: searchcontroller,
               decoration: const InputDecoration(
                 hintText: 'Search',
                 border: OutlineInputBorder(),
               ),
               onChanged: (String value){
                 setState(() {

                 });
               },
             ),
           ),
          Expanded(
            child: FirebaseAnimatedList(
              defaultChild: const Text("Loading",style: TextStyle(fontWeight: FontWeight.w600),),
                query: ref,
                itemBuilder: (context,snapshot,animation,index){
                final title = snapshot.child('title').value.toString();
                if(searchcontroller.text.isEmpty){
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context)=>[
                           PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: (){
                                Navigator.pop(context);
                                showMyDailouge(title,snapshot.child('id').value.toString());
                              },
                              title: const Text("Edit"),
                              leading: const Icon(Icons.edit_outlined),
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: (){
                                ref.child(snapshot.child('id').value.toString()).remove();
                                Navigator.pop(context);
                              },
                              title: const Text("Delete"),
                              leading: const Icon(Icons.delete_outline_rounded),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if(title.toLowerCase().contains(searchcontroller.text.toLowerCase().toLowerCase())){
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                  );
                }else {
                  return Container();
                }

                }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddPost()));
        },child: const Icon(Icons.add),
        ),
    );
  }
  Future<void> showMyDailouge(String title, String id) async{
    editController.text= title;
    return showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Update'),
            content: SizedBox(
              child: TextField(
                controller: editController,
                decoration:const  InputDecoration(
                  hintText: 'edit',
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
                ref.child(id).update({
                  'title': editController.text.toLowerCase()
                }).then((value){
                  Utils().toastmessage("Post Update");
                }).onError((error, stackTrace){
                  Utils().toastmessage(error.toString());
                });
              }, child: const Text("Update")),
              TextButton(onPressed: (){
                Navigator.pop(context);},
                  child: const Text("Cancel"))
            ],
          );
        }

    );

  }
}
