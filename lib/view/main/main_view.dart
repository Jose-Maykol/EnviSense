import 'package:airsense/constant/colors.dart';
import 'package:airsense/view/contacts/contacts_view.dart';
import 'package:airsense/view/contacts/modals/add_contact_modal.dart';
import 'package:airsense/view/home/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int _selectedIndex = 0;

  void _handleAddContact(BuildContext context) {
  AddContactModal.show(context, (String name, String email) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      // Agregar el nuevo contacto a Firebase
      await FirebaseFirestore.instance.collection('contacts').add({
        'name': name,
        'email': email,
        'userId': user?.uid,
      });
      print('Contacto agregado a Firebase: Nombre: $name, Email: $email');
    } catch (e) {
      print('Error al agregar el contacto a Firebase: $e');
      // Manejar cualquier error que ocurra al agregar el contacto a Firebase
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.white,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contactos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.blue500,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const <Widget>[
          HomeView(),
          ContactsView(),
        ],
      ),
      floatingActionButton: _selectedIndex == 1 ? FloatingActionButton(
        onPressed: () {
          _handleAddContact(context);
        },
        backgroundColor: AppColor.blue500,
        child: const Icon(
          Icons.add,
          color: AppColor.white,
        ),
      ) : null,
    );
  }
}