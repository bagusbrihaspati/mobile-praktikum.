
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const new({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text ('Home'),
        elevation: 1,
      ) ,
      body:Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text ('salam harmoni'),
                Text ('bagus', style: TextStyle(color: Colors.blue),),
              ]
            ),
            Text ('Om swastiastu, rahajeng semeng'),
          ],
        ),
      ) ,

    );
  }
}