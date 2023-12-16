import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasefirst/screens/homescreem.dart';
import 'package:firebasefirst/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _formkey = GlobalKey<FormState>();

class FormsView extends StatefulWidget {
  const FormsView({super.key});

  @override
  State<FormsView> createState() => _FormsViewState();
}

class _FormsViewState extends State<FormsView> { 

  @override
 dispose() {
   nameController.clear();
   ageController.clear();
   emailController.clear();
   createPasswordController.clear();
   comfirmPasswordController.clear();
  super.dispose();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController createPasswordController = TextEditingController();
  TextEditingController comfirmPasswordController = TextEditingController();

  List usersNames = [];

  bool Circular_Loader = false;

  signup()async{

            setState(() {
              Circular_Loader = true;
            });

            if (createPasswordController.text!=comfirmPasswordController.text) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password does not match')));
              setState(() {
              Circular_Loader = false;
            });
              return exitCode;
            }

    try {
            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: comfirmPasswordController.text,
            );

            //Storing the data in the firestore
            FirebaseFirestore.instance.collection('user').doc(credential.user!.uid).set({
              "Name": nameController.text,
              "Age" : ageController.text,
              "Email": emailController.text,
              "ConfirmPassword": comfirmPasswordController.text,
              "Id" : credential.user!.uid
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Successfully Signed In'),
            ));
            setState(() {
              Circular_Loader = false;
            });
            dispose();
          // ignore: use_build_context_synchronously, non_constant_identifier_names
          Navigator.push(context, MaterialPageRoute(builder: (Context)=>  HomeView(UserName: nameController.text)));
          
        } 
        on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Make Stronger Password !')));
            setState(() {
              Circular_Loader = false;
            });
          }
           else if (e.code == 'email-already-in-use') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email already in use !')));
            setState(() {
              Circular_Loader = false;
            });
          }
        } catch (e) {
          setState(() {
              Circular_Loader = false;
            });
          print(e);
        }
  }

  @override
  Widget build(BuildContext context) {
    return  
    Scaffold(
      body: 
        SingleChildScrollView(
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 150,
              ),
             Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Center(
                    child: Text('SIGN UP !',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                ),
            Container(
              margin: const EdgeInsets.only(left: 10,right: 10,top: 20),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Full Name'
                      ),
                      validator: (value) {
                        if (value==null || value.isEmpty) {
                          return 'Enter this field';
                        }
                        return null;
                      },
                      controller: nameController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Age'
                      ),
                      validator: (value) {
                        if (value==null || value.isEmpty) {
                          return 'Enter this field';
                        }
                        return null;
                      },
                      textCapitalization: TextCapitalization.characters,
                      controller: ageController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Email'
                      ),
                      validator: (value) {
                        if (value==null || value.isEmpty) {
                          return 'Enter this field';
                        }
                        return null;
                      },
                      controller: emailController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Create Password'
                      ),
                      validator: (value) {
                        if (value==null || value.isEmpty) {
                          return 'Enter this field';
                        }
                        return null;
                      },
                      controller: createPasswordController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Comfirm Password'
                      ),
                      validator: (value) {
                        if (value==null || value.isEmpty) {
                          return 'Enter this field';
                        }
                        return null;
                      },
                      controller: comfirmPasswordController,
                    ),
        
                    const SizedBox(
                      height: 30,
                    ),
        
                    //submit Buttom
                    ElevatedButton(onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        signup();
                      }
                    },
                      style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.amber)
                     ),
                     child: const SizedBox(
                      height: 60,
                      width: double.maxFinite,
                      child: Center(child: Text('SUBMIT !!',
                      style: TextStyle(
                        fontSize:16
                      ),
                      ))),
                     ),
        
                  //text button
                  InkWell(
                  onTap:() {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext)=> const LoginView())); 
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 44,
                      ),
                      Text('Already have an account? ',style: TextStyle(fontSize: 15),),
                      Text('Login',style: TextStyle(fontSize: 15,color: Colors.amber,fontWeight: FontWeight.w600))
                    ],
                  )),
        
                    
                    //loader 
                    if(Circular_Loader) const CircularProgressIndicator(
                      color: Colors.amber,
                     )
                  ], 
                )
                ),
            ),
        
          
          ],),
        ),
    );
  }
}