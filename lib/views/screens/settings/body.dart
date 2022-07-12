import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/gen/assets.gen.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/booking_history/booking_history_screen.dart';
import 'package:sfbms_mobile/views/screens/cart_details/cart_details_screen.dart';
import 'package:sfbms_mobile/views/screens/login/login_screen.dart';
import 'package:sfbms_mobile/views/screens/settings/widgets/setting_menu_item.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SettingMenuItem(
            text: 'Your Bookings',
            onPressed: () => Navigator.of(context).pushNamed(BookingHistoryScreen.routeName),
          ),
          SettingMenuItem(
            text: 'Your Cart',
            onPressed: () async {
              Navigator.of(context).pushNamed(CartDetailsScreen.routeName);
            },
          ),
          SettingMenuItem(
            text: 'About',
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Field',
                applicationIcon: Assets.images.logo.image(width: 75),
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2022 Field',
                routeSettings: const RouteSettings(name: 'about'),
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Field is a mobile application for booking fields that helps you to find best available fields.',
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'We believe that our app will bring players closer to digital sport ecosystem.',
                  ),
                  const SizedBox(height: 16),
                  const Text('Copyright © 2022 Field. All rights reserved.'),
                ],
              );
            },
          ),
          SettingMenuItem(
            text: 'Logout',
            onPressed: () async {
              final navigator = Navigator.of(context);
              await Provider.of<UserViewModel>(context, listen: false).logout();
              navigator.pushReplacementNamed(LoginScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
