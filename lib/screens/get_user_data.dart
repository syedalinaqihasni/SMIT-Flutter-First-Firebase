import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginscreen.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class GetUserdata extends StatelessWidget {
  final String documentId;

  GetUserdata({super.key, required this.documentId});

  final ImagePicker _imagePicker = ImagePicker();
  File? imageFile;

  selectImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('user');

    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Drawer(
            child: ListView(
              children: [
                Container(
                  height: 150,
                  width: double.maxFinite,
                  color: Colors.amber,
                  child: ListTile(
                    leading: InkWell(
                      onTap: () {
                        selectImage();
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 113, 161, 244),
                        child: Image.file(imageFile!),
                      ),
                    ),
                    title: Text(data['Name']),
                    subtitle: Text(data['Email']),
                  ),
                ),
                ExpansionTile(
                  title: const Text('Account details'),
                  onExpansionChanged: (value) => true,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text(
                          'Information on how to contact a person or entity, typically including a telephone number, address etc Information on how to contact a person or entity, typically including a telephone number, address etc Information on how to contact a person or entity, typically including a telephone number, address etc'),
                    )
                  ],
                ),
                ExpansionTile(
                  title: const Text('Contact details'),
                  onExpansionChanged: (value) => true,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Text('Email : ${data['Email']}'),
                    )
                  ],
                ),
                ExpansionTile(
                  title: const Text('Data'),
                  onExpansionChanged: (value) => true,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text('${data['Age']} Years old'
                          '\nInformation on how to contact a person or entity, typically including a telephone number, address etc Information on how to contact a person or entity, typically including a telephone number, address etc Information on how to contact a person or entity, typically including a telephone number, address etc'),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text(
                          'Information on how to contact a person or entity, typically including a telephone number, address etc Information on how to contact a person or entity, typically including a telephone number, address etc Information on how to contact a person or entity, typically including a telephone number, address etc'),
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const ListTile(
                    title: Text('Settings'),
                    trailing: Icon(Icons.settings),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext) => const LoginView()));
                  },
                  child: const ListTile(
                    title: Text('Logout'),
                    trailing: Icon(Icons.logout),
                  ),
                )
              ],
            ),
          );
        }
        return const Text("loading");
      },
    );
  }
}
