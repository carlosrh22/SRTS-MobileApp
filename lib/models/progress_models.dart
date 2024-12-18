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

import 'dart:math';
import 'dart:ui';

class WeightProgress {
  final String day;
  final double weight;

  WeightProgress(this.day, this.weight);
}

class MobilityProgress {
  final String day;
  final double mobility;

  MobilityProgress(this.day, this.mobility);
}

class StrengthProgress {
  final String day;
  final double strength;

  StrengthProgress(this.day, this.strength);
}

class Exercise {
  final String name;
  final String details;
  final String videoUrl; // URL del video de YouTube u otro sitio

  Exercise(this.name, this.details, this.videoUrl);
}

// Clase auxiliar para el gráfico circular de Cumplimiento
class ChartData {
  final String label;
  final double value;
  final Color color;

  ChartData(this.label, this.value, this.color);
}

class UserProfile {
  final String username;
  final String password;
  final String fullName;
  final int age;
  final double initialWeight;
  final String additionalInfo;

  UserProfile({
    required this.username,
    required this.password,
    required this.fullName,
    required this.age,
    required this.initialWeight,
    required this.additionalInfo,
  });
}

// Lista de perfiles disponibles
final List<UserProfile> userProfiles = [
  UserProfile(
    username: 'juan.perez',
    password: '1234',
    fullName: 'Juan Pérez',
    age: 35,
    initialWeight: 81,
    additionalInfo: 'Shoulder rehabilitation',
  ),
  UserProfile(
    username: 'ana.gomez',
    password: '5678',
    fullName: 'Ana Gómez',
    age: 28,
    initialWeight: 70,
    additionalInfo: 'Shoulder rehabilitation',
  ),
];

List<Exercise> generateRandomExercises() {
  final List<Exercise> possibleExercises = [
    Exercise("Lateral raise with light weights", "3 sets de 10 repetitions", "https://www.youtube.com/watch?v=O5S40bbb2a4"),
    Exercise("Arm extension with elastic band", "3 sets de 10 repetitions", "https://www.youtube.com/watch?v=w9Tt04K23ts"),
    Exercise("Inclined row with elastic band", "3 sets de 15 repetitions", "https://www.youtube.com/watch?v=DLcCfR6UYDY"),
    Exercise("Hand sliding on the wall", "Repeat aiming to reach maximum height", "https://www.youtube.com/shorts/32cLXPTbFMc"),
    Exercise("Pectoral stretch with elastic band","3 sets of 10 circular movements", "https://www.youtube.com/shorts/3HyvtSrJSLk"),
    Exercise("External shoulder rotation", "2 sets de 10 repetitions", "https://www.youtube.com/shorts/iNn_sNA6TbU"),
    Exercise("Arm lift in 'Y' position lying down", "2 sets de 6 repetitions", "https://www.youtube.com/watch?v=5H0w3enTMG8"),
    Exercise("Ball throwing", "3 sets de 12 repetitions", "https://www.youtube.com/watch?v=FqtCUCfzV5I"),
    Exercise("Shoulder circular rotation", "3 sets de 8 repetitions", "https://www.youtube.com/watch?v=885PHIF-ebk"),
  ];

  final Random random = Random();
  return List.generate(4, (_) => possibleExercises[random.nextInt(possibleExercises.length)]);
}

// Generar datos aleatorios para progreso de peso con fechas
List<WeightProgress> generateDynamicWeightData(double initialWeight) {
  final Random random = Random();
  final DateTime today = DateTime.now();
  double currentWeight = initialWeight;
  final List<WeightProgress> data = [];

  for (int i = 0; i < 7; i++) {
    final DateTime day = today.subtract(Duration(days: 6 - i));
    final String formattedDay = "${day.day}/${day.month}"; // Formato DD/MM
    double change = -0.2 + random.nextDouble() * 0.2; // Cambios aleatorios de peso
    currentWeight = (currentWeight + change).clamp(initialWeight - 3.0, initialWeight);
    data.add(WeightProgress(formattedDay, currentWeight));
  }

  return data;
}

// Generar datos aleatorios para progreso de movilidad con fechas
List<MobilityProgress> generateDynamicMobilityData() {
  final Random random = Random();
  final DateTime today = DateTime.now();
  double initialMobility = 60.0; // Punto inicial para movilidad
  final List<MobilityProgress> data = [];

  for (int i = 0; i < 7; i++) {
    final DateTime day = today.subtract(Duration(days: 6 - i));
    final String formattedDay = "${day.day}/${day.month}";
    double increment = 0.4 + random.nextDouble() * 1.0; // Incremento aleatorio
    initialMobility += increment;
    double variation = random.nextDouble() * 2 - 1; // Variación adicional
    data.add(MobilityProgress(formattedDay, initialMobility + variation));
  }

  return data;
}

// Generar datos aleatorios para progreso de fuerza con fechas
List<StrengthProgress> generateDynamicStrengthData() {
  final Random random = Random();
  final DateTime today = DateTime.now();
  double initialStrength = 50.0; // Punto inicial para fuerza
  final List<StrengthProgress> data = [];

  for (int i = 0; i < 7; i++) {
    final DateTime day = today.subtract(Duration(days: 6 - i));
    final String formattedDay = "${day.day}/${day.month}";
    double increment = 0.4 + random.nextDouble() * 1.5; // Incremento aleatorio
    initialStrength += increment;
    double variation = random.nextDouble() * 2 - 1; // Variación adicional
    data.add(StrengthProgress(formattedDay, initialStrength + variation));
  }

  return data;
}
