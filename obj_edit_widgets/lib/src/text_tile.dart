import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextTileType { text, password, number_int, number_double }

class TextTile extends StatelessWidget {
  final String title;
  final String? initText;
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextTileType? textTileType;
  TextTile(
      {Key? key,
      this.title = "",
      this.initText,
      this.hintText,
      this.icon,
      this.onChanged,
      this.controller,
      this.textTileType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var ttt = TextTileType.text;
    if (textTileType != null) {
      ttt = textTileType!;
    }
    return TextFormField(
        onChanged: onChanged,
        cursorColor: Colors.black,
        controller: controller,
        keyboardType:
            ttt == TextTileType.number_int || ttt == TextTileType.number_double
                ? TextInputType.number
                : TextInputType.text,
        inputFormatters: ttt == TextTileType.number_double
            ? [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))]
            : ttt == TextTileType.number_int
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
        obscureText: ttt == TextTileType.password,
        initialValue: initText,
        decoration: icon != null
            ? InputDecoration(
                labelText: title,
                prefixIcon: Icon(
                  icon,
                  color: Colors.black,
                ),
                hintText: hintText,
                border: InputBorder.none,
              )
            : InputDecoration(
                labelText: title,
                hintText: hintText,
                border: InputBorder.none,
              ));
  }
}

class TextInputFormatter {}
