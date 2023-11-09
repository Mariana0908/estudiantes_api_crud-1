//recopila una serie de metodos que se realizarán en la base de datos(firebase)
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //as para asignarle un alias
import '../models/modelo_estudiante.dart';

class EstudiantesService extends ChangeNotifier {
  //Asignamos la url base a un atributo para accceder a él facilmente.

  final String _baseUrl = "testapi-ea3c4-default-rtdb.firebaseio.com";

  late Estudiante selectedEstudiante;

  List<Estudiante> estudiantes = [];

  bool isLoading = false;
  bool isSaving = false;

  EstudiantesService() {
    loadEstudiantes(); //Metodo para cargar las notas
  }

  Future<List<Estudiante>> loadEstudiantes() async {
    isLoading = true;
    //añadir alerta para la parte visual
    notifyListeners();

    //Creamos la url a donde vamos a generar la solicitud
    final url = Uri.https(_baseUrl, 'estudiantes.json');
    final resp = await http.get(url);

    final Map<String, dynamic> estudiantesMap =
        json.decode(resp.body); //con el decode lo convertimos a una estructura
    // de datos que entienda dart, en ete caso un mapa, porque lo que traería sería una cadena de texto gigante
    print(estudiantesMap);

    estudiantesMap.forEach((key, value) {
      /**
        * Lo que nos devuelve body es esto:
        safsadfasdf:{
          description: dsfafasfdasf
          title: asdfsfsadfas
        }
         Así esta definido el mapa*/

      Estudiante tempEstudiante = Estudiante.fromJson(value);
      tempEstudiante.id = key;
      estudiantes.add(tempEstudiante);
    });

    isLoading = false;
    notifyListeners();
    print("hola ${this.estudiantes}");
    return estudiantes;
  }

  Future createOrUpdate(Estudiante estudiante) async {
    isSaving = true;
    notifyListeners(); //agregado

    if (estudiante.id == null) {
      await createEstudiante(estudiante);
    } else {
      await updateEstudiante(estudiante);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> createEstudiante(Estudiante estudiante) async {
    isSaving = true;
    final url = Uri.https(_baseUrl, 'estudiantes.json');
    final resp = await http.post(url, body: estudiante.toJson());

    final decodedData = json.decode(resp.body);

    estudiante.id = decodedData['name'];

    estudiantes.add(estudiante);

    return estudiante.id!;
  }

  Future<String> updateEstudiante(Estudiante estudiante) async {
    isSaving = true;
    final url = Uri.https(_baseUrl, 'estudiantes.json');
    final resp = await http.put(url, body: estudiante.toJson());

    final decodedData = json.decode(resp.body);

    final index =
        estudiantes.indexWhere((element) => element.id == estudiante.id);

    estudiantes[index] = estudiante;

    return estudiante.id!;
  }

  Future<String> deleteEstudianteById(String id) async {
    isLoading = true;
    final url = Uri.https(_baseUrl, 'estudiantes.json');
    final resp = await http.delete(url, body: {"name": id});

    final decodedData = json.decode(resp.body);

    loadEstudiantes();
    return id;
  }
}
