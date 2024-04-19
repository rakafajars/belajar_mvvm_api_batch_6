import 'package:belajar_api_movie/model/request_login_model.dart';
import 'package:belajar_api_movie/page/home/home_page.dart';
import 'package:belajar_api_movie/model/service/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoadingLogin = false;

  final TextEditingController _usernameController = TextEditingController(
    text: "mor_2314",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "83r5^_",
  );

  void postLogin() async {
    _isLoadingLogin = true;
    setState(() {});

    try {
      await AuthService.postLogin(
        requestLoginModel: RequestLoginModel(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(e.toString()),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } finally {
      _isLoadingLogin = false;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Page",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(height: 24),
            if (_isLoadingLogin) ...[
              const CircularProgressIndicator(),
            ] else ...[
              ElevatedButton(
                onPressed: () {
                  postLogin();
                },
                child: const Text(
                  'Login',
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
