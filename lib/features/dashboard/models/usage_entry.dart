// Created by Juan David Romero.

class UsageEntry {
  final String ts;
  final String user;
  final int totalMs;
  final int tokensIn;
  final int tokensOut;
  final String status;

  UsageEntry({
    required this.ts,
    required this.user,
    required this.totalMs,
    required this.tokensIn,
    required this.tokensOut,
    required this.status,
  });

  factory UsageEntry.fromJson(Map<String, dynamic> json) {
    return UsageEntry(
      ts: json['ts'] ?? '',
      user: json['user'] ?? '',
      totalMs: (json['total_ms'] ?? 0).toInt(),
      tokensIn: (json['tokens_in'] ?? 0).toInt(),
      tokensOut: (json['tokens_out'] ?? 0).toInt(),
      status: json['status'] ?? '',
    );
  }
}
