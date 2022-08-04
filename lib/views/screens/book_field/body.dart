import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/data/remote/response/status.dart';
import 'package:sfbms_mobile/view_model/field_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/book_field/widgets/book_slot_box.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.fieldID}) : super(key: key);

  final int fieldID;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<UserViewModel>(context, listen: false).idToken.then((idToken) {
        Provider.of<FieldViewModel>(context, listen: false).getField(
          idToken: idToken,
          fieldID: widget.fieldID,
        );
      });
      isInit = false;
    }
    super.didChangeDependencies();
  }

  final List<DateTime> _bookingsDates = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 1)),
    DateTime.now().add(const Duration(days: 2)),
  ];

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
              onChanged: (value) {
                setState(() => _selectedDate = value as DateTime);
                Provider.of<UserViewModel>(context, listen: false).idToken.then((idToken) {
                  Provider.of<FieldViewModel>(context, listen: false).getField(
                    idToken: idToken,
                    fieldID: widget.fieldID,
                    bookingDate: _selectedDate,
                  );
                });
              },
              onSaved: (value) => _selectedDate = value as DateTime,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Consumer<FieldViewModel>(
                builder: (context, fieldVM, child) {
                  switch (fieldVM.field.status) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.COMPLETED:
                      return Column(
                        children: [
                          BookSlotBox(
                            fieldID: fieldVM.field.data!.id!,
                            slots: fieldVM.field.data!.slots ?? [],
                          ),
                        ],
                      );
                    case Status.ERROR:
                      return const Center(child: Text('Error'));
                    default:
                      return const Center(child: Text('Error'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
