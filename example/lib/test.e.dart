// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ObjEditGenerator
// **************************************************************************

import 'obj_option.dart';
import 'test.dart';
import 'package:flutter/material.dart';
import 'package:obj_edit_widgets/obj_edit_widgets.dart';

class TestWidget extends StatelessWidget {
  final Test? obj;
  final ValueChanged<String>? onChanged;
  TestWidget({Key? key, this.obj, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (obj == null) {
      return new Center(child: new Text('No Content'));
    }
    return ObjEditor(sections: [
      ObjSection(title: 'section1', tiles: [
        TextTile(
          title: "Name",
          hintText: "name1",
          icon: Icons.person,
          initText: obj!.name,
          textTileType: TextTileType.text,
          onChanged: (String text) {
            obj!.name = text;
            onChanged?.call("name");
          },
        ),
        DropDownTile<String>(
          title: "Option",
          selected: obj!.option,
          options: <String>["option1", "option2", "option3"],
          itemBuilder: (selectValue) {
            return Text(selectValue.toString(), textAlign: TextAlign.end);
          },
          onChanged: (value) {
            obj!.option = value;
            onChanged?.call("option");
          },
        ),
        DropDownTile<ObjOption>(
          title: "ObjOption",
          selected: obj!.objOption,
          options: <ObjOption>[
            new ObjOption("objOption1"),
            new ObjOption("objOption2"),
            new ObjOption("objOption3")
          ],
          itemBuilder: (selectValue) {
            return Text(selectValue.toString(), textAlign: TextAlign.end);
          },
          onChanged: (value) {
            obj!.objOption = value;
            onChanged?.call("objOption");
          },
        ),
      ]),
      ObjSection(title: 'section2', tiles: [
        TextTile(
          title: "Name",
          hintText: "name2",
          initText: obj!.name2,
          textTileType: TextTileType.password,
          onChanged: (String text) {
            obj!.name2 = text;
            onChanged?.call("name2");
          },
        ),
        DropDownTile<String>(
          title: "Option",
          selected: obj!.option2,
          options: <String>["option1", "option2", "option3"],
          itemBuilder: (selectValue) {
            return Text(selectValue.toString(), textAlign: TextAlign.end);
          },
          onChanged: (value) {
            obj!.option2 = value;
            onChanged?.call("option2");
          },
        ),
        TextTile(
          title: "Age",
          hintText: "age",
          initText: obj!.age.toString(),
          textTileType: TextTileType.number_int,
          onChanged: (String text) {
            obj!.age = int.parse(text);
            onChanged?.call("age");
          },
        ),
        TextTile(
          title: "Coin",
          hintText: "coin",
          initText: obj!.coin.toString(),
          textTileType: TextTileType.number_double,
          onChanged: (String text) {
            obj!.coin = double.parse(text);
            onChanged?.call("coin");
          },
        ),
        SwitchTile(
          "IsVip",
          obj!.isVip,
          onChanged: (value) {
            obj!.isVip = value;
            onChanged?.call("isVip");
          },
        ),
      ]),
    ]);
  }
}
