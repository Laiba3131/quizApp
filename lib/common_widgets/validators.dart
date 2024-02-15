class FieldValidator {
  static String? validateEmpty(String? value) {
    if (value!.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }
}
