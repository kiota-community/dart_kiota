part of '../../kiota_abstractions.dart';

extension StringExtensions on String {
  String toFirstCharacterLowerCase() {
    return '${this[0].toLowerCase()}${substring(1)}';
  }
}
