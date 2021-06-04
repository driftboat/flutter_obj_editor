abstract class Field {
  String get name;
}

class BaseField implements Field {
  @override
  String name;
  BaseField(this.name);
}

enum TextFieldType { text, password, number_int, number_double }

class TextField extends BaseField {
  final TextFieldType? fieldType;
  final String title;
  final String hint;
  final String? icon;
  TextField(name, this.title, this.hint, {this.fieldType, this.icon})
      : super(name);
}

class OptionField<T> extends BaseField {
  final String type;
  final String title;
  final String options;
  OptionField(name, this.type, this.title, this.options) : super(name);
}
