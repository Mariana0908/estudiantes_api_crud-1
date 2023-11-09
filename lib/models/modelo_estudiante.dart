//Clase modelo
import 'dart:convert';

Estudiante estudianteFromJson(String str) =>
    Estudiante.fromJson(json.decode(str));

String estudianteToJson(Estudiante data) => json.encode(data.toJson());

class Estudiante {
  String? id;
  String nombre;
  String documentoIdentidad;
  String edad;

  Estudiante({
    this.id,
    required this.nombre,
    required this.documentoIdentidad,
    required this.edad,
  });

  String toJson() => json.encode(toMap());

  factory Estudiante.fromJson(Map<String, dynamic> json) => Estudiante(
        id: json["id"],
        nombre: json["nombre"],
        documentoIdentidad: json["documentoIdentidad"],
        edad: json["edad"],
      );

  Map<String, dynamic> toMap() => {
        // "id": id,
        "nombre": nombre,
        "documentoIdentidad": documentoIdentidad,
        "edad": edad,
      };
}
