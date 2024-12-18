/*
 * Copyright (c) 2024
 * Developed by: Carlos Rubio Hernán, Miguel Ángel Arias González, Diego Fernández Gómez, Sonia Menéndez Menéndez
 * Institution: Polytechnic University of Madrid
 * Course: Projects in Data Engineering and Systems
 * Contact: srtsdemo@gmail.com
 *
 * This code is part of the MyApp project, developed for educational purposes.
 * Licensed under the MIT License. See the LICENSE file for more details.
 */

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'models/progress_models.dart'; // Asegúrate de importar el archivo donde está definido UserProfile

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Perfil ficticio de usuario inicial
    final UserProfile initialUserProfile = UserProfile(
      username: "demo_user",
      password: "1234",
      fullName: "Demo User",
      age: 30,
      initialWeight: 75.0,
      additionalInfo: "User example",
    );

    return MaterialApp(
      title: 'APP Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFFCEEAF4), // Azul clarito
        scaffoldBackgroundColor: const Color(0xFFF6FBFE), // Fondo azul muy suave
        appBarTheme: const AppBarTheme(
          color: Color(0xFFCEEAF4), // Azul clarito
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF027AFF), // Azul fuerte
        ),
        cardColor: Colors.white, // Fondo blanco para tarjetas
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF027AFF), // Azul fuerte
            foregroundColor: Colors.white, // Texto blanco en botones
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Asegura que el texto sea blanco
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF027AFF), // Azul fuerte para textos
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // En lugar de bodyText1
          bodyMedium: TextStyle(color: Colors.black), // En lugar de bodyText2
        ),
      ),
      debugShowCheckedModeBanner: false, // Elimina el banner de depuración
      home: HomeScreen(userProfile: initialUserProfile), // Pasar perfil inicial
    );
  }
}
