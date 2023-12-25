// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:airsense/providers/contact_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddContactModal {
  static void show(BuildContext context) {
    String name = '';
    String email = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar contacto'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (value) {
                    email = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el modal
              },
              child: const Text('Cancelar'),
            ),
            Consumer(
              builder: (context, ref, child) {
                return TextButton(
                  onPressed: () async {
                    // Llama a la función para agregar el contacto en Firebase
                    User? user = FirebaseAuth.instance.currentUser;
                    // Agregar el nuevo contacto a Firebase
                    await FirebaseFirestore.instance.collection('contacts').add({
                      'name': name,
                      'email': email,
                      'userId': user?.uid,
                    });
                    ref.refresh(contactProvider);
                    Navigator.pop(context); // Cierra el modal
                  },
                  child: const Text('Agregar'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}