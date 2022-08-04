import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sfbms_mobile/gen/assets.gen.dart';
import 'package:sfbms_mobile/views/screens/login/widgets/login_button.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: mediaQuery.height * 0.8,
          decoration: BoxDecoration(
            image: DecorationImage(image: Assets.images.loginBackground, fit: BoxFit.cover),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.0))),
          ),
        ),
        SizedBox(
          height: mediaQuery.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
                child: const Text(
                  'Welcome',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
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
          margin: EdgeInsets.only(top: mediaQuery.height * 0.75),
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
            children: const [
              Text(
                'More than 10,000 people are using Field',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black38),
              ),
              LoginButton(),
            ],
          ),
        ),
      ],
    );
  }
}
