// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:airsense/constant/colors.dart';
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
          title: const Text(
            'Eliminar contacto',
            style: TextStyle(
              fontSize: 18,
              color: AppColor.blue500,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text('¿Estás seguro de que deseas eliminar este contacto?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el diálogo
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
                await FirebaseFirestore.instance.collection('contacts').doc(contactId).delete();
                ref.refresh(contactProvider);
                Navigator.pop(context); // Cierra el diálogo
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
                'Eliminar',
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
