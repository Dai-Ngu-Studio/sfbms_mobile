import 'package:flutter/material.dart';
import 'package:sfbms_mobile/views/screens/field_details/widgets/field_info_box.dart';
import 'package:sfbms_mobile/views/screens/field_details/widgets/slot_box.dart';
import 'package:sfbms_mobile/views/screens/field_details/widgets/feedback_box.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.fieldID}) : super(key: key);

  final int fieldID;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Column(
          children: [
            FieldInfoBox(fieldID: fieldID),
            SlotBox(fieldID: fieldID),
            FeedbackBox(fieldID: fieldID),
          ],
        ),
      ),
    );
  }
}
