// Created by Juan David Romero.

enum ChatRole { user, assistant }

class ChatMessage {
  final ChatRole role;
  final String text;
  final List<String> sources;

  ChatMessage({
    required this.role,
    required this.text,
    this.sources = const [],
  });
}
