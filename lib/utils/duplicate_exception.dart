class DuplicateException implements Exception {
  final String message;

  DuplicateException(this.message);

  @override
  String toString() {
    return message;
  }
}
