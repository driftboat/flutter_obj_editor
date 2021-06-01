# example

To use [package:obj_edit_gen][obj_edit_gen] in your package, add these
dependencies to your `pubspec.yaml`.

```yaml
dependencies: 
  obj_edit_annotation: ^1.0.0
  obj_edit_widgets: ^1.0.0 

dev_dependencies: 
  build_runner: ^2.0.0
  obj_edit_gen: ^1.0.0
```

Annotate your code with classes defined in
[package:obj_edit_annotation][obj_edit_annotation].

- See [`lib/test.dart`][test] for an example of a file using these
  annotations.

- See [`lib/test.e.dart`][test_e] for the generated file.

Run `pub run build_runner build` to generate files into your source directory.

[test]: lib/test.dart
[test_e]: lib/test.e.dart
[obj_edit_annotation]: https://pub.dev/packages/obj_edit_annotation
[obj_edit_gen]: https://pub.dev/packages/obj_edit_gen
