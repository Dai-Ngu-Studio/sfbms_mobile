import 'package:flutter/material.dart';
import 'package:sfbms_mobile/views/screens/booking_record/body.dart';

class BookingRecordScreen extends StatelessWidget {
  const BookingRecordScreen({Key? key}) : super(key: key);

  static const String routeName = "/bookingRecord";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BookingRecordScreenArguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Booking Information')),
      body: Body(bookingID: args.bookingID),
    );
  }
}

class BookingRecordScreenArguments {
  final int bookingID;

  BookingRecordScreenArguments({required this.bookingID});
}
