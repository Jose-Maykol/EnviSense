

import 'package:flutter/material.dart';

class AddContactModal {
  static void show(BuildContext context, Function(String, String) onContactAdded) {
    String _name = '';
    String _email = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar contacto'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nombre'),
                  onChanged: (value) {
                    _name = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (value) {
                    _email = value;
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
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Llama a la función para agregar el contacto en Firebase
                await onContactAdded(_name, _email);
                Navigator.pop(context); // Cierra el modal
              },
              child: Text('Agregar'),
            ),
          ],
        );
      },
    );
  }
}