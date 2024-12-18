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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myapp/models/progress_models.dart';

class ExercisePlanDetailsScreen extends StatefulWidget {
  final List<Exercise> exercises;

  const ExercisePlanDetailsScreen({super.key, required this.exercises});

  @override
  _ExercisePlanDetailsScreenState createState() =>
      _ExercisePlanDetailsScreenState();
}

class _ExercisePlanDetailsScreenState extends State<ExercisePlanDetailsScreen>
    with WidgetsBindingObserver {
  late Timer _errorSimulationTimer;
  bool isTrainingSessionActive = false; // Bandera para controlar la sesión activa

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Observa los cambios de estado de la app
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_errorSimulationTimer.isActive) {
      _errorSimulationTimer.cancel();
    }
    super.dispose();
  }

  // Manejar el ciclo de vida de la app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && isTrainingSessionActive) {
      // Reanudar alertas al regresar a la pantalla
      _startErrorSimulation();
    } else if (state == AppLifecycleState.paused) {
      // Pausar alertas al salir de la pantalla
      _errorSimulationTimer.cancel();
    }
  }

  // Función para iniciar la simulación de errores
  void _startErrorSimulation() {
    _errorSimulationTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _showMovementErrorDialog("Incorrect movement detected! Activating correction sensor...");
    });
  }

  // Función para abrir el enlace en el navegador
  Future<void> _launchURL(BuildContext context, String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'The link could not be opened';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Error: Unable to open link.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Función para mostrar un diálogo de alerta con corrección automática
  void _showMovementErrorDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          if (context.mounted) Navigator.of(context).pop();
        });

        return AlertDialog(
          title: const Text(
            "Posture Alert!",
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.sensors, color: Colors.orange, size: 50),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "The correction sensor is adjusting your posture.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  // Función para iniciar la sesión de entrenamiento
  void _startTrainingSession(BuildContext context) {
    setState(() {
      isTrainingSessionActive = true;
    });

    _startErrorSimulation();

    // Mostrar diálogo de carga
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          if (context.mounted) Navigator.of(context).pop();
        });

        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                "Initializing sensors...",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                "Starting measurements...",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FC),
      appBar: AppBar(
        title: const Text('Exercise Plan Details'),
        elevation: 0,
        backgroundColor: const Color(0xFF82B1FF),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Exercise Plan",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B4F72),
              ),
            ),
            const SizedBox(height: 16),

            // Mostrar los ejercicios
            ...widget.exercises.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(
                      "${entry.key + 1}. ${entry.value.name}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(entry.value.details),
                    trailing: IconButton(
                      icon: const Icon(Icons.video_library, color: Colors.blue),
                      onPressed: () =>
                          _launchURL(context, entry.value.videoUrl),
                      tooltip: 'Watch video',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Botón para iniciar la sesión de entrenamiento
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _startTrainingSession(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF027AFF),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  "Start Training Session",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Texto informativo
            const Text(
              "Remember to perform the exercises carefully and follow your physiotherapist's instructions. If you feel pain or discomfort, stop immediately.",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF1B4F72),
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
