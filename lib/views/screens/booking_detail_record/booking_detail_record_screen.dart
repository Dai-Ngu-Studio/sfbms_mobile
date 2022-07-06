import 'package:flutter/material.dart';
import 'package:sfbms_mobile/views/screens/booking_detail_record/body.dart';

class BookingDetailRecordScreen extends StatelessWidget {
  const BookingDetailRecordScreen({Key? key}) : super(key: key);

  static const String routeName = "/booking-details-record";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BookingDetailRecordScreenArguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Booking Detail'), centerTitle: true),
      body: Body(bookingDetailID: args.bookingDetailID),
    );
  }
}

class BookingDetailRecordScreenArguments {
  final int bookingDetailID;

  BookingDetailRecordScreenArguments({required this.bookingDetailID});
}
