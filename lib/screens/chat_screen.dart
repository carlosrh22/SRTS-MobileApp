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

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<String> messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add(text);
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FC), // Fondo azul claro
      appBar: AppBar(
        title: const Text('Chat with the Doctor/Physiotherapist'),
        elevation: 0, // Elimina la sombra
        backgroundColor: const Color(0xFF82B1FF), // Azul más oscuro
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white, // Fondo blanco para el área del chat
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: messages.isEmpty
                  ? const Center(
                      child: Text(
                        'No messages. Write the first one!',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF82B1FF), // Burbuja azul
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Text(
                              messages[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Write your message...',
                      filled: true,
                      fillColor: const Color(0xFFEAF4FC), // Fondo azul claro
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  backgroundColor: const Color(0xFF82B1FF), // Botón azul
                  mini: true, // Tamaño pequeño
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
