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
  TestWidget({Key? key, this.obj}) : super(key: key);

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
          onChanged: (String text) {
            obj!.name = text;
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
          },
        ),
      ]),
      ObjSection(title: 'section2', tiles: [
        TextTile(
          title: "Name",
          hintText: "name2",
          initText: obj!.name2,
          onChanged: (String text) {
            obj!.name2 = text;
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
          },
        ),
      ]),
    ]);
  }
}
