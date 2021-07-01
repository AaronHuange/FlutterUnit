import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FiledText extends StatefulWidget {
  static String IP = "";

  @override
  State<StatefulWidget> createState() => _FiledText();
}

class _FiledText extends State<FiledText> {
  var _username = new TextEditingController(); //用来初始化给表单赋值

  var sp;

  @override
  void initState() async {
    super.initState();
    sp= await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration:
          InputDecoration(hintText: 'ip地址', border: OutlineInputBorder()),
      controller: this._username,
      onChanged: (value) {
        setState(() {
          FiledText.IP = value;
          sp.setString('IP', value);
        });
      },
    );
  }
}
