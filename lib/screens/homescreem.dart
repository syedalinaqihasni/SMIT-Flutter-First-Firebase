import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasefirst/screens/get_user_data.dart';
import 'package:firebasefirst/screens/usersList.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  
  final String UserName;
  const HomeView({super.key, required this.UserName});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: AppBar(
        title: Text('Hey $UserName'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext)=> const UserListView()));

            },
            icon: const Icon(Icons.person))
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 240, 215, 190),
      body: const Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.home,size: 60,),
          Text('Home', style: TextStyle(fontSize: 20),),
        ],
      )),

      drawer:  GetUserdata(documentId: FirebaseAuth.instance.currentUser!.uid )
 

          );
  }
}
