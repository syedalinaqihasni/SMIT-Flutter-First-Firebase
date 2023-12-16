import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomStorage extends StatefulWidget {
  const CustomStorage({super.key});

  @override
  State<CustomStorage> createState() => _CustomStorageState();
}

class _CustomStorageState extends State<CustomStorage> {
  final ImagePicker _imagePicker = ImagePicker();
  File? imageFile;

  getImage() async {
    final selectedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      imageFile = File(selectedImage.path);
      setState(() {});
    }
  }

  deleteImage() async {
    FirebaseStorage.instance
        .ref()
        .child(FirebaseFirestore.instance
            .collection("user")
            .doc(FirebaseAuth.instance.currentUser as String?) as String)
        .delete();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Deleted File')));
  }

  uploadFile() async {
    await FirebaseStorage.instance
        .ref()
        .child(FirebaseFirestore.instance
            .collection("user")
            .doc(FirebaseAuth.instance.currentUser as String?) as String)
        .putFile(imageFile!);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File successfully Uploaded')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Firebase Storage")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            imageFile != null
                ? Center(child: Image.file(imageFile!))
                : Center(
                    child: ElevatedButton(
                        onPressed: () {
                          getImage();
                        },
                        child: const Text('Pick Image')),
                  ),
            ElevatedButton(
                onPressed: () {
                  uploadFile();
                },
                child: const Text('Upload File')),
            ElevatedButton(
                onPressed: () {
                  deleteImage();
                },
                child: const Text('Delete File'))
          ],
        ),
      ),
    );
  }
}
