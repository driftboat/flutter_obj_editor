import 'package:flutter/material.dart';
import 'package:obj_edit_widgets/src/style.dart';

class ObjSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;
  ObjSection({Key? key, required this.title, required this.tiles})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: sectionPadding,
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: tiles.length,
        itemBuilder: (context, index) {
          var tile = tiles[index];
          return Padding(padding: tilePadding, child: tile);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      )
    ]);
  }
}
