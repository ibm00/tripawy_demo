class ValidatorHelper {
  static String? isEmptyValidator(String? val) {
    if (val!.isEmpty) return 'Pls. Fill this field';
    return null;
  }

  static String? dateTimeValidator(String? date) {
    if (date!.length < 16) return "Pls. Enter start details";
    final dateTime = DateTime.parse(date);
    if (dateTime.isBefore(DateTime.now())) return "The date must be in future";
    return null;
  }
}
