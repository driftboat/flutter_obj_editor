import 'package:flutter/material.dart';

typedef ItemBuilder<T> = Widget Function(T);

class DropDownTile<T> extends StatefulWidget {
  final List<T> options;
  final String title;
  final ItemBuilder itemBuilder;
  T selected;

  /// on change callback for handling the value change
  final ValueChanged<T>? onChanged;

  DropDownTile(
      {Key? key,
      required this.title,
      required this.options,
      required this.selected,
      required this.itemBuilder,
      this.onChanged})
      : super(key: key);

  @override
  _DropDownTileState<T> createState() => _DropDownTileState<T>();
}

class _DropDownTileState<T> extends State<DropDownTile<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isDense: true,
      value: widget.selected,
      onChanged: onChanged,
      items: widget.options.map<DropdownMenuItem<T>>(
        (T val) {
          return DropdownMenuItem<T>(
            value: val,
            child: widget.itemBuilder(val),
          );
        },
      ).toList(),
      decoration: InputDecoration(labelText: widget.title),
    );
  }

  void onChanged(T? value) {
    setState(() {
      widget.selected = value!;
    });
    widget.onChanged?.call(value!);
  }
}
