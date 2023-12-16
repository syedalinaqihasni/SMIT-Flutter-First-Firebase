// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebasefirst/homescreem.dart';
// import 'package:firebasefirst/loginscreen.dart';
// import 'package:flutter/material.dart';

// class RegisterView extends StatefulWidget {
//   const RegisterView({super.key});

//   @override
  
//   State<RegisterView> createState() => _RegisterViewState();
// }

// class _RegisterViewState extends State<RegisterView> {

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   bool Loader = false;

//   register() async {
//     if (confirmPasswordController.text!=passwordController.text) {
//                 showDialog(context: context, builder: (BuildContext) {
//                   return const AlertDialog(
//                     title: Text('Passwoed Does not match'),
//                   );
//                 });
//                 return;
//               }
//             try {
//               setState(() {
//              Loader = true;
//            });
//             final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//             email: emailController.text,
//             password: passwordController.text,
//             );
            
//            setState(() {
//              Loader = false;
//            });
//           Navigator.push(context, MaterialPageRoute(builder: (Context)=>  HomeView(UserName: nameController.text,)));
          
//         } 
//         on FirebaseAuthException catch (e) {
//           if (e.code == 'weak-password') {
//             showDialog(context: context, builder: (BuildContext) {
//               return const AlertDialog(
//                 title: Text("Make Stronger Password !"),
//               );
//             });
//             setState(() {
//               Loader = false;
//             });
//           }
//            else if (e.code == 'email-already-in-use') {
//             showDialog(context: context, builder: (BuildContext) {
//               return const AlertDialog(
//                 title: Text("Email already in use !"),
//               );
//             });
//             setState(() {
//               Loader = false;
//             });
//           }
//         } catch (e) {
//           print(e);
//         }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               margin: const EdgeInsets.only(bottom: 30),
//                 child: const Center(
//                   child: Text('REGISTER HERE!',
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w500
//                   ),
//                   ),
//                 ),
//               ),
//               Container(
//               margin: const EdgeInsets.all(10),
//               color: const Color.fromARGB(255, 205, 204, 204),
//               child: TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter Name',
//                   contentPadding: EdgeInsets.only(left: 10)
//                 ),
//               )
//               ),
//             Container(
//               margin: const EdgeInsets.all(10),
//               color: const Color.fromARGB(255, 205, 204, 204),
//               child: TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter Email',
//                   contentPadding: EdgeInsets.only(left: 10)
//                 ),
//               )
//               ),
//             Container(
//               margin: const EdgeInsets.all(10),
//               color: const Color.fromARGB(255, 205, 204, 204),
//               child: TextField(
//                 decoration: const InputDecoration(
//                   hintText: 'Create Password',
//                   contentPadding: EdgeInsets.only(left: 10)
//                 ),
//                 controller: passwordController,
//                 obscureText: true,
//               )
//               ),
//               Container(
//               margin: const EdgeInsets.all(10),
//               color: const Color.fromARGB(255, 205, 204, 204),
//               child: TextField(
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   hintText: 'ComFirm Password',
//                   contentPadding: EdgeInsets.only(left: 10)
//                 ),
//                 controller: confirmPasswordController,
//               )
//               ),


//             ElevatedButton(onPressed: () {
//                 register();
//               }, 
//               child: Container(
//                 margin: EdgeInsets.only(left: 20,right: 20),
//                 width: 320,
//                 height: 50,
//                 child: Center(child: Text('Register'))),
//                 style: const ButtonStyle(
//                   backgroundColor: MaterialStatePropertyAll(Colors.amber)
//                 ),
//               ),


//             InkWell(
//               child: Container(
//                 margin: const EdgeInsets.only(top: 20),
//                 child: const Text('Already have an account? Login!')),
//               onTap: () {
//                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext)=> LoginView()));
//               },
//             ),

//             if (Loader) const LoaderWidget(),

//           ],
//         )),
//     );
//   }
// }

// class LoaderWidget extends StatelessWidget {
//   const LoaderWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       margin: const EdgeInsets.only(top: 20),
//       child: const CircularProgressIndicator(
//         color: Colors.amber,
//       ),
//     );
//   }
// }

