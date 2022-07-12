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
      child: Column(
        children: [
          Divider(
            height: 40,
            indent: MediaQuery.of(context).size.width * 0.2,
            endIndent: MediaQuery.of(context).size.width * 0.2,
            thickness: 1,
            color: Colors.black12,
          ),
          Text('Booking', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 12),
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              // push to field details page
            },
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
        ],
      ),
    );
  }
}
