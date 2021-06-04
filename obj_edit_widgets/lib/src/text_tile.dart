import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextTileType { text, password, number_int, number_double }

class TextTile extends StatefulWidget {
  final String title;
  final String? initText;
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextTileType? textTileType;
  @override
  State<StatefulWidget> createState() => _TextTileState();

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
}

class _TextTileState<T> extends State<TextTile> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    var ttt = TextTileType.text;
    if (widget.textTileType != null) {
      ttt = widget.textTileType!;
    }
    return TextFormField(
        onChanged: widget.onChanged,
        cursorColor: Colors.black,
        controller: widget.controller,
        keyboardType:
            ttt == TextTileType.number_int || ttt == TextTileType.number_double
                ? TextInputType.number
                : TextInputType.text,
        inputFormatters: ttt == TextTileType.number_double
            ? [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))]
            : ttt == TextTileType.number_int
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
        obscureText: ttt == TextTileType.password && !_passwordVisible,
        initialValue: widget.initText,
        decoration: InputDecoration(
          labelText: widget.title,
          prefixIcon: widget.icon != null
              ? Icon(
                  widget.icon,
                  color: Colors.black,
                )
              : null,
          hintText: widget.hintText,
          border: InputBorder.none,
          suffixIcon: ttt == TextTileType.password
              ? IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null,
        ));
  }
}

class TextInputFormatter {}
