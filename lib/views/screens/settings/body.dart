import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/constants/shared_prefs.dart';
import 'package:sfbms_mobile/data/local/shared_prefs_helper.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/booking_history/booking_history_screen.dart';
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
