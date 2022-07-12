import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/view_model/cart_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/cart_details/widgets/cart_item_box.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: Consumer<CartViewModel>(
        builder: (context, cartVM, child) {
          return Column(
            children: const [
              CartItemBox(),
            ],
          );
        },
      ),
    );
  }
}
