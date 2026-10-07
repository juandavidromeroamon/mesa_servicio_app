// Created by Juan David Romero.

import 'package:flutter/foundation.dart';
import '../data/dashboard_repository.dart';
import '../models/chat_message.dart';
import '../../../core/api_exception.dart';

class ChatViewModel extends ChangeNotifier {
  final DashboardRepository _repository;

  ChatViewModel(this._repository);

  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  String? _lastMessage;
  String? get lastMessage => _lastMessage;

  Future<void> send(String text) async {
    if (text.trim().isEmpty || _isLoading) return;

    _lastMessage = text.trim();
    _messages.add(ChatMessage(role: ChatRole.user, text: _lastMessage!));
    _error = null;
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.sendMessage(_lastMessage!);
      
      _messages.add(ChatMessage(
        role: ChatRole.assistant,
        text: response.answer,
        sources: response.sources.map((s) => '${s.categoria}: ${s.pregunta}').toList(),
      ));
      _lastMessage = null;
    } on ApiException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = "Ocurrió un error inesperado.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> retry() async {
    if (_lastMessage != null) {
      await send(_lastMessage!);
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
