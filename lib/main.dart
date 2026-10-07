// Created by Juan David Romero.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mesa_servicio_app/core/http_client.dart';
import 'package:mesa_servicio_app/features/dashboard/data/dashboard_repository.dart';
import 'package:mesa_servicio_app/features/dashboard/viewmodel/chat_view_model.dart';
import 'package:mesa_servicio_app/features/dashboard/viewmodel/metrics_view_model.dart';
import 'package:mesa_servicio_app/features/dashboard/view/dashboard_page.dart';

void main() {
  runApp(const MesaServicioApp());
}

class MesaServicioApp extends StatelessWidget {
  const MesaServicioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiClient>(
          create: (_) => ApiClient(),
        ),
        Provider<DashboardRepository>(
          create: (context) => DashboardRepository(context.read<ApiClient>()),
        ),
        ChangeNotifierProvider<ChatViewModel>(
          create: (context) => ChatViewModel(context.read<DashboardRepository>()),
        ),
        ChangeNotifierProvider<MetricsViewModel>(
          create: (context) => MetricsViewModel(context.read<DashboardRepository>())..start(),
        ),
      ],
      child: MaterialApp(
        title: 'Mesa de servicio',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const DashboardPage(),
      ),
    );
  }
}
