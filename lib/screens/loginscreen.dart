import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasefirst/screens/formSignup.dart';
import 'package:firebasefirst/screens/homescreem.dart';
import 'package:flutter/material.dart';

final _loginKey = GlobalKey<FormState>();

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool Loader = false;

  login() async {
    try {
      setState(() {
        Loader = true;
      });
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      setState(() {
        Loader = false;
      });
      dispose();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  HomeView(UserName: emailController.text)));

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Welcome Back!')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          Loader = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        setState(() {
          Loader = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong password provided for that user.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const Center(
                  child: Text(
                    'LOGIN IN !',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Form(
                  key: _loginKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5),
                            hintText: 'Enter Email'),
                        cursorColor: Colors.amber,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter this field';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        cursorColor: Colors.amber,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5),
                            hintText: 'Enter Password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter this field';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              ElevatedButton(
                onPressed: () {
                  if (_loginKey.currentState!.validate()) {
                    login();
                  }
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: 320,
                    height: 50,
                    child: const Center(child: Text('Login'))),
              ),

              //text button
              InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext) => const FormsView()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 44,
                      ),
                      Text(
                        'Dont have a account? ',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text('Create account!',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.amber,
                              fontWeight: FontWeight.w600))
                    ],
                  )),

              if (Loader) const LoaderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Color.fromARGB(255, 249, 202, 61),
    );
  }
}
