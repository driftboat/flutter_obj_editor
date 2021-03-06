library obj_edit_gen;

import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:obj_edit_annotation/obj_edit_annotation.dart';
import 'package:obj_edit_gen/src/field.dart';
import 'package:obj_edit_gen/src/section.dart';
import 'package:source_gen/source_gen.dart';

const _textSettingChecker = TypeChecker.fromRuntime(ObjEditTextSetting);
const _optionSettingChecker = TypeChecker.fromRuntime(ObjEditOptionSetting);
const _boolSettingChecker = TypeChecker.fromRuntime(ObjEditBoolSetting);

class ObjEditGenerator extends GeneratorForAnnotation<ObjEdit> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    Map<String, Section> sections = {};
    StringBuffer codeBuffer = new StringBuffer("\n");
    var head = annotation.read("head").literalValue;
    if (head != null) {
      String headStr = head as String;
      codeBuffer.writeln(headStr);
    }
    codeBuffer.write(classHead(element.name!));

    if (element.kind == ElementKind.CLASS) {
      for (var e in ((element as ClassElement).fields)) {
        print("===start field:" + e.name);
        var sectionAnnotation = _textSettingChecker.firstAnnotationOf(e);
        if (sectionAnnotation != null) {
          var reader = ConstantReader(sectionAnnotation);
          var sectionName = reader.read('sectionName').literalValue as String;
          final title = reader.read('title').literalValue as String;
          final hintCheck = reader.read('hint').literalValue;
          final icon = reader.read('icon').literalValue;
          final obscure = reader.read('obscure').literalValue;
          final condition = reader.read('condition').literalValue;
          var hint = "";
          if (hintCheck != null) {
            hint = hintCheck as String;
          }
          var section = sections[sectionName];
          if (section == null) {
            section = new Section(sectionName);
            sections[sectionName] = section;
          }
          if (e.type.isDartCoreString) {
            var tft = TextFieldType.text;
            if (obscure != null) {
              bool isObsucre = obscure as bool;
              if (isObsucre) tft = TextFieldType.password;
            }
            if (icon != null)
              section.fields.add(new TextField(e.name, condition, title, hint,
                  icon: (icon as String), fieldType: tft));
            else {
              section.fields.add(new TextField(e.name, condition, title, hint,
                  fieldType: tft));
            }
          } else if (e.type.isDartCoreDouble) {
            if (icon != null)
              section.fields.add(new TextField(e.name, condition, title, hint,
                  icon: (icon as String),
                  fieldType: TextFieldType.number_double));
            else {
              section.fields.add(new TextField(e.name, condition, title, hint,
                  fieldType: TextFieldType.number_double));
            }
          } else if (e.type.isDartCoreInt) {
            if (icon != null)
              section.fields.add(new TextField(e.name, condition, title, hint,
                  icon: (icon as String), fieldType: TextFieldType.number_int));
            else {
              section.fields.add(new TextField(e.name, condition, title, hint,
                  fieldType: TextFieldType.number_int));
            }
          }
        } else {
          var optionAnnotation = _optionSettingChecker.firstAnnotationOf(e);
          if (optionAnnotation != null) {
            var reader = ConstantReader(optionAnnotation);
            var sectionName = reader.read('sectionName').literalValue as String;
            final title = reader.read('title').literalValue as String;
            var options = reader.read('options').literalValue as String;
            final condition = reader.read('condition').literalValue;
            var section = sections[sectionName];
            if (section == null) {
              section = new Section(sectionName);
              sections[sectionName] = section;
            }
            section.fields.add(new OptionField(
                e.name,
                condition,
                e.type.getDisplayString(withNullability: true),
                title,
                options));
          } else {
            var boolAnnotation = _boolSettingChecker.firstAnnotationOf(e);
            if (boolAnnotation != null) {
              final reader = ConstantReader(boolAnnotation);
              final sectionName =
                  reader.read('sectionName').literalValue as String;
              final title = reader.read('title').literalValue as String;
              final condition = reader.read('condition').literalValue;
              var section = sections[sectionName];
              if (section == null) {
                section = new Section(sectionName);
                sections[sectionName] = section;
              }
              section.fields.add(new BoolFeild(e.name, condition, title));
            }
          }
        }
      }
    }
    var sectionId = 1;
    sections.forEach((k, section) {
      codeBuffer..writeln(addSection(section, sectionId));
      sectionId++;
    });
    codeBuffer.writeln("]);");
    codeBuffer.writeln("}");

    sectionId = 1;
    sections.forEach((k, section) {
      codeBuffer..write(startBuildSection(section, sectionId));
      section.fields.forEach((field) {
        if (field is TextField) {
          codeBuffer.write(startAddTile(field.condition));
          codeBuffer.write(textInputTile(field.fieldType, field.title,
              field.name, field.hint, field.icon));
          codeBuffer.write(endAddTile());
        } else if (field is OptionField) {
          codeBuffer.write(startAddTile(field.condition));
          codeBuffer.write(
              optionTile(field.title, field.type, field.name, field.options));
          codeBuffer.write(endAddTile());
        } else if (field is BoolFeild) {
          codeBuffer.write(startAddTile(field.condition));
          codeBuffer.write(swithTile(field.title, field.name));
          codeBuffer.write(endAddTile());
        }
      });
      codeBuffer..writeln(endBuildSection());
      sectionId++;
    });
    codeBuffer.writeln("}");
    return codeBuffer.toString();
  }

  classHead(String className) {
    return """
import '${className.toLowerCase()}.dart';
import 'package:flutter/material.dart';
import 'package:obj_edit_widgets/obj_edit_widgets.dart';

class ${className}Widget extends StatelessWidget{
    final ${className}? obj;
    final ValueChanged<String>? onChanged;
    ${className}Widget({
      Key? key, 
      this.obj,
      this.onChanged
    }) : super(key: key);
    
    @override
    Widget build(BuildContext context) {
        if(obj == null){
          return new Center(child: new Text('No Content'));
        }
        return  ObjEditor(
                sections: [

    """;
  }

  textInputTile(TextFieldType? textFieldType, String title, String property,
      String hint, String? icon) {
    var textTileTypeStr = "TextTileType.text";
    var setValue = " obj!.${property} = text;";
    var initValue = "obj!.${property}";
    if (textFieldType != null) {
      switch (textFieldType) {
        case TextFieldType.password:
          textTileTypeStr = "TextTileType.password";
          break;
        case TextFieldType.number_double:
          textTileTypeStr = "TextTileType.number_double";
          setValue = " obj!.${property} =  double.parse(text);";
          initValue = "obj!.${property}.toString()";
          break;
        case TextFieldType.number_int:
          textTileTypeStr = "TextTileType.number_int";
          setValue = " obj!.${property} =  int.parse(text);";
          initValue = "obj!.${property}.toString()";
          break;
        default:
          break;
      }
    }

    return icon != null
        ? """
    TextTile(
                title: "${title}",
                hintText: "${hint}",
                icon: ${icon},
                initText: ${initValue}, 
                textTileType:${textTileTypeStr},
                onChanged: (String text) {  ${setValue} onChanged?.call("${property}"); },
              ),
              """
        : """
    TextTile(
                title: "${title}",
                hintText: "${hint}", 
                initText: ${initValue}, 
                textTileType:${textTileTypeStr},
                onChanged: (String text) { ${setValue} onChanged?.call("${property}"); },
              ),
              """;
  }

  optionTile(String title, String type, String property, String optionsStr) {
    return """
    DropDownTile<${type}>(
          title: "${title}",
          selected: obj!.${property}, 
          options: ${optionsStr},
          itemBuilder: (selectValue) {
            return Text(selectValue.toString(), textAlign: TextAlign.end);
          },
          onChanged: (value){
            obj!.${property} = value;
            onChanged?.call("${property}");
          },
        ),
""";
  }

  swithTile(String title, String property) {
    return """
      SwitchTile(
                "${title}",
                obj!.${property},
                onChanged: (value){
            obj!.${property} = value;
            onChanged?.call("${property}");
          },
      ),
                 """;
  }

  addSection(Section section, int sectionId) {
    return """
     ObjSection(
            title: '${section.name}',
            tiles: buildSection${sectionId}(),),
            """;
  }

  startBuildSection(Section section, int sectionId) {
    return """
  buildSection${sectionId}() {
    final List<Widget> tiles = [];
            """;
  }

  startAddTile(String? condition) {
    if (condition != null) {
      return """
      if(${condition})tiles.add(
       """;
    }
    return """
      tiles.add(
       """;
  }

  endAddTile() {
    return """
    );
       """;
  }

  endBuildSection() {
    return """
        return tiles;
  } """;
  }
}
