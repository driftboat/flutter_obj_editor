import 'package:flutter/material.dart';

class SwitchTile extends StatefulWidget {
  final String title;
  bool open;
  final ValueChanged<bool>? onChanged;
  SwitchTile(this.title, this.open, {Key? key, this.onChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SwitchTileState();
}

class _SwitchTileState<T> extends State<SwitchTile> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      onChanged: (bool value) {
        setState(() {
          widget.open = value;
          if (widget.onChanged != null) widget.onChanged!(value);
        });
      },
      value: widget.open,
      contentPadding: EdgeInsets.zero,
      title: Text(widget.title),
    );
  }
}
