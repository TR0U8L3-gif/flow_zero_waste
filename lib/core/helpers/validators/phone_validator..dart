/// Phone number validator
String? phoneValidator(String? value) {
  const phonePattern = r'^\+?[0-9]{7,15}$';
  final regex = RegExp(phonePattern);
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  } else if (!regex.hasMatch(value)) {
    return 'Please enter a valid phone number';
  }
  return null;
}
