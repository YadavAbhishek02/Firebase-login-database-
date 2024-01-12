import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:FirebasePractice/Utils/Utils.dart';
import 'package:FirebasePractice/widgets/roundbutton.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseref = FirebaseDatabase.instance.ref('Test');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
             const SizedBox(height: 20,),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'what is in your mind ?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20,),
            Roundbutton(
                title: 'Add',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading=true;
                  });
                  String io =DateTime.now().microsecondsSinceEpoch.toString();
                  databaseref.child(io).set({
                    'title':postController.text.toString(),
                    'id':io,

                  }).then((value) {
                    Utils().toastmessage("Post added");
                    setState(() {
                      loading=false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastmessage(error.toString());
                    setState(() {
                      loading=false;
                    });
                  });
            })
          ],
        ),
      ),
    );
  }
  Future<void> showMyDailouge() async{
    return showDialog(context: context,
        builder: (BuildContext context){
      return const AlertDialog(
        title: Text('Update'),
        content:  SizedBox(
          child: TextField(),
        ),
        actions: [

        ],
      );
        }

    );

  }
}
