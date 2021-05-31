import 'package:flutter/material.dart';

import 'obj_section.dart';

class ObjEditor extends StatelessWidget {
  final List<ObjSection> sections;
  ObjEditor({Key? key, required this.sections}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: sections.length,
        itemBuilder: (context, index) {
          var section = sections[index];
          return section;
        });
  }
}
