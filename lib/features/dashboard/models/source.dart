// Created by Juan David Romero.

class Source {
  final String id;
  final String categoria;
  final String pregunta;
  final String respuesta;

  Source({
    required this.id,
    required this.categoria,
    required this.pregunta,
    required this.respuesta,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? '',
      categoria: json['categoria'] ?? '',
      pregunta: json['pregunta'] ?? '',
      respuesta: json['respuesta'] ?? '',
    );
  }
}
