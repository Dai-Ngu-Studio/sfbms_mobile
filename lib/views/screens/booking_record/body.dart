import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sfbms_mobile/view_model/booking_details_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/booking_record/widgets/booking_record_item.dart';
import 'package:sfbms_mobile/views/widgets/error_dialog.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.bookingID,
  }) : super(key: key);

  final int bookingID;

  Future<bool?> _onRefresh({
    bool isRefresh = false,
    required BookingDetailsViewModel bookingDetailsVM,
    required UserViewModel userVM,
  }) async {
    var result = await bookingDetailsVM.getBooking(
      idToken: (await userVM.idToken)!,
      isRefresh: isRefresh,
      bookingID: bookingID,
    );

    if (result == null) return null;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController(initialRefresh: true);

    return Consumer2<UserViewModel, BookingDetailsViewModel>(
      builder: ((context, userVM, bookingDetailsVM, _) {
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: refreshController,
          onRefresh: () async {
            try {
              refreshController.resetNoData();
              var result = await _onRefresh(
                isRefresh: true,
                bookingDetailsVM: bookingDetailsVM,
                userVM: userVM,
              );

              if (result!) {
                refreshController.refreshCompleted();
              } else {
                refreshController.refreshFailed();
              }
            } catch (e) {
              showErrorDialog(context: context, message: e.toString());
              refreshController.refreshFailed();
            }
          },
          onLoading: bookingDetailsVM.booking.data?.bookingDetails?.isEmpty ?? true
              ? refreshController.loadNoData
              : () async {
                  try {
                    final result =
                        await _onRefresh(bookingDetailsVM: bookingDetailsVM, userVM: userVM);

                    if (result == null) {
                      refreshController.loadNoData();
                    } else if (result) {
                      refreshController.loadComplete();
                    } else {
                      refreshController.loadFailed();
                    }
                  } catch (e) {
                    showErrorDialog(context: context, message: e.toString());
                    refreshController.loadFailed();
                  }
                },
          header: const WaterDropHeader(),
          footer: const ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
            completeDuration: Duration(milliseconds: 500),
          ),
          child: (bookingDetailsVM.booking.data?.bookingDetails?.isEmpty ?? true)
              ? const Center(
                  child: Text("No booking details found.", style: TextStyle(fontSize: 20)))
              : ListView.builder(
                  itemCount: bookingDetailsVM.booking.data?.bookingDetails?.length ?? 0,
                  itemBuilder: (context, index) {
                    return BookingRecordItem(
                      bookingDetail: (bookingDetailsVM.booking.data?.bookingDetails![index])!,
                    );
                  }),
        );
      }),
    );
  }
}
