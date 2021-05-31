class ObjOption {
  final String optionName;
  ObjOption(this.optionName);

  @override
  String toString() {
    return optionName;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ObjOption && other.optionName == this.optionName;
  }
}
