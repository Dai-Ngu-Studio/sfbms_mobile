import 'package:flutter/material.dart';
import 'package:sfbms_mobile/views/screens/home/body.dart';
import 'package:sfbms_mobile/views/widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(),
      ),
      body: Body(),
    );
  }
}
