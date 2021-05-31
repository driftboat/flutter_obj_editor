abstract class Field {
  String get name;
}

class BaseField implements Field {
  @override
  String name;
  BaseField(this.name);
}

class TextField extends BaseField {
  final String title;
  final String hint;
  final String? icon;
  TextField(name, this.title, this.hint, {this.icon}) : super(name);
}

class OptionField<T> extends BaseField {
  final String type;
  final String title;
  final String options;
  OptionField(name, this.type, this.title, this.options) : super(name);
}
