// Created by Juan David Romero.

import 'package:mesa_servicio_app/core/http_client.dart';
import 'package:mesa_servicio_app/core/config.dart';
import 'package:mesa_servicio_app/features/dashboard/models/chat_response.dart';
import 'package:mesa_servicio_app/features/dashboard/models/usage_metrics.dart';

// Note: The prompt says DashboardRepository receives ApiClient.
// I will assume ApiClient is in lib/core/api_client.dart as per earlier task.

class DashboardRepository {
  final ApiClient _apiClient;

  DashboardRepository(this._apiClient);

  Future<ChatResponse> sendMessage(String message) async {
    final response = await _apiClient.postJson(
      '/api/chat',
      {
        'message': message,
        'user': AppConfig.user,
      },
    );
    return ChatResponse.fromJson(response);
  }

  Future<UsageMetrics> fetchMetrics() async {
    final response = await _apiClient.getJson('/api/metrics');
    return UsageMetrics.fromJson(response);
  }
}
