// Created by Juan David Romero.
import 'package:mesa_servicio_app/features/dashboard/models/usage_entry.dart';

class UsageMetrics {
  final int requests;
  final int errors;
  final int tokensIn;
  final int tokensOut;
  final double p50Ms;
  final double p95Ms;
  final List<UsageEntry> last;

  UsageMetrics({
    required this.requests,
    required this.errors,
    required this.tokensIn,
    required this.tokensOut,
    required this.p50Ms,
    required this.p95Ms,
    required this.last,
  });

  factory UsageMetrics.fromJson(Map<String, dynamic> json) {
    return UsageMetrics(
      requests: (json['requests'] ?? 0).toInt(),
      errors: (json['errors'] ?? 0).toInt(),
      tokensIn: (json['tokens_in'] ?? 0).toInt(),
      tokensOut: (json['tokens_out'] ?? 0).toInt(),
      p50Ms: (json['p50_ms'] ?? 0.0).toDouble(),
      p95Ms: (json['p95_ms'] ?? 0.0).toDouble(),
      last: (json['last'] as List? ?? [])
          .map((e) => UsageEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory UsageMetrics.empty() {
    return UsageMetrics(
      requests: 0,
      errors: 0,
      tokensIn: 0,
      tokensOut: 0,
      p50Ms: 0.0,
      p95Ms: 0.0,
      last: [],
    );
  }
}
