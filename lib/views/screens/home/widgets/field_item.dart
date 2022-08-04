import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sfbms_mobile/data/models/booking_time.dart';
import 'package:sfbms_mobile/data/models/slot.dart';
import 'package:sfbms_mobile/utils/utils.dart';
import 'package:sfbms_mobile/views/screens/field_details/field_details_screen.dart';

class FieldItem extends StatelessWidget {
  const FieldItem({
    Key? key,
    required this.fieldID,
    required this.name,
    this.imageUrl,
    required this.availableTime,
  }) : super(key: key);

  final int fieldID;
  final String name;
  final String? imageUrl;
  final List<Slot> availableTime;

  @override
  Widget build(BuildContext context) {
    final List<BookingTime> bookingTimes = Utils.getBookingTimesBySlots(availableTime);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.of(context).pushNamed(
          FieldDetailsScreen.routeName,
          arguments: FieldDetailsScreenArguments(fieldID: fieldID),
        ),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: ExtendedImage.network(
                  imageUrl ?? "",
                  fit: BoxFit.cover,
                  cache: true,
                  enableLoadState: true,
                  height: 300,
                  width: double.infinity,
                  loadStateChanged: (ExtendedImageState state) {
                    if (state.extendedImageLoadState == LoadState.failed) {
                      return Image.network(
                        'https://inantemnhan.com.vn/wp-content/uploads/2017/10/no-image.png',
                        fit: BoxFit.cover,
                      );
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              if (bookingTimes.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Text(
                    "Available: ${bookingTimes.map((bookingTime) {
                      return toBeginningOfSentenceCase(bookingTime.name.toLowerCase())!;
                    }).join(", ")}",
                    style: const TextStyle(fontSize: 16),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
