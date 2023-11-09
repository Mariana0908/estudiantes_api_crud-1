import 'package:flutter/material.dart';
import 'package:notes_api_crud_app/providers/actual_option_provider.dart';
import 'package:notes_api_crud_app/screens/home_screen.dart';
import 'package:notes_api_crud_app/services/estudiantes_service.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ActualOptionProvider()),
          ChangeNotifierProvider(create: (_) => EstudiantesService())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            initialRoute: "main",
            routes: {'main': (_) => const HomeScreen()}));
  }
}
