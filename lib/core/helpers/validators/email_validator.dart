/// Validator to check if the email is valid or not
String? emailValidator(String? value) {
  const emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  final regex = RegExp(emailPattern);
  if (value == null || value.isEmpty) {
    return 'Email is required';
  } else if (!regex.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}
