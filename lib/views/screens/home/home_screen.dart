import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sfbms_mobile/views/screens/home/body.dart';
import 'package:sfbms_mobile/views/widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: true);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: CustomAppBar(refreshController: refreshController),
      ),
      body: Body(refreshController: refreshController),
    );
  }
}
