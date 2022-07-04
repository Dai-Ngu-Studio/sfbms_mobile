import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/constants/colors.dart';
import 'package:sfbms_mobile/data/models/booking_status.dart';
import 'package:sfbms_mobile/data/models/slot_status.dart';
import 'package:sfbms_mobile/data/remote/response/status.dart';
import 'package:sfbms_mobile/view_model/slot_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';

class SlotBox extends StatefulWidget {
  const SlotBox({Key? key, required this.fieldID}) : super(key: key);

  final int fieldID;

  @override
  State<SlotBox> createState() => _SlotBoxState();
}

class _SlotBoxState extends State<SlotBox> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    var slotVM = Provider.of<SlotViewModel>(context, listen: false);
    if (isInit) {
      Provider.of<UserViewModel>(context, listen: false).idToken.then((idToken) {
        slotVM.getSlotsByFieldID(idToken: idToken!, fieldID: widget.fieldID).whenComplete(() {
          if (slotVM.slots.data != null) {
            slotVM.slots.data!.sort((a, b) => a.startTime!.compareTo(b.startTime!));
          }
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

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
          Consumer<SlotViewModel>(
            builder: (context, slotVM, child) {
              switch (slotVM.slots.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.COMPLETED:
                  if (slotVM.slots.data?.isEmpty ?? false) {
                    return Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                            const TextSpan(text: 'There is no slot today. Click '),
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
                            const TextSpan(text: ' to see more slot.'),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: slotVM.slots.data?.length ?? 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ChoiceChip(
                          backgroundColor: Colors.white,
                          disabledColor: Colors.grey.withOpacity(.4),
                          selectedColor: fieldColor,
                          side: slotVM.slots.data![index].bookingStatus ==
                                      BookingDetailStatus.NOTYET.index &&
                                  slotVM.slots.data![index].status == SlotStatus.AVAILABLE.index &&
                                  DateTime.parse(slotVM.slots.data![index].startTime!)
                                      .subtract(const Duration(hours: 7))
                                      .toUtc()
                                      .isAfter(DateTime.now().toUtc())
                              ? const BorderSide(color: Colors.black26)
                              : BorderSide(color: Colors.grey.withOpacity(.2)),
                          label: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "${index + 1}       "
                              "${DateFormat("HH:mm").format(DateTime.parse(slotVM.slots.data![index].startTime!))} - "
                              "${DateFormat("HH:mm").format(DateTime.parse(slotVM.slots.data![index].endTime!))}",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          selected: false,
                          shadowColor: Colors.white,
                          pressElevation: 0,
                          elevation: 0,
                          onSelected: slotVM.slots.data![index].bookingStatus ==
                                      BookingDetailStatus.NOTYET.index &&
                                  slotVM.slots.data![index].status == SlotStatus.AVAILABLE.index &&
                                  DateTime.parse(slotVM.slots.data![index].startTime!)
                                      .subtract(const Duration(hours: 7))
                                      .toUtc()
                                      .isAfter(DateTime.now().toUtc())
                              ? (selected) {}
                              : null,
                        ),
                      );
                    },
                  );
                case Status.ERROR:
                  return const Center(child: Text('Error fetching data'));
                default:
                  return const Center(child: Text('No slot yet'));
              }
            },
          ),
        ],
      ),
    );
  }
}
