abstract class Field {
  String get name;
  String? get condition;
}

class BaseField implements Field {
  @override
  String name;
  @override
  String? condition;
  BaseField(this.name, this.condition);
}

enum TextFieldType { text, password, number_int, number_double }

class TextField extends BaseField {
  final TextFieldType? fieldType;
  final String title;
  final String hint;
  final String? icon;
  TextField(name, condition, this.title, this.hint, {this.fieldType, this.icon})
      : super(name, condition);
}

class OptionField<T> extends BaseField {
  final String type;
  final String title;
  final String options;
  OptionField(name, condition, this.type, this.title, this.options)
      : super(name, condition);
}

class BoolFeild extends BaseField {
  final String title;
  BoolFeild(name, condition, this.title) : super(name, condition);
}
