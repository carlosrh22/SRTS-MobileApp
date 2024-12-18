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
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:myapp/models/progress_models.dart';
//import 'package:url_launcher/url_launcher.dart'; // Asegúrate de tener url_launcher en pubspec.yaml
import 'package:android_intent_plus/android_intent.dart';
import 'dart:io';

class PatientProgressScreen extends StatelessWidget {
  final List<WeightProgress> weightData;
  final List<MobilityProgress> mobilityData;
  final List<StrengthProgress> strengthData;
  final double weightGoal;
  final double mobilityGoal;
  final double strengthGoal;

  const PatientProgressScreen({
    super.key,
    required this.weightData,
    required this.mobilityData,
    required this.strengthData,
    required this.weightGoal,
    required this.mobilityGoal,
    required this.strengthGoal,
  });

  // Función para abrir Power BI
  Future<void> _openPowerBI() async {
    try {
      const String powerBiUrl =
          'https://app.powerbi.com/view?r=eyJrIjoiNjk4OTMxYmUtYWYyYy00Y2RmLWE3ZTQtMmYyMTE2MDU1ZDM2IiwidCI6IjZhZmVhODVkLWMzMjMtNDI3MC1iNjlkLWE0ZmIzOTI3YzI1NCIsImMiOjl9';

      if (Platform.isAndroid) {
        const AndroidIntent intent = AndroidIntent(
          action: 'action_view',
          data: powerBiUrl,
          package: 'org.mozilla.firefox', // Especifica Firefox
        );
        await intent.launch();
      } else {
        print('Intent no soportado en esta plataforma');
        throw 'Opening in Firefox is only supported on Android.';
      }
    } catch (e) {
      print('Error al abrir Power BI: $e');
    }
  }


  // Tarjeta destacada para Power BI
  Widget _buildHighlightedPowerBIButton() {
    return Card(
      color: const Color(0xFFFCF8E8), // Fondo amarillo claro para destacar
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4, // Sombra para resaltar
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícono destacado
            const Icon(
              Icons.bar_chart,
              color: Color(0xFFFFA726), // Naranja llamativo
              size: 36,
            ),
            const SizedBox(width: 16),
            // Texto informativo
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detailed Analytics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Explore detailed progress insights through our Power BI dashboard.',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Botón
            ElevatedButton(
              onPressed: _openPowerBI,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA726), // Naranja
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Open',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double currentWeight = weightData.last.weight;

    return Scaffold(
      appBar: AppBar(title: const Text('Rehabilitation Progress')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarjeta destacada de Power BI
            _buildHighlightedPowerBIButton(),
            const SizedBox(height: 16),
          // Peso actual
          Text(
            'Current Weight: ${currentWeight.toStringAsFixed(1)} kg',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
            // Gráfico de Progreso en Peso
            const Text(
              'Weight Progress (Last Week)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildLineChart<WeightProgress>(
              data: weightData,
              xValueMapper: (WeightProgress progress, _) => progress.day,
              yValueMapper: (WeightProgress progress, _) => progress.weight,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),

            // Gráfico de Movilidad
            const Text(
              'Mobility Progress (Last Week)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildLineChart<MobilityProgress>(
              data: mobilityData,
              xValueMapper: (MobilityProgress progress, _) => progress.day,
              yValueMapper: (MobilityProgress progress, _) => progress.mobility,
              color: Colors.green,
            ),
            const SizedBox(height: 24),

            // Gráfico de Fuerza
            const Text(
              'Strength Progress (Last Week)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildLineChart<StrengthProgress>(
              data: strengthData,
              xValueMapper: (StrengthProgress progress, _) => progress.day,
              yValueMapper: (StrengthProgress progress, _) => progress.strength,
              color: Colors.red,
            ),
            const SizedBox(height: 24),

            // Gráfico de Cumplimiento de Ejercicios
            const Text(
              'Exercise Compliance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: SfCircularChart(
                series: <CircularSeries>[
                  PieSeries<ChartData, String>(
                    dataSource: [
                      ChartData('Completed', 90, Colors.blue),
                      ChartData('Pending', 10, Colors.grey),
                    ],
                    xValueMapper: (ChartData data, _) => data.label,
                    yValueMapper: (ChartData data, _) => data.value,
                    pointColorMapper: (ChartData data, _) => data.color,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Objetivos Personalizados
            const Text(
              'Customized Goals',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Weight Goal: ${weightGoal.toStringAsFixed(1)} kg',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Mobility Goal: ${mobilityGoal.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Strength Goal: ${strengthGoal.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Notas del Médico/Fisio
            const Text(
              'Physiotherapist´s Notes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Maintain the current exercise pace and increase intensity next week. '
              'Good recovery in mobility and strength is observed, but it is necessary to maintain the '
              'follow-up on the exercise plan to achieve the weight goal.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // Gráfico de línea reutilizable
  Widget _buildLineChart<T>({
    required List<T> data,
    required ChartValueMapper<T, String> xValueMapper,
    required ChartValueMapper<T, double> yValueMapper,
    required Color color,
  }) {
    return SizedBox(
      height: 200,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          LineSeries<T, String>(
            dataSource: data,
            xValueMapper: xValueMapper,
            yValueMapper: yValueMapper,
            markerSettings: const MarkerSettings(isVisible: true),
            color: color,
          ),
        ],
      ),
    );
  }
}
