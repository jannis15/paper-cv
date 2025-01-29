extension RemoveFileExtension on String {
  String removeFileExtension() {
    int index = lastIndexOf('.');
    if (index == -1) return this;
    return substring(0, index);
  }
}
