import 'package:flutter/material.dart';
import 'package:sfbms_mobile/views/screens/login/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Body());
  }
}
