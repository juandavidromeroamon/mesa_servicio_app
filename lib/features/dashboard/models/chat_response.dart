// Created by Juan David Romero.

import 'package:mesa_servicio_app/features/dashboard/models/source.dart';
import 'package:mesa_servicio_app/features/dashboard/models/chat_metrics.dart';

class ChatResponse {
  final String answer;
  final List<Source> sources;
  final ChatMetrics? metrics;

  ChatResponse({
    required this.answer,
    required this.sources,
    this.metrics,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      answer: json['answer'] ?? '',
      sources: (json['sources'] as List? ?? [])
          .map((s) => Source.fromJson(s as Map<String, dynamic>))
          .toList(),
      metrics: json['metrics'] != null
          ? ChatMetrics.fromJson(json['metrics'] as Map<String, dynamic>)
          : null,
    );
  }
}
