import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingHistoryItem extends StatelessWidget {
  const BookingHistoryItem({
    Key? key,
    required this.bookingID,
    required this.bookingDate,
    required this.numberOfFields,
  }) : super(key: key);

  final int bookingID;
  final String bookingDate;
  final int numberOfFields;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => {},
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Booked on ${DateFormat("MMMM d, yyyy - hh:mm a").format(DateTime.parse(bookingDate).toLocal())}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              Text("${numberOfFields.toString()} sports field(s)",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}
