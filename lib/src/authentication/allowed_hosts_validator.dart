part of '../../kiota_abstractions.dart';

/// Validator for handling allowed hosts for authentication.
class AllowedHostsValidator {
  /// Initializes a new instance of the [AllowedHostsValidator] class.
  AllowedHostsValidator([Iterable<String>? validHosts]) {
    validHosts ??= <String>[];
    _validateHosts(validHosts);
    _allowedHosts = HashSet(
      equals: (a, b) => a.toUpperCase() == b.toUpperCase(),
      hashCode: (o) => o.toUpperCase().hashCode,
    )..addAll(validHosts);
  }

  late final Set<String> _allowedHosts;

  /// Gets the allowed hosts.
  Iterable<String> get allowedHosts => _allowedHosts;

  /// Sets the allowed hosts.
  set allowedHosts(Iterable<String> value) {
    _validateHosts(value);
    _allowedHosts = HashSet(
      equals: (a, b) => a.toUpperCase() == b.toUpperCase(),
      hashCode: (o) => o.toUpperCase().hashCode,
    )..addAll(value);
  }

  /// Validates that the given [uri] is valid.
  bool isUrlHostValid(Uri uri) {
    return _allowedHosts.isEmpty || _allowedHosts.contains(uri.host);
  }

  static void _validateHosts(Iterable<String> hostsToValidate) {
    if (hostsToValidate
        .map((e) => e.toLowerCase())
        .any((x) => x.startsWith('http://') || x.startsWith('https://'))) {
      throw ArgumentError('Host should not contain http or https prefix');
    }
  }
}
