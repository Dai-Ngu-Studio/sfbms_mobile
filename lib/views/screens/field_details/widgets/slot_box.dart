import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sfbms_mobile/constants/colors.dart';
import 'package:sfbms_mobile/data/models/booking_status.dart';
import 'package:sfbms_mobile/data/models/slot.dart';
import 'package:sfbms_mobile/data/models/slot_status.dart';
import 'package:sfbms_mobile/views/screens/book_field/book_field_screen.dart';

class SlotBox extends StatelessWidget {
  const SlotBox({Key? key, required this.slots, required this.fieldID}) : super(key: key);

  final int fieldID;
  final List<Slot> slots;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(
            height: 40,
            indent: mediaQuery.size.width * 0.2,
            endIndent: mediaQuery.size.width * 0.2,
            thickness: 1,
            color: Colors.black12,
          ),
          Text('Slots Today', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 12),
          slots.isEmpty
              ? Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        const TextSpan(text: 'There is no slot today. Click '),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                              BookFieldScreen.routeName,
                              arguments: BookFieldScreenArguments(fieldID),
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: const Text(
                              'here',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const TextSpan(text: ' to see more slot.'),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: slots.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ChoiceChip(
                        backgroundColor: Colors.white,
                        disabledColor: Colors.grey.withOpacity(.4),
                        selectedColor: fieldColor,
                        side: slots[index].bookingStatus == BookingStatus.AVAILABLE.index &&
                                slots[index].status == SlotStatus.OPEN.index &&
                                DateTime.parse(slots[index].startTime!)
                                    .subtract(const Duration(hours: 7))
                                    .toUtc()
                                    .isAfter(DateTime.now().toUtc())
                            ? const BorderSide(color: Colors.black26)
                            : BorderSide(color: Colors.grey.withOpacity(.2)),
                        label: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "${index + 1}       "
                            "${DateFormat("HH:mm").format(DateTime.parse(slots[index].startTime!))} - "
                            "${DateFormat("HH:mm").format(DateTime.parse(slots[index].endTime!))}",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        selected: false,
                        shadowColor: Colors.white,
                        pressElevation: 0,
                        elevation: 0,
                        onSelected: slots[index].bookingStatus == BookingStatus.AVAILABLE.index &&
                                slots[index].status == SlotStatus.OPEN.index &&
                                DateTime.parse(slots[index].startTime!)
                                    .subtract(const Duration(hours: 7))
                                    .toUtc()
                                    .isAfter(DateTime.now().toUtc())
                            ? (selected) {}
                            : null,
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
