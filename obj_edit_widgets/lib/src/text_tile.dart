import 'package:flutter/material.dart';

class TextTile extends StatelessWidget {
  final String title;
  final String? initText;
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  TextTile({
    Key? key,
    this.title = "",
    this.initText,
    this.hintText,
    this.icon,
    this.onChanged,
    this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onChanged,
        cursorColor: Colors.black,
        controller: controller,
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
