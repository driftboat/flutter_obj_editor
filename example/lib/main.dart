import 'package:example/test.dart';
import 'package:example/test.e.dart';
import 'package:flutter/material.dart';

import 'obj_option.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Test? testObj;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    testObj = new Test("name1", "option1", new ObjOption("objOption1"), "name2",
        "option2", 18, 120.5, false, 10);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: new Scaffold(
            appBar: AppBar(title: Text('ObjEdit')),
            body: TestWidget(
                obj: testObj,
                onChanged: (peropertyName) {
                  if (peropertyName == "name" || peropertyName == "age") {
                    setState(() {});
                  }
                })));
  }
}
