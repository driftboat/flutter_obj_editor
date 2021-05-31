library obj_edit_gen;

import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:obj_edit_annotation/obj_edit_annotation.dart';
import 'package:obj_edit_gen/src/field.dart';
import 'package:obj_edit_gen/src/section.dart';
import 'package:source_gen/source_gen.dart';

const _textSettingChecker = TypeChecker.fromRuntime(ObjEditTextSetting);
const _optionSettingChecker = TypeChecker.fromRuntime(ObjEditOptionSetting);

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
        var sectionAnnotation = _textSettingChecker.firstAnnotationOf(e);
        if (sectionAnnotation != null && e.type.isDartCoreString) {
          var reader = ConstantReader(sectionAnnotation);
          var sectionName = reader.read('sectionName').literalValue as String;
          final title = reader.read('title').literalValue as String;
          final hint = reader.read('hint').literalValue as String;
          final icon = reader.read('icon').literalValue;

          var section = sections[sectionName];
          if (section == null) {
            section = new Section(sectionName);
            sections[sectionName] = section;
          }
          if (icon != null)
            section.fields.add(
                new TextField(e.name, title, hint, icon: (icon as String)));
          else {
            section.fields.add(new TextField(e.name, title, hint));
          }
        } else {
          var optionAnnotation = _optionSettingChecker.firstAnnotationOf(e);
          if (optionAnnotation != null) {
            var reader = ConstantReader(optionAnnotation);
            var sectionName = reader.read('sectionName').literalValue as String;
            final title = reader.read('title').literalValue as String;
            var options = reader.read('options').literalValue as String;
            var section = sections[sectionName];
            print(sectionName);
            if (section == null) {
              section = new Section(sectionName);
              sections[sectionName] = section;
            }
            section.fields.add(new OptionField(
                e.name,
                e.type.getDisplayString(withNullability: true),
                title,
                options));
          }
        }
      }
    }
    sections.forEach((k, section) {
      codeBuffer..write(startSection(section));
      section.fields.forEach((field) {
        if (field is TextField) {
          codeBuffer.write(
              textInputTile(field.title, field.name, field.hint, field.icon));
        } else if (field is OptionField) {
          codeBuffer.write(
              optionTile(field.title, field.type, field.name, field.options));
        }
      });
      codeBuffer.write(finishSection());
    });
    codeBuffer.writeln("]);");
    codeBuffer.writeln("}}");
    return codeBuffer.toString();
  }

  classHead(String className) {
    return """
import '${className.toLowerCase()}.dart';
import 'package:flutter/material.dart';
import 'package:obj_edit_widgets/obj_edit_widgets.dart';

class ${className}Widget extends StatelessWidget{
    final ${className}? obj;
    ${className}Widget({
      Key? key, 
      this.obj
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

  textInputTile(String title, String property, String hint, String? icon) {
    return icon != null
        ? """
    TextTile(
                title: "${title}",
                hintText: "${hint}",
                icon: ${icon},
                initText: obj!.${property}, 
                onChanged: (String text) { obj!.${property} = text;},
              ),
              """
        : """
    TextTile(
                title: "${title}",
                hintText: "${hint}", 
                initText: obj!.${property}, 
                onChanged: (String text) { obj!.${property} = text;},
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
          },
        ),
""";
  }

  startSection(Section section) {
    return """
     ObjSection(
            title: '${section.name}',
            tiles: [
            """;
  }

  finishSection() {
    return "]),";
  }
}
