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
import 'home_screen.dart';
import 'package:myapp/models/progress_models.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Método para iniciar sesión
  void _login() {
    try {
      // Buscar el perfil que coincide con las credenciales ingresadas
      final user = userProfiles.firstWhere(
        (profile) =>
            profile.username == _usernameController.text &&
            profile.password == _passwordController.text,
      );

      // Redirigir a la pantalla de inicio con el perfil del usuario
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(userProfile: user),
        ),
      );
    } catch (e) {
      // Mostrar mensaje de error si las credenciales no coinciden
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'User'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
