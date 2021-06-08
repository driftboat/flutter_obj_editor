class ObjEditTextSetting {
  final String sectionName;
  final String title;
  final String hint;
  final String? icon;
  final bool? obscure;
  final String? condition;
  const ObjEditTextSetting(
      {required this.sectionName,
      required this.title,
      required this.hint,
      this.icon,
      this.obscure,
      this.condition});
}

class ObjEditOptionSetting<T> {
  final String sectionName;
  final String title;
  final String options;
  final String? condition;
  const ObjEditOptionSetting(
      {required this.sectionName,
      required this.title,
      required this.options,
      this.condition});
}

class ObjEditBoolSetting {
  final String sectionName;
  final String title;
  final String? condition;
  const ObjEditBoolSetting(
      {required this.sectionName, required this.title, this.condition});
}
