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
import 'login_screen.dart';
import 'profile_details_screen.dart';
import 'exercise_plan_details_screen.dart';
import 'patient_progress_screen.dart';
import 'chat_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:myapp/models/progress_models.dart';
//import 'package:url_launcher/url_launcher.dart'; // Para abrir Power BI
import 'package:android_intent_plus/android_intent.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  final UserProfile userProfile;

  const HomeScreen({super.key, required this.userProfile});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Exercise> dailyExercises = generateRandomExercises();
  late final List<WeightProgress> weightData;
  late final List<MobilityProgress> mobilityData;
  late final List<StrengthProgress> strengthData;

  @override
  void initState() {
    super.initState();
    weightData = generateDynamicWeightData(widget.userProfile.initialWeight);
    mobilityData = generateDynamicMobilityData();
    strengthData = generateDynamicStrengthData();
  }

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



  // Métodos para calcular los objetivos
  double getWeightGoal(double initialWeight) {
    return initialWeight - 2; // Peso objetivo
  }

  double getMobilityGoal() {
    return 85.0; // Meta de movilidad
  }

  double getStrengthGoal() {
    return 75.0; // Meta de fuerza
  }

  void _signOut(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _requestNewDailyPlan() {
    setState(() {
      dailyExercises = generateRandomExercises();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Daily Plan requested successfully.')),
    );
  }

  // Mostrar el cuadro de diálogo para Bluetooth
  void _showBluetoothDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bluetooth Status',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Icon(Icons.bluetooth_connected, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Connected to: SRTS Shirt',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const Text(
                'Other available devices:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.devices),
                title: const Text('Device 1'),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Connected to device 1'),
                      ),
                    );
                  },
                  child: const Text('Connect'),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.devices),
                title: const Text('Device 2'),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Connected to device 2'),
                      ),
                    );
                  },
                  child: const Text('Connect'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Sección para mostrar el dispositivo conectado
  Widget _buildConnectedDeviceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Ícono de la camiseta
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF82B1FF), // Azul claro
                ),
                child: const Icon(
                  Icons.checkroom, // Ícono representativo de una prenda
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              // Información del dispositivo
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Connected Device",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B4F72),
                      ),
                    ),
                    Text(
                      "SRTS Smart Shirt",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // Botón para gestionar dispositivos
              ElevatedButton(
                onPressed: () {
                  _showBluetoothDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF027AFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  "Manage",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double weightGoal = getWeightGoal(widget.userProfile.initialWeight);
    final double mobilityGoal = getMobilityGoal();
    final double strengthGoal = getStrengthGoal();

    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FC), // Fondo azul claro
      appBar: AppBar(
        title: const Text('SRTS Home Page'),
        elevation: 0,
        backgroundColor: const Color(0xFF82B1FF), // Azul oscuro
        actions: [
          IconButton(
            icon: const Icon(Icons.wifi),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.bluetooth),
            onPressed: () => _showBluetoothDialog(context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileDetailsScreen(
                      userProfile: widget.userProfile,
                      isDemo: false,
                    ),
                  ),
                );
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Options Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileDetailsScreen(
                      userProfile: widget.userProfile,
                      isDemo: false,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Progress'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientProgressScreen(
                      weightData: weightData,
                      mobilityData: mobilityData,
                      strengthData: strengthData,
                      weightGoal: weightGoal,
                      mobilityGoal: mobilityGoal,
                      strengthGoal: strengthGoal,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sports),
              title: const Text('Exercise Plan'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExercisePlanDetailsScreen(
                      exercises: dailyExercises,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () => _signOut(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildConnectedDeviceSection(), // Nueva sección para dispositivo conectado
              const SizedBox(height: 16),
              _buildExercisePlanSection(),
              _buildPatientProgressSection(
                  weightGoal, mobilityGoal, strengthGoal),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatScreen(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.chat_bubble_outline,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildExercisePlanSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daily Exercise Plan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: dailyExercises
                    .asMap()
                    .entries
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${entry.key + 1}. ",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Expanded(
                              child: Text(
                                "${entry.value.name} (${entry.value.details})",
                                style: const TextStyle(fontSize: 16),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExercisePlanDetailsScreen(
                              exercises: dailyExercises,
                            ),
                          ),
                        );
                      },
                      child: const Text('More Details'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _requestNewDailyPlan,
                      child: const Text('Request Daily Plan'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientProgressSection(
      double weightGoal, double mobilityGoal, double strengthGoal) {
    final double currentWeight = weightData.last.weight;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Patient Progress',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Current Weight: ${currentWeight.toStringAsFixed(1)} kg',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 150,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    LineSeries<WeightProgress, String>(
                      dataSource: weightData,
                      xValueMapper: (WeightProgress progress, _) =>
                          progress.day,
                      yValueMapper: (WeightProgress progress, _) =>
                          progress.weight,
                      markerSettings: const MarkerSettings(isVisible: true),
                      color: Colors.blue,
                      name: 'Progress',
                    ),
                  ],
                  tooltipBehavior: TooltipBehavior(enable: true),
                ),
              ),
              const SizedBox(height: 8),
              Text('Weight Goal: ${weightGoal.toStringAsFixed(1)} kg',
                  style: const TextStyle(fontSize: 16)),
              Text('Mobility Goal: ${mobilityGoal.toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 16)),
              Text('Strength Goal: ${strengthGoal.toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),

              // Botones centrados
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientProgressScreen(
                              weightData: weightData,
                              mobilityData: mobilityData,
                              strengthData: strengthData,
                              weightGoal: weightGoal,
                              mobilityGoal: mobilityGoal,
                              strengthGoal: strengthGoal,
                            ),
                          ),
                        );
                      },
                      child: const Text('View Full Progress'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _openPowerBI,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA726), // Naranja
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Detailed Analytics in PowerBi',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
