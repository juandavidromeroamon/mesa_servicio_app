// Created by Juan David Romero.

import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_exception.dart';
import 'config.dart';

class ApiClient {
  final http.Client? _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> getJson(String path) async {
    try {
      final url = Uri.parse('${AppConfig.apiUrl}$path');
      final response = await _client?.get(url).timeout(const Duration(seconds: 300));
      
      if (response == null) {
        throw ApiException("No se recibió respuesta del servidor.");
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw ApiException("El servicio respondió con error ${response.statusCode}", statusCode: response.statusCode);
      }
    } on TimeoutException {
      throw ApiException("El servicio tardó demasiado en responder");
    } on SocketException {
      throw ApiException("No se pudo conectar con el servicio");
    } on http.ClientException catch (e) {
      throw ApiException("Error de cliente: ${e.message}");
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException("Error inesperado: $e");
    }
  }

  Future<Map<String, dynamic>> postJson(String path, Map<String, dynamic> body) async {
    try {
      final url = Uri.parse('${AppConfig.apiUrl}$path');
      final response = await _client?.post(
        url,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 300));

      if (response == null) {
        throw ApiException("No se recibió respuesta del servidor.");
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw ApiException("El servicio respondió con error ${response.statusCode}", statusCode: response.statusCode);
      }
    } on TimeoutException {
      throw ApiException("El servicio tardó demasiado en responder");
    } on SocketException {
      throw ApiException("No se pudo conectar con el servicio");
    } on http.ClientException catch (e) {
      throw ApiException("Error de cliente: ${e.message}");
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException("Error inesperado: $e");
    }
  }
}
