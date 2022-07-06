import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sfbms_mobile/constants/colors.dart';
import 'package:sfbms_mobile/data/models/slot.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.fieldID}) : super(key: key);

  final int fieldID;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Slot>? _slots;

  final List<DateTime> _bookingsDates = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 1)),
    DateTime.now().add(const Duration(days: 2)),
  ];

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();
  int _selectedSlotID = -1;

  @override
  void initState() {
    // TODO: Get all slots for the field
    // _slots!.sort((a, b) => a.startTime!.compareTo(b.startTime!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              prefixIcon: const Icon(Icons.calendar_today, color: Colors.black87, size: 22),
            ),
            isExpanded: true,
            hint: Text(
              "${(DateTime.now().day == (_selectedDate.subtract(const Duration(hours: 7)).day)) ? 'Today' : ''}"
              "${DateFormat("${(DateTime.now().day == (_selectedDate.subtract(const Duration(hours: 7)).day)) ? '' : 'EEEE'} (dd/MM)").format(_selectedDate)}",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black87),
            iconSize: 30,
            buttonHeight: 60,
            buttonWidth: double.infinity,
            buttonPadding: const EdgeInsets.only(right: 20),
            dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            items: _bookingsDates.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  "${(DateTime.now().day == (item.subtract(const Duration(hours: 7)).day)) ? 'Today' : ''}"
                  "${DateFormat("${(DateTime.now().day == (item.subtract(const Duration(hours: 7)).day)) ? '' : 'EEEE'} (dd/MM)").format(item)}",
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: (value) => setState(() => _selectedDate = value as DateTime),
            onSaved: (value) => _selectedDate = value as DateTime,
          ),
          const SizedBox(height: 12),
          ListView.builder(
            itemCount: 1,
            // itemCount: _slots!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ChoiceChip(
                  backgroundColor: Colors.white,
                  disabledColor: Colors.grey.withOpacity(.4),
                  selectedColor: fieldColor,
                  // side: _slots![index].status! == SlotStatus.available
                  //     ? const BorderSide(color: Colors.black38)
                  //     : const BorderSide(color: Colors.grey),
                  label: Text('placeholder'),
                  // label: SizedBox(
                  //   width: double.infinity,
                  //   child: Text(
                  //     "${index + 1}       ${DateFormat("HH:mm").format(DateTime.parse(_slots![index].startTime!))} - ${DateFormat("HH:mm").format(DateTime.parse(_slots![index].endTime!))}",
                  //     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  selected: true,
                  // selected: selectedTime == DateTime.parse(_slots![index].startTime!),
                  // onSelected: _slots![index].status! == SlotStatus.available
                  //     ? (selected) {
                  //         setState(() {
                  //           selectedTime = DateTime.parse(_slots![index].startTime!);
                  //           selectedSlotID = _slots![index].id!;
                  //         });
                  //       }
                  //     : null,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
