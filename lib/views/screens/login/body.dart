import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/constants/shared_prefs.dart';
import 'package:sfbms_mobile/data/local/shared_prefs_helper.dart';
import 'package:sfbms_mobile/gen/assets.gen.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/home/home_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

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

    return Stack(
      children: [
        Container(
          height: mediaQuery.height * 0.65,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.loginBackground,
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
        ),
        SizedBox(
          height: mediaQuery.height * 0.65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
                child: const Text(
                  'Welcome',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 30, top: 10),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      const TextSpan(text: 'To'),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Assets.images.logoFull.image(height: 50),
                        ),
                        alignment: PlaceholderAlignment.middle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: mediaQuery.height * 0.6),
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'More than 10,000 people are using Field',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black38,
                ),
              ),
              RepaintBoundary(
                child: Stack(
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

                                setState(() => _isLoading = false);
                              } catch (e) {
                                _showErrorDialog(e.toString());
                              } finally {
                                if (isLoginSuccess) {
                                  navigator.pushReplacementNamed(HomeScreen.routeName);
                                }
                                setState(() => _isLoading = false);
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
                ),
              ),
              InkWell(
                onTap: () {
                  SharedPrefsHelper.set(key: skipLogin, value: 'true');
                  Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                },
                child: const Text(
                  'Continue as a guest',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.5,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
