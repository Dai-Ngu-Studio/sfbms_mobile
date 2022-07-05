import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingRecordItem extends StatelessWidget {
  const BookingRecordItem({
    Key? key,
    required this.bookingDetailID,
    required this.fieldName,
    required this.startTime,
    required this.endTime,
    required this.bookingDetailStatus,
  }) : super(key: key);

  final int bookingDetailID;
  final String fieldName;
  final String startTime;
  final String endTime;
  final int bookingDetailStatus;

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
                fieldName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              Text(
                DateFormat("MMMM d, yyyy").format(DateTime.parse(startTime).toLocal()),
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              Text(
                "${DateFormat("hh:mm a").format(DateTime.parse(startTime).toLocal())} - ${DateFormat("hh:mm a").format(DateTime.parse(endTime).toLocal())}",
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
