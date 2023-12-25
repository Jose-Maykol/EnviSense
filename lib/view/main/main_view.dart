import 'package:airsense/constant/colors.dart';
import 'package:airsense/view/contacts/contacts_view.dart';
import 'package:airsense/view/contacts/modals/add_contact_modal.dart';
import 'package:airsense/view/home/home_view.dart';
import 'package:airsense/view/settings/settings_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int _selectedIndex = 0;

  void _handleAddContact(BuildContext context) {
    AddContactModal.show(context);
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
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
        children: const <Widget> [
          HomeView(),
          ContactsView(),
          SettingsView()
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