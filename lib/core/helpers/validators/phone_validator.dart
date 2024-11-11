/// Phone number validator
String? phoneValidator(
  String? value, {
  String? phoneIsRequired,
  String? phoneNotValid,
}) {
  const phonePattern = r'^\+?[0-9]{7,15}$';
  final regex = RegExp(phonePattern);
  if (value == null || value.isEmpty) {
    return phoneIsRequired ?? 'Phone number is required';
  } else if (!regex.hasMatch(value)) {
    return phoneNotValid ?? 'Please enter a valid phone number';
  }
  return null;
}
