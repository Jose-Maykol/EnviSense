// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:airsense/providers/contact_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteConfirmationDialog {
  static void show(BuildContext context, String contactId, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar contacto'),
          content: const Text('¿Estás seguro de que deseas eliminar este contacto?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection('contacts').doc(contactId).delete();
                ref.refresh(contactProvider);
                Navigator.pop(context); // Cierra el diálogo
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}
