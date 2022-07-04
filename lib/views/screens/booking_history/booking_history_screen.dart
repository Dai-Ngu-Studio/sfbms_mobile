import 'package:flutter/material.dart';
import 'package:sfbms_mobile/views/screens/booking_history/body.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({Key? key}) : super(key: key);

  static const String routeName = "/bookingHistory";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Bookings'),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
