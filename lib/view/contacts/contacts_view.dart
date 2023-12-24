import 'package:airsense/widgets/headers/user_header.dart';
import 'package:flutter/material.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: <Widget> [
            UserHeader(),
            SizedBox(height: 20)
          ] 
        )
      )
    );
  }
}