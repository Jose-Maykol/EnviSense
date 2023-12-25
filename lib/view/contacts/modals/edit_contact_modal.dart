// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:airsense/constant/colors.dart';
import 'package:airsense/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditContactModal {
  static void show(BuildContext context, String contactId, WidgetRef ref) async {
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
          title: const Text(
            'Editar contacto',
            style: TextStyle(
              fontSize: 18,
              color: AppColor.blue500,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Ingresa los datos del contacto',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.grey300,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: const BorderSide(
                      color: AppColor.blue500,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  )
                ),
              ),
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
                ref.refresh(contactProvider);
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.blue500),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return AppColor.blue500.withOpacity(0.2);
                    }
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed)) {
                      return AppColor.blue500.withOpacity(0.2);
                    }
                    return null; // Defer to the widget's default.
                  },
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )
                ),
              ),
              child: const Text(
                'Guardar',
                style: TextStyle(
                  color: AppColor.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
