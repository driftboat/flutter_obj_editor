class ObjEditTextSetting {
  final String sectionName;
  final String title;
  final String hint;
  final String? icon;
  final bool? obscure;
  const ObjEditTextSetting(
      {required this.sectionName,
      required this.title,
      required this.hint,
      this.icon,
      this.obscure});
}

class ObjEditOptionSetting<T> {
  final String sectionName;
  final String title;
  final String options;
  const ObjEditOptionSetting(
      {required this.sectionName, required this.title, required this.options});
}

class ObjEditBoolSetting {
  final String sectionName;
  final String title;
  const ObjEditBoolSetting({required this.sectionName, required this.title});
}
