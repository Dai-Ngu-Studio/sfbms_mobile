import 'package:flutter/material.dart';
import 'package:sfbms_mobile/data/models/booking_details_status.dart';

class BookingDetailStatusBox extends StatelessWidget {
  const BookingDetailStatusBox({
    Key? key,
    required this.bookingDetailStatus,
  }) : super(key: key);

  final int bookingDetailStatus;

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
          Text('Status', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 12),
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width - 35,
              decoration: BoxDecoration(
                color: BookingDetailStatusMap.colorMap[bookingDetailStatus],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black26, width: 1.5),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      BookingDetailStatusMap.statusMap[bookingDetailStatus]!,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
