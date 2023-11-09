import 'package:flutter/material.dart';
import 'package:notes_api_crud_app/services/notes_service.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option_provider.dart';
import '../providers/notes_form_provider.dart';

class CreateEstudianteScreen extends StatelessWidget {
  const CreateEstudianteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EstudiantesService estudianteService = Provider.of(context);

    //Creando un provider solo enfocado al formulario
    return ChangeNotifierProvider(
        create: (_) =>
            EstudiantesFormProvider(estudianteService.selectedEstudiante),
        child: _CreateForm(estudianteService: estudianteService));
  }
}

class _CreateForm extends StatelessWidget {
  final EstudiantesService estudianteService;

  const _CreateForm({required this.estudianteService});

  @override
  Widget build(BuildContext context) {
    final EstudiantesFormProvider estudiantesFormProvider =
        Provider.of<EstudiantesFormProvider>(context);

    final estudiante = estudiantesFormProvider.estudiante;

    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context, listen: false);
    return Form(
      key: estudiantesFormProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: estudiante.nombre,
            decoration: const InputDecoration(
                hintText: 'Construir Apps',
                labelText: 'Titulo',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
            onChanged: (value) =>
                estudiantesFormProvider.estudiante.nombre = value,
            validator: (value) {
              return value != ''
                  ? null
                  : 'El campo no debe estar vacío'; //cambiar mensaje
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            maxLines: 10,
            autocorrect: false,
            initialValue: estudiante.documentoIdentidad,
            // keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Aprender sobre Dart...',
              labelText: 'Descripción',
            ),
            onChanged: (value) => estudiante.documentoIdentidad = value,
            validator: (value) {
              return (value != null)
                  ? null
                  : 'El campo no puede estar vacío'; //cambiar mensaje
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            onPressed: estudianteService.isSaving
                ? null
                : () async {
                    //Quitar teclado al terminar
                    FocusScope.of(context).unfocus();

                    if (!estudiantesFormProvider.isValidForm()) return;
                    await estudianteService
                        .createOrUpdate(estudiantesFormProvider.estudiante);
                    actualOptionProvider.selectedOption = 0;
                  },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  estudianteService.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
