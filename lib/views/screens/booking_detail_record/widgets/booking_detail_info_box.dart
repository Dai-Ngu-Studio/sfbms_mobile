import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sfbms_mobile/data/models/booking_details.dart';

class BookingDetailInfoBox extends StatelessWidget {
  const BookingDetailInfoBox({
    Key? key,
    required this.bookingDetail,
  }) : super(key: key);

  final BookingDetail bookingDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
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
                bookingDetail.field!.name!,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              Text(
                DateFormat("MMMM d, yyyy")
                    .format(DateTime.parse(bookingDetail.startTime!).toLocal()),
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              Text(
                "${DateFormat("hh:mm a").format(DateTime.parse(bookingDetail.startTime!).toLocal())} - ${DateFormat("hh:mm a").format(DateTime.parse(bookingDetail.endTime!).toLocal())}",
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
