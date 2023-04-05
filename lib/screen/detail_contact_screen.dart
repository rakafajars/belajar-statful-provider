import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_2/service/contact_service.dart';

class DetailContactScreen extends StatefulWidget {
  final String idContact;
  const DetailContactScreen({
    super.key,
    required this.idContact,
  });

  @override
  State<DetailContactScreen> createState() => _DetailContactScreenState();
}

class _DetailContactScreenState extends State<DetailContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Contacts',
        ),
      ),
      body: FutureBuilder(
        future: ContactService().getDetailContact(widget.idContact),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data?.name ?? "-");
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
