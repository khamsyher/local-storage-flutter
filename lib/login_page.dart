import 'package:flutter/material.dart';
import 'package:local_storage/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DI/service_locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final SharedPreferences prefs = getIt<SharedPreferences>();
  Future<bool> login() async {
    if (usernameController.text == 'user1' &&
        passwordController.text == '12345') {
      await prefs.setString('username', usernameController.text);
      await prefs.setString('password', passwordController.text);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.purple[200],
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    controller: usernameController, title: 'Username'),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    controller: passwordController, title: 'Password'),
                const SizedBox(
                  height: 45,
                ),
                GestureDetector(
                  onTap: () {
                    login().then((value) {
                      if (value == true) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login failed')));
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.purple[200],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Center(
                        child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.controller, required this.title});
  final TextEditingController controller;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          )),
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
