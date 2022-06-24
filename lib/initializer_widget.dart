import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/constants/shared_prefs.dart';
import 'package:sfbms_mobile/data/local/shared_prefs_helper.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/home/home_screen.dart';
import 'package:sfbms_mobile/views/screens/login/login_screen.dart';

class InitializerWidget extends StatelessWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  Future<String?> _iSkipLogin() async {
    return await SharedPrefsHelper.get(key: skipLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userVM, _) {
        return FutureBuilder(
          future: _iSkipLogin(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(child: CircularProgressIndicator()),
                );
              case ConnectionState.done:
                return snapshot.hasData
                    ? const HomeScreen()
                    : userVM.isAuth
                        ? const HomeScreen()
                        : const LoginScreen();
              default:
                return const LoginScreen();
            }
          },
        );
      },
    );
  }
}
