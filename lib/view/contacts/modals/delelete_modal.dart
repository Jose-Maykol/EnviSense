import 'package:flutter/material.dart';

class DeleteConfirmationDialog {
  static void show(BuildContext context, VoidCallback onDeleteConfirmed) {
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
              onPressed: () {
                onDeleteConfirmed(); // Llama a la función de eliminación confirmada
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
