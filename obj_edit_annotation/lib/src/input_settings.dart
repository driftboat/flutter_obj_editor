class ObjEditTextSetting {
  final String sectionName;
  final String title;
  final String hint;
  final String? icon;
  const ObjEditTextSetting(
      {required this.sectionName,
      required this.title,
      required this.hint,
      this.icon});
}

class ObjEditOptionSetting<T> {
  final String sectionName;
  final String title;
  final String options;
  const ObjEditOptionSetting(
      {required this.sectionName, required this.title, required this.options});
}
