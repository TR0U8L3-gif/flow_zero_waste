/// Password validator function
/// that checks if the password is empty 
/// and if it is at least 8 characters long
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

/// Password validator function 
/// that checks if the password is empty
String? passwordValidatorIsEmpty(
  String? value, {
  String? passwordIsRequired,
}) {
  if (value == null || value.isEmpty) {
    return passwordIsRequired ?? 'Password is required';
  }
  return null;
}
