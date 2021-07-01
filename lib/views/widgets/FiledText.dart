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
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((_sp) {
      sp = _sp;
      FiledText.IP = sp.getString('IP');
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: FiledText.IP.isEmpty ? "请输入ip地址" : FiledText.IP),
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
