import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/login_page.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Halo Siapa $_username'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginPage(),
                    ),
                    (route) => false);
                removeToken();
              },
              child: const Text(
                'Logout',
              ),
            )
          ],
        ),
      ),
    );
  }
}
