import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/detail_contact_screen.dart';
import 'package:flutter_application_2/screen/login_page.dart';
import 'package:flutter_application_2/service/contact_service.dart';
import 'package:flutter_application_2/service/receipe_service.dart';
import 'package:flutter_application_2/utils/shared_pref.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _username = "";
  void initial() async {
    _username = await getToken();
    setState(() {});
  }

  @override
  void initState() {
    initial();

    // ContactService().getContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contacts',
        ),
      ),
      body: FutureBuilder(
        future: ContactService().getContact(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final contacts = snapshot.data;

            return ListView.builder(
              itemCount: contacts?.length,
              itemBuilder: (context, index) {
                var data = contacts?[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailContactScreen(
                        idContact: data?.id.toString() ?? "",
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Text(data?.id.toString() ?? "-"),
                    title: Text(data?.name ?? "-"),
                    subtitle: Text(data?.phone ?? "-"),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      // body: SizedBox(
      //   width: double.infinity,
      //   child: Column(
      //     mainAxisSize: MainAxisSize.max,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text('Halo Siapa $_username'),
      //       ElevatedButton(
      //         onPressed: () {
      //           Navigator.pushAndRemoveUntil(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (_) => LoginPage(),
      //               ),
      //               (route) => false);
      //           removeToken();
      //         },
      //         child: const Text(
      //           'Logout',
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
