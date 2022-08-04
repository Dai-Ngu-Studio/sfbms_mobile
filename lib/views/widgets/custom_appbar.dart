import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sfbms_mobile/constants/colors.dart';
import 'package:sfbms_mobile/data/providers/filter.dart';
import 'package:sfbms_mobile/gen/assets.gen.dart';
import 'package:sfbms_mobile/utils/debouncer.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/login/login_screen.dart';
import 'package:sfbms_mobile/views/screens/settings/settings_screen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.refreshController}) : super(key: key);

  final RefreshController refreshController;

  @override
  Widget build(BuildContext context) {
    var userVM = Provider.of<UserViewModel>(context, listen: false);
    var filter = Provider.of<Filter>(context);

    final controller = TextEditingController(text: filter.searchValue);
    final debouncer = Debouncer(milliseconds: 200);

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
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextFormField(
                        controller: controller,
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
                          contentPadding: EdgeInsets.zero,
                        ),
                        cursorHeight: 18,
                        cursorWidth: 2,
                        onFieldSubmitted: (value) {
                          if (value.trim() != "") {
                            filter.setSearchValue(value.trim());
                            refreshController.requestRefresh();
                          }
                        },
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          decorationThickness: 0.0,
                        ),
                      ),
                      InkWell(
                        onTap: () => debouncer.run(() {
                          if (filter.searchValue != '') {
                            refreshController.requestRefresh();
                          }
                          filter.setSearchValue('');
                        }),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 6.0),
                          child: Icon(Icons.clear, color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            userVM.isAuth
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
                          child: ExtendedImage.network(
                            userVM.userPhotoURL!,
                            cache: true,
                          ),
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
