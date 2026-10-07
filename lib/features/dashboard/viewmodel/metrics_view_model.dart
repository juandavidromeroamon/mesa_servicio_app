// Created by Juan David Romero.

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mesa_servicio_app/features/dashboard/data/dashboard_repository.dart';
import '../models/usage_metrics.dart';
import 'package:mesa_servicio_app/core/api_exception.dart';

class MetricsViewModel extends ChangeNotifier {
  final DashboardRepository _repository;

  MetricsViewModel(this._repository);

  UsageMetrics _metrics = UsageMetrics.empty();
  UsageMetrics get metrics => _metrics;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Timer? _timer;

  void start() {
    refresh();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) => refresh());
  }

  Future<void> refresh() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _metrics = await _repository.fetchMetrics();
    } on ApiException {
      _error = "No se pudieron cargar las métidades";
    } catch (e) {
      _error = "Error inesperado.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
