import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'obj_edit_gen.dart';

Builder objEditBuilder(BuilderOptions options) =>
    LibraryBuilder(ObjEditGenerator(), generatedExtension: '.e.dart');
