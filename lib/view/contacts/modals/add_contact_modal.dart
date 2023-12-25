// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:airsense/constant/colors.dart';
import 'package:airsense/providers/contact_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddContactModal {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController emailController = TextEditingController();

        return AlertDialog(
          backgroundColor: AppColor.white,
          title: const Text(
            'Agregar contacto',
            style: TextStyle(
              fontSize: 18,
              color: AppColor.blue500,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
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
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el modal
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
            Consumer(
              builder: (context, ref, child) {
                return TextButton(
                  onPressed: () async {
                    String name = nameController.text;
                    String email = emailController.text;
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
                    'Agregar',
                    style: TextStyle(
                      color: AppColor.white,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}