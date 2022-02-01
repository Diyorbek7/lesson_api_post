import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lesson_api_post/src/ui/register/accpect_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Register"),
      ),
      body: Column(
        children: [
          Spacer(),
          TextField(
            controller: _controller,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: "telephone",
              hintStyle: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                _sendData(_controller.text);
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return AsspectScreen(number: _controller.text);
                }),
              );
            },
            child: Container(
              height: 100,
              width: 200,
              color: Colors.blue,
              child: Center(child: Text("Send")),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  _sendData(String number) async {
    String url = "https://test.gopharm.uz/api/v1/register";
    var body = {
      "login": number,
    };
    print(body);
    print(url);
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
    );
    print(response.body);
    print(response.statusCode);
  }
}
