// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditContactModal {
  static void show(BuildContext context, String contactId) async {
    DocumentSnapshot<Map<String, dynamic>> contactSnapshot = await FirebaseFirestore.instance.collection('contacts').doc(contactId).get();

    if (!contactSnapshot.exists) {
      print('No se encontró el contacto');
      return;
    }

    Map<String, dynamic> contactData = contactSnapshot.data()!;
    String name = contactData['name'];
    String email = contactData['email'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController = TextEditingController(text: name);
        TextEditingController emailController = TextEditingController(text: email);

        return AlertDialog(
          title: const Text('Editar contacto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                String newName = nameController.text;
                String newEmail = emailController.text;

                // Actualizar el contacto en Firebase con los nuevos datos
                await FirebaseFirestore.instance.collection('contacts').doc(contactId).update({
                  'name': newName,
                  'email': newEmail,
                });

                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
