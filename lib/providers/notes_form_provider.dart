import 'package:flutter/material.dart';

import '../models/modelo_estudiante.dart';

class EstudiantesFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Estudiante estudiante;

  EstudiantesFormProvider(this.estudiante);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
