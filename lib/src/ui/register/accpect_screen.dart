import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lesson_api_post/src/model/accpect_model.dart';
import 'package:lesson_api_post/src/ui/home/home_screen.dart';
import 'package:lesson_api_post/src/ui/register/register_screen.dart';

class AsspectScreen extends StatefulWidget {
  final String number;

  const AsspectScreen({Key? key, required this.number}) : super(key: key);

  @override
  _AsspectScreenState createState() => _AsspectScreenState();
}

class _AsspectScreenState extends State<AsspectScreen> {
  TextEditingController _controllerCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Text(widget.number),
          Spacer(),
          TextField(
            controller: _controllerCode,
            maxLength: 4,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              counterText: "",
              hintText: "Code",
              hintStyle: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          Spacer(),
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _sendData(_controllerCode.text);
                });
              },
              child: Container(
                height: 100,
                width: 200,
                color: Colors.blue,
                child: Center(child: Text("Send")),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  _sendData(String code) async {
    String url = "https://test.gopharm.uz/api/v1/accept";
    var body = {
      "smscode": code,
      "login": widget.number,
    };
    print(body);
    print(url);
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      AcceptModel data = AcceptModel.fromJson(
        json.decode(response.body),
      );
      if (data.user.complete != 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return HomeScreen();
          }),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(
              token: data.token,
            );
          }),
        );
      }
    }
  }
}
