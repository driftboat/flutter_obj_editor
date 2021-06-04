# obj_edit_gen

Automatically generate code for converting to widget by annotating Dart classes

## Setup

To configure your project for the latest released version of,
`obj_edit_gen` see the [example].

## Example

Given a library `test.dart` with an `Test` class annotated with
`@ObjEdit()`:

```dart
import 'package:obj_edit_annotation/obj_edit_annotation.dart';

import 'obj_option.dart';
//flutter pub run build_runner build --delete-conflicting-outputs

@ObjEdit(head: "import 'obj_option.dart';")
class Test {
  @ObjEditTextSetting(
      sectionName: "section1",
      title: "Name",
      hint: "name1",
      icon: "Icons.person")
  String name;
  @ObjEditOptionSetting(
      sectionName: "section1",
      title: "Option",
      options: '<String>["option1","option2","option3"]')
  String option;

  @ObjEditOptionSetting(
      sectionName: "section1",
      title: "ObjOption",
      options:
          '<ObjOption>[new ObjOption("objOption1"),new ObjOption("objOption2"),new ObjOption("objOption3")]')
  ObjOption objOption;

  @ObjEditTextSetting(sectionName: "section2", title: "Name", hint: "name2")
  String name2;
  @ObjEditOptionSetting(
      sectionName: "section2",
      title: "Option",
      options: '<String>["option1","option2","option3"]')
  String option2;

  Test(this.name, this.option, this.objOption, this.name2, this.option2);
}
```

Building creates the corresponding part `test.e.dart`:

```dart
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

```

# Running the code generator

Once you have added the annotations to your code you then need to run the 
code generator to generate the missing `.e.dart` generated dart files.

run `flutter pub run build_runner build` in your package
directory.

# Annotation values 

- [x] class annotation: `@ObjEdit`.
- [x] text|int|double field annotation: `@ObjEditTextSetting`  
- [x] option field annotation: `@ObjEditOptionSetting`
- [x] bool field annotation: `@ObjEditBoolSetting`
- [] date field  

[example]: https://github.com/driftboat/flutter_obj_editor/tree/main/example
