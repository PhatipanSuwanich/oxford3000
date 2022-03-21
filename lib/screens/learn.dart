// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../models/vocabulary.dart';
import '../services/mockJson.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({Key? key}) : super(key: key);
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  late List<String> eng;
  late List<String> th;
  final FlutterTts flutterTts = FlutterTts();
  TextEditingController answerController = TextEditingController();
  int total = 1;

  @override
  void initState() {
    super.initState();
    eng = Vocabulary.fromJson(mockJsonWord).eng!.toList();
    th = Vocabulary.fromJson(mockJsonWord).th!.toList();
    var random = Random().nextInt(50);
    eng.shuffle(Random(random));
    th.shuffle(Random(random));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(th[0],
                  style: TextStyle(
                      backgroundColor: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold)),
              englishSound(),
              SizedBox(height: 40),
              Answer(),
              SizedBox(height: 50),
              CheckButton(),
              SizedBox(height: 80),
              Text("คำที่ $total / 100",
                  style: TextStyle(
                      backgroundColor: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Container englishSound() {
    return Container(
      color: Colors.white,
      child: TextButton.icon(
          onPressed: () => speakWord(),
          icon: Icon(
            Icons.volume_up_sharp,
            color: Colors.teal,
          ),
          label: Text(
            'English Sound',
            style: TextStyle(
              fontSize: 24,
              color: Colors.teal,
            ),
          )),
    );
  }

  SizedBox CheckButton() {
    return SizedBox(
      width: 620,
      height: 40,
      child: ElevatedButton(
          onPressed: () => CheckAnswer(), child: Text("ตรวจ", style: size24)),
    );
  }

  void CheckAnswer() {
    Widget content;
    speakWord();
    if (answerController.text == eng[0]) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("ถูกต้อง",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.teal,
                  decoration: TextDecoration.none)),
          SizedBox(height: 15),
          SizedBox(
            width: Get.width,
            child: ElevatedButton(
              onPressed: () => nextWord(),
              child: Text("ถัดไป", style: size24),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
              ),
            ),
          ),
        ],
      );
    } else {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "คำตอบที่ถูกต้อง : ${eng[0]}",
            style: TextStyle(
                fontSize: 24,
                color: Colors.red,
                decoration: TextDecoration.none),
          ),
          SizedBox(height: 15),
          SizedBox(
            width: Get.width,
            child: ElevatedButton(
              onPressed: () => nextWord(),
              child: Text("ถัดไป", style: size24),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ),
        ],
      );
    }
    showGeneralDialog(
      barrierLabel: "lable",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 00, 10, 0),
            height: 100,
            width: 620,
            child: content,
            margin: EdgeInsets.only(bottom: 50, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
          Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  void nextWord() {
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {
      eng.removeAt(0);
      th.removeAt(0);
      total = 101 - eng.length;
      answerController.text = "";
    });
  }

  SizedBox Answer() {
    return SizedBox(
      width: 620,
      child: TextField(
        controller: answerController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey,
          hintText: "พิมพ์เป็นภาษาอังกฤษ",
        ),
      ),
    );
  }

  Future speakWord() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.2);
    await flutterTts.speak(eng[0]);
  }
}
