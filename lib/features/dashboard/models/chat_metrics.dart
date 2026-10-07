// Created by Juan David Romero.

class ChatMetrics {
  final int totalMs;
  final int tokensIn;
  final int tokensOut;
  final String model;

  ChatMetrics({
    required this.totalMs,
    required this.tokensIn,
    required this.tokensOut,
    required this.model,
  });

  factory ChatMetrics.fromJson(Map<String, dynamic> json) {
    return ChatMetrics(
      totalMs: (json['total_ms'] ?? 0).toInt(),
      tokensIn: (json['tokens_in'] ?? 0).toInt(),
      tokensOut: (json['tokens_out'] ?? 0).toInt(),
      model: json['model'] ?? '',
    );
  }
}
