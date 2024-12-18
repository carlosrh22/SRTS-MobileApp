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
import 'package:myapp/models/progress_models.dart';
import 'package:myapp/screens/login_screen.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final UserProfile? userProfile; // Puede ser nulo si está en modo demo
  final bool isDemo; // Indica si está en modo demo

  const ProfileDetailsScreen({
    super.key,
    required this.userProfile,
    required this.isDemo,
  });

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _login(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userProfile != null
                      ? 'User Details'
                      : 'User Details (Demo Mode)',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'Full Name: ${userProfile?.fullName ?? 'Usuario Demo'}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Age: ${userProfile?.age != null ? '${userProfile!.age} years old' : 'N/A'}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Details: ${userProfile?.additionalInfo ?? 'Modo demostración'}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),

                // Botón de Cerrar sesión o Iniciar sesión
                Center(
                  child: ElevatedButton(
                    onPressed: isDemo ? () => _login(context) : () => _logout(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      backgroundColor: isDemo ? Colors.green : Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      isDemo ? 'Log In' : 'Log Out',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
