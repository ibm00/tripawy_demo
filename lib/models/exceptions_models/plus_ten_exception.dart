class PlusTenException implements Exception {
  final String message;
  PlusTenException(this.message);
  @override
  String toString() {
    return message;
  }
}
