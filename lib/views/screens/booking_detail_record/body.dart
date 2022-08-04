import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/data/remote/response/status.dart';
import 'package:sfbms_mobile/view_model/booking_details_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/booking_detail_record/widgets/booking_detail_info_box.dart';
import 'package:sfbms_mobile/views/screens/booking_detail_record/widgets/booking_detail_status_box.dart';
import 'package:sfbms_mobile/views/screens/booking_detail_record/widgets/detail_feedback_box.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.bookingDetailID}) : super(key: key);

  final int bookingDetailID;

  @override
  Widget build(BuildContext context) {
    Provider.of<UserViewModel>(context, listen: false).idToken.then((idToken) {
      Provider.of<BookingDetailsViewModel>(context, listen: false).getBookingDetail(
        idToken: idToken,
        bookingDetailID: bookingDetailID,
      );
    });

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: Consumer<BookingDetailsViewModel>(
          builder: (context, bookingDetailsVM, child) {
            switch (bookingDetailsVM.bookingDetail.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.COMPLETED:
                return Column(children: [
                  BookingDetailInfoBox(bookingDetail: bookingDetailsVM.bookingDetail.data!),
                  BookingDetailStatusBox(
                    bookingDetailStatus: bookingDetailsVM.bookingDetail.data!.status!,
                  ),
                  DetailFeedbackBox(
                    feedbacks: bookingDetailsVM.bookingDetail.data!.feedbacks ?? [],
                    bookingDetailID: bookingDetailsVM.bookingDetail.data!.id!,
                    fieldID: bookingDetailsVM.bookingDetail.data!.fieldId!,
                    bookingDetailStatus: bookingDetailsVM.bookingDetail.data!.status!,
                  ),
                ]);
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
