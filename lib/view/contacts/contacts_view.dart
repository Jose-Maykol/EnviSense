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
                    padding: EdgeInsets.zero,
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
                          contentPadding: EdgeInsets.zero,
                          isThreeLine: true,
                          dense: true,
                          title: Text(
                            contacts[index].name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColor.grey500,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                          subtitle: Text(
                            contacts[index].email,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColor.grey300,
                            )
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  handleEditContact(context, contacts[index].id);
                                  ref.refresh(contactProvider);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColor.blue400,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  handleDeleteContact(context, contacts[index].id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ] 
              ),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}