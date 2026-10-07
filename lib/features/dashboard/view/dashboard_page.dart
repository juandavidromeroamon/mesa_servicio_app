// Created by Juan David Romero.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mesa_servicio_app/features/dashboard/viewmodel/chat_view_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend(ChatViewModel viewModel) {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      viewModel.send(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = context.watch<ChatViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesa de servicio'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Expanded(
                child: chatViewModel.messages.isEmpty
                    ? const Center(child: Text('Describe tu problema de TI'))
                    : ListView.builder(
                        itemCount: chatViewModel.messages.length,
                        itemBuilder: (context, index) {
                          final message = chatViewModel.messages[index];
                          return ListTile(
                            title: Text(message.role.name.toUpperCase()),
                            subtitle: SelectableText(message.text),
                          );
                        },
                      ),
              ),
              if (chatViewModel.isLoading) const LinearProgressIndicator(),
              if (chatViewModel.error != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(chatViewModel.error!),
                    TextButton(
                      onPressed: () {
                        chatViewModel.clearError();
                        chatViewModel.retry();
                      },
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        minLines: 1,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ej: No puedo conectarme a la VPN',
                        ),
                        onSubmitted: (_) => _handleSend(chatViewModel),
                        enabled: !chatViewModel.isLoading,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: chatViewModel.isLoading
                          ? null
                          : () => _handleSend(chatViewModel),
                      child: const Text('Enviar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
