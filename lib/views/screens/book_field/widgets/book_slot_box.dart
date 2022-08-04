import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/constants/colors.dart';
import 'package:sfbms_mobile/data/models/booking_status.dart';
import 'package:sfbms_mobile/data/models/slot.dart';
import 'package:sfbms_mobile/data/models/slot_status.dart';
import 'package:sfbms_mobile/view_model/cart_viewmodel.dart';

class BookSlotBox extends StatefulWidget {
  const BookSlotBox({Key? key, required this.fieldID, required this.slots}) : super(key: key);

  final int fieldID;
  final List<Slot> slots;

  @override
  State<BookSlotBox> createState() => _BookSlotBoxState();
}

class _BookSlotBoxState extends State<BookSlotBox> {
  var selectedIndexes = [];

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
          Text('Slots', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 12),
          widget.slots.isEmpty
              ? Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        const TextSpan(text: 'No slots available. Click '),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {},
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
                        const TextSpan(text: ' to see more slots.'),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: widget.slots.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ChoiceChip(
                        backgroundColor: Colors.white,
                        disabledColor: Colors.grey.withOpacity(.4),
                        selectedColor: fieldColor,
                        side: widget.slots[index].bookingStatus == BookingStatus.AVAILABLE.index &&
                                widget.slots[index].status == SlotStatus.OPEN.index &&
                                DateTime.parse(widget.slots[index].startTime!)
                                    .subtract(const Duration(hours: 7))
                                    .toUtc()
                                    .isAfter(DateTime.now().toUtc())
                            ? const BorderSide(color: Colors.black26)
                            : BorderSide(color: Colors.grey.withOpacity(.2)),
                        label: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "${index + 1}       "
                            "${DateFormat("HH:mm").format(DateTime.parse(widget.slots[index].startTime!))} - "
                            "${DateFormat("HH:mm").format(DateTime.parse(widget.slots[index].endTime!))}",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        selected: selectedIndexes.contains(index),
                        shadowColor: Colors.white,
                        pressElevation: 0,
                        elevation: 0,
                        onSelected: widget.slots[index].bookingStatus ==
                                    BookingStatus.AVAILABLE.index &&
                                widget.slots[index].status == SlotStatus.OPEN.index &&
                                DateTime.parse(widget.slots[index].startTime!)
                                    .subtract(const Duration(hours: 7))
                                    .toUtc()
                                    .isAfter(DateTime.now().toUtc())
                            ? !Provider.of<CartViewModel>(context, listen: false).containsItem(
                                id: widget.slots[index].id!,
                                startTime: widget.slots[index].startTime!,
                              )
                                ? (selected) {
                                    setState(() {
                                      if (selected) {
                                        selectedIndexes.add(index);
                                      } else {
                                        selectedIndexes.remove(index);
                                      }
                                    });
                                    var cartVM = Provider.of<CartViewModel>(context, listen: false);
                                    if (selected) {
                                      cartVM.addHoveringItem(
                                        id: widget.slots[index].id!,
                                        fieldId: widget.slots[index].fieldId!,
                                        fieldName: widget.slots[index].field!.name!,
                                        startTime: widget.slots[index].startTime!,
                                        endTime: widget.slots[index].endTime!,
                                        slotNumber: widget.slots[index].slotNumber!,
                                      );
                                    } else {
                                      cartVM.removeHoveringItem(
                                        id: widget.slots[index].id!,
                                        startTime: widget.slots[index].startTime!,
                                      );
                                    }
                                  }
                                : null
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
