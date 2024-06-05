import 'package:flutter/material.dart';
import 'package:local_storage/DI/service_locator.dart';
import 'package:local_storage/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SharedPreferences prefs = getIt<SharedPreferences>();
  String username = '';
  @override
  void initState() {
    username = prefs.getString('username') ?? 'None';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 26),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello, $username',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  prefs.clear().then((_) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage())));
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
