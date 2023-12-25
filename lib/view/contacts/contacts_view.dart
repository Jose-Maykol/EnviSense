// ignore_for_file: unused_result

import 'package:airsense/constant/colors.dart';
import 'package:airsense/view/contacts/modals/delete_contact_modal.dart';
import 'package:airsense/view/contacts/modals/edit_contact_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:airsense/widgets/headers/user_header.dart';
import 'package:airsense/providers/contact_provider.dart';
import 'package:flutter/material.dart';

class ContactsView extends ConsumerWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final contactsAsyncValue = ref.watch(contactProvider);

    void handleDeleteContact(BuildContext context, String contactId) {
      DeleteConfirmationDialog.show(context, contactId, ref);
    }

    void handleEditContact(BuildContext context, String contactId) {
      EditContactModal.show(context, contactId, ref);
    }

    return contactsAsyncValue.when(
      data: (contacts) {
        return RefreshIndicator(
          onRefresh: () async {
            ref.refresh(contactProvider);
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              const UserHeader(),
              const SizedBox(height: 20),
              const Text(
                'Mis contactos',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.blue500,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,              
              ),
              //const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  if (contacts.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay contactos',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.blue500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return ListTile(
                      isThreeLine: true,
                      dense: true,
                      title: Text(contacts[index].name),
                      subtitle: Text(contacts[index].email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              print('Edit contact');
                              handleEditContact(context, contacts[index].id);
                              ref.refresh(contactProvider);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: AppColor.blue300,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              print('Delete contact');
                              handleDeleteContact(context, contacts[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: AppColor.blue600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ] 
          )
            ),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}

/* class ContactsView extends StatefulWidget {
  const ContactsView({Key? key}) : super(key: key);

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    getContactsFromFirestore();
  }

  void getContactsFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Contact> fetchedContacts = [];

    try {
      print('Getting contacts...');
      User? user = FirebaseAuth.instance.currentUser;
      QuerySnapshot querySnapshot = await firestore.collection('contacts').where('userId', isEqualTo: user?.uid).get();
      print(querySnapshot.docs.length);
      querySnapshot.docs.forEach((doc) {
        Contact contact = Contact.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
        fetchedContacts.add(contact);
        print(contact.id );
      });

      setState(() {
        contacts = fetchedContacts;

      });
    } catch (e) {
      print('Error getting contacts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    Future<void> deleteContactFromFirebase(String contactId) async {
      try {
        await FirebaseFirestore.instance.collection('contacts').doc(contactId).delete();
        print('Contacto eliminado de Firebase');
      } catch (e) {
        print('Error al eliminar el contacto de Firebase: $e');
        // Aquí podrías manejar el error de eliminación de Firebase, si es necesario
      }
    }

    void handleDeleteContact(BuildContext context, int index) {
      String contactId = contacts[index].id;
      DeleteConfirmationDialog.show(context, () {
        deleteContactFromFirebase(contactId);
        setState(() {
          contacts.removeAt(index);
        });
      });
    }

    void handleEditContact(BuildContext context, int index) {
      String contactId = contacts[index].id;
      EditContactModal.show(context, contactId);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            const UserHeader(),
            const SizedBox(height: 20),
            const Text(
              'Mis contactos',
              style: TextStyle(
                fontSize: 16,
                color: AppColor.blue500,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,              
            ),
            //const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                if (contacts.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay contactos',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.blue500,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  return ListTile(
                    isThreeLine: true,
                    dense: true,
                    title: Text(contacts[index].name),
                    subtitle: Text(contacts[index].email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            print('Edit contact');
                            handleEditContact(context, index);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: AppColor.blue300,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            print('Delete contact');
                            handleDeleteContact(context, index);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: AppColor.blue600,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ] 
        )
      )
    );
  }
} */