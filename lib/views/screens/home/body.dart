import 'package:flutter/material.dart';
import 'package:sfbms_mobile/views/screens/home/widgets/field_item.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        FieldItem(),
        FieldItem(),
        FieldItem(),
      ],
    );
  }
}
