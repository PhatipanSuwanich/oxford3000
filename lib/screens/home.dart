// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: Get.width),
              Text("เกมแปลคําศัพท์ Oxford Wordlist", style: sizeB32),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/learn');
                },
                child: Text("Game Start!!", style: size24),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  minimumSize: Size(200, 60),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
