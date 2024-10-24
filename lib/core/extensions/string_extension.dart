/// String extension methods
extension StringExtension on String {
  /// Crop the string to a maximum length
  String crop(int maxLength, {String? suffix}) {
    if (length <= maxLength) {
      return this;
    }
    return '${substring(0, maxLength - (suffix?.length ?? 0))}${suffix ?? ''}';
  }
}
