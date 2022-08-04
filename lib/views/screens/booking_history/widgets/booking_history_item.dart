import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sfbms_mobile/data/models/booking_details.dart';
import 'package:sfbms_mobile/data/models/booking_details_status.dart';
import 'package:sfbms_mobile/views/screens/booking_record/booking_record_screen.dart';

class BookingHistoryItem extends StatelessWidget {
  const BookingHistoryItem({
    Key? key,
    required this.bookingID,
    required this.bookingDate,
    required this.numberOfFields,
    required this.bookingDetails,
  }) : super(key: key);

  final int bookingID;
  final String bookingDate;
  final int numberOfFields;
  final List<BookingDetail> bookingDetails;

  @override
  Widget build(BuildContext context) {
    var isNotYet = bookingDetails.every(
      (x) => x.status == BookingDetailStatus.NOTYET.index,
    );
    var isFinished = bookingDetails.every(
      (x) =>
          x.status == BookingDetailStatus.ATTENDED.index ||
          x.status == BookingDetailStatus.ABSENT.index,
    );

    var text = isNotYet
        ? "Not yet"
        : isFinished
            ? "Closed"
            : "Unfinished";

    Text statusText = Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.of(context).pushNamed(
            BookingRecordScreen.routeName,
            arguments: BookingRecordScreenArguments(bookingID: bookingID),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black26, width: 1),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  "Booked on ${DateFormat("MMMM d, yyyy | HH:mm ").format(DateTime.parse(bookingDate))}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: statusText,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  "${numberOfFields.toString()} sports field(s)",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
