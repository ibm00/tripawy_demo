class ValidatorHelper {
  static String? isEmptyValidator(String? val) {
    if (val!.isEmpty) return 'Pls. Fill this field';
    return null;
  }

  static String? dateTimeValidator(String? date) {
    if (date!.length < 16) return "Pls. Enter start details";
    return null;
  }
}
