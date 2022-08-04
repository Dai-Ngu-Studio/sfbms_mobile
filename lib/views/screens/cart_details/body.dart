import 'package:flutter/material.dart';
import 'package:sfbms_mobile/views/screens/cart_details/widgets/cart_item_box.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 70.0),
      child: SingleChildScrollView(child: CartItemBox()),
    );
  }
}
