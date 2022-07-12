import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sfbms_mobile/data/models/booking_details.dart';
import 'package:sfbms_mobile/views/screens/booking_detail_record/booking_detail_record_screen.dart';

class BookingRecordItem extends StatelessWidget {
  const BookingRecordItem({
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
        onTap: () => Navigator.of(context).pushNamed(
          BookingDetailRecordScreen.routeName,
          arguments: BookingDetailRecordScreenArguments(
            bookingDetailID: bookingDetail.id!,
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width - 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black26, width: 1.5),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  bookingDetail.field!.name!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  "${DateFormat("MMMM d, yyyy | ").format(DateTime.parse(bookingDetail.startTime!))}"
                  "${DateFormat("HH:mm").format(DateTime.parse(bookingDetail.startTime!))} - "
                  "${DateFormat("HH:mm").format(DateTime.parse(bookingDetail.endTime!))}",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
