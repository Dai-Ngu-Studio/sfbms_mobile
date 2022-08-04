import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sfbms_mobile/view_model/cart_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/cart_details/cart_details_screen.dart';
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
      floatingActionButton: FloatingActionButton(
        tooltip: 'Cart',
        onPressed: () => Navigator.of(context).pushNamed(CartDetailsScreen.routeName),
        child: Badge(
          badgeContent: Selector<CartViewModel, int>(
            selector: (context, cartVM) => cartVM.itemCount,
            builder: (context, itemCount, _) {
              return Text(
                itemCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          badgeColor: Colors.deepOrangeAccent,
          elevation: 0,
          child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
        ),
      ),
    );
  }
}
