// ignore_for_file: empty_constructor_bodies, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../constants.dart';
import '../models/vocabulary.dart';
import '../services/mockJson.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({Key? key}) : super(key: key);
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  late Vocabulary vocab;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    vocab = Vocabulary.fromJson(mockJsonMenu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        padding: EdgeInsets.all(30),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover),
        ),
        child: Card(
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text(vocab.th![2],
          //         style: TextStyle(
          //             backgroundColor: Colors.white,
          //             fontSize: 32.0,
          //             fontWeight: FontWeight.bold)),
          //     Container(
          //       color: Colors.white,
          //       child: TextButton.icon(
          //           onPressed: () => speakWord(),
          //           icon: Icon(
          //             Icons.volume_up_sharp,
          //             color: Colors.teal,
          //           ),
          //           label: Text(
          //             'English Sound',
          //             style: TextStyle(
          //               fontSize: 18,
          //               color: Colors.teal,
          //             ),
          //           )),
          //     ),
          //     SizedBox(height: 40),
          //     Answer(),
          //     SizedBox(height: 50),
          //     CheckButton(),
          //   ],
          // ),
        ),
      ),
    );
  }

  SizedBox CheckButton() {
    return SizedBox(
      width: 620,
      height: 40,
      child:
          ElevatedButton(onPressed: () {}, child: Text("ตรวจ", style: size18)),
    );
  }

  SizedBox Answer() {
    return SizedBox(
      width: 620,
      child: TextFormField(
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
    await flutterTts.speak(vocab.eng![2]);
  }
}
