/// Password validator function
String? passwordValidator(
  String? value, {
  String? passwordIsRequired,
  String? passwordNotValid,
}) {
  if (value == null || value.isEmpty) {
    return passwordIsRequired ?? 'Password is required';
  } else if (value.length < 8) {
    return passwordNotValid ?? 'Password must be at least 8 characters long';
  }
  return null;
}
