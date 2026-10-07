// Created by Juan David Romero.

class AppConfig {
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:8000',
  );

  static const String user = String.fromEnvironment(
    'API_USER',
    defaultValue: 'usuario-dev-juan',
  );
}
