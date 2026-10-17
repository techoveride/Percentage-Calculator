import 'ai_quota.dart';

enum AiErrorCode { offline, quota, busy, refused, unavailable, generic }

class AiException implements Exception {
  const AiException(this.code, {this.quota});

  final AiErrorCode code;

  /// Latest allowance, when the error came with one.
  final AiQuota? quota;

  @override
  String toString() => 'AiException($code)';
}
