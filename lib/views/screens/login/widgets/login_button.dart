import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/gen/assets.gen.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/home/home_screen.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ElevatedButton(
          onPressed: _isLoading
              ? null
              : () async {
                  final navigator = Navigator.of(context);
                  bool isLoginSuccess = false;

                  try {
                    setState(() => _isLoading = true);

                    isLoginSuccess = await Provider.of<UserViewModel>(
                      context,
                      listen: false,
                    ).login();

                    if (isLoginSuccess) {
                      navigator.pushReplacementNamed(HomeScreen.routeName);
                    }

                    setState(() => _isLoading = false);
                  } catch (e) {
                    setState(() => _isLoading = false);
                    _showErrorDialog(e.toString());
                  }
                },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(14),
            primary: Colors.white,
            onPrimary: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            side: const BorderSide(color: Colors.black12),
            splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.svgs.google.svg(height: 30),
              const SizedBox(width: 10),
              const Text(
                "Sign in with Google",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        if (_isLoading)
          Container(
            width: double.infinity,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white.withOpacity(.6),
            ),
            child: const Center(child: CircularProgressIndicator()),
          )
      ],
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
