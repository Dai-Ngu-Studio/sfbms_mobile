import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/constants/colors.dart';
import 'package:sfbms_mobile/gen/assets.gen.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/login/login_screen.dart';
import 'package:sfbms_mobile/views/screens/search/search_screen.dart';
import 'package:sfbms_mobile/views/screens/settings/settings_screen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Container(
      color: kPrimaryColor,
      width: double.infinity,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
                child: SizedBox(
                  height: 35,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed(SearchScreen.routeName),
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        label: const Text(
                          'Search',
                          style: TextStyle(color: Colors.black45, fontSize: 14),
                        ),
                        hintStyle: const TextStyle(color: kSecondaryColor),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Assets.svgs.search.svg(
                            color: kSecondaryColor,
                            alignment: Alignment.center,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 12,
                        decorationThickness: 0.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Provider.of<UserViewModel>(context, listen: false).isAuth
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed(SettingsScreen.routeName),
                      splashColor: Colors.transparent,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
                        ),
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
