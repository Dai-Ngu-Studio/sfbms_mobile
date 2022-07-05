import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/data/models/field.dart';
import 'package:sfbms_mobile/data/remote/response/status.dart';
import 'package:sfbms_mobile/view_model/field_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/field_details/widgets/field_info_box.dart';
import 'package:sfbms_mobile/views/screens/field_details/widgets/slot_box.dart';
import 'package:sfbms_mobile/views/screens/field_details/widgets/feedback_box.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.fieldID}) : super(key: key);

  final int fieldID;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void didChangeDependencies() {
    Provider.of<UserViewModel>(context, listen: false).idToken.then((idToken) {
      Provider.of<FieldViewModel>(context, listen: false).getField(
        idToken: idToken,
        fieldID: widget.fieldID,
      );
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Consumer<FieldViewModel>(
          builder: (context, fieldVM, child) {
            switch (fieldVM.field.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.COMPLETED:
                return Column(
                  children: [
                    FieldInfoBox(
                      field: Field(
                        id: fieldVM.field.data!.id,
                        imageUrl: fieldVM.field.data!.imageUrl,
                        name: fieldVM.field.data!.name,
                        totalRating: fieldVM.field.data!.totalRating,
                        description: fieldVM.field.data!.description,
                      ),
                    ),
                    SlotBox(
                      fieldID: fieldVM.field.data!.id!,
                      slots: fieldVM.field.data!.slots ?? [],
                    ),
                    FeedbackBox(feedbacks: fieldVM.field.data!.feedbacks ?? []),
                  ],
                );
              case Status.ERROR:
                return const Center(child: Text('Error'));
              default:
                return const Center(child: Text('Error'));
            }
          },
        ),
      ),
    );
  }
}
