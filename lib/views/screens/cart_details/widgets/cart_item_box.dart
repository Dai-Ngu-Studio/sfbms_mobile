import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/view_model/cart_viewmodel.dart';

class CartItemBox extends StatefulWidget {
  const CartItemBox({
    Key? key,
  }) : super(key: key);

  @override
  State<CartItemBox> createState() => _CartItemBoxState();
}

class _CartItemBoxState extends State<CartItemBox> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cartVM, child) {
        var slots = cartVM.items.entries.map((x) => x.value).toList();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Text('Selected Slots', style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 6),
              Text('Swipe a slot to remove it', style: Theme.of(context).textTheme.caption),
              const SizedBox(height: 12),
              slots.isEmpty
                  ? Center(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: 'No slots have been added to cart.'),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: slots.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Dismissible(
                          background: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          key: Key(slots[index].cartItemId!),
                          onDismissed: (direction) {
                            Provider.of<CartViewModel>(context, listen: false)
                                .removeItem(cartItemId: slots[index].cartItemId!);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.black26, width: 1.5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                                        child: Text(
                                          "${slots[index].fieldName}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                                        child: Text(
                                          "${DateFormat("MMMM d, yyyy | ").format(DateTime.parse(slots[index].startTime!))}"
                                          "${DateFormat("HH:mm").format(DateTime.parse(slots[index].startTime!))} - "
                                          "${DateFormat("HH:mm").format(DateTime.parse(slots[index].endTime!))}",
                                          style: const TextStyle(
                                              fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}
