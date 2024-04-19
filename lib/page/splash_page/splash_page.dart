import 'package:belajar_api_movie/page/home/home_page.dart';
import 'package:belajar_api_movie/page/login/login_page.dart';
import 'package:belajar_api_movie/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void checkToken() async {
    final token = await SharedPref.getToken();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (token != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    checkToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.flutter_dash,
          size: 100,
        ),
      ),
    );
  }
}
