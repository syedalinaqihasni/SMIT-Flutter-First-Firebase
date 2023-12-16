import 'package:flutter/material.dart';

class FutureAndStream extends StatefulWidget {
  const FutureAndStream({super.key});

  @override
  State<FutureAndStream> createState() => _FutureAndStreamState();
}

class _FutureAndStreamState extends State<FutureAndStream> {
   
  int value=50;
  Future <int> increment()async{
    await Future.delayed(const Duration(seconds: 3));
       return value+10;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              child: FutureBuilder(
                future: increment(),
                builder: (context , Snapshot){
                  return Text('Future : $value ',style: const TextStyle(fontSize: 30),);
                }
              )
              
              // Text('Future : '),
            ),
          )
        ],
      ),
    );
  }
}