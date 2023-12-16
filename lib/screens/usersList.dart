import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fetching Firestore Users Data'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('user').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Text('Error 404');
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext, int index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(data['Name']),
                        trailing: IconButton(
                            onPressed: () {
                              // FirebaseFirestore.instance.collection('user').doc(data['Name']).delete();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Account deleted successfully')),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: Text('Name of the user is : ${data['Name']}')),
                      Container(
                          padding: const EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child:
                              Text('Email of the user is : ${data['Email']}')),
                      Container(
                          padding: const EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: Text('Age of the user is : ${data['Age']}')),
                      Container(
                          padding: const EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: Text('Id of the user is : ${data['Id']}'))
                    ],
                  );
                });
          },
        ));
  }
}
