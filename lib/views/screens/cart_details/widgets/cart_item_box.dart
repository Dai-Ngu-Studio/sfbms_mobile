import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/view_model/cart_viewmodel.dart';

class CartItemBox extends StatelessWidget {
  const CartItemBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cartVM, child) {
        var slots = cartVM.items.entries.map((x) => x.value).toList();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text('Selected Slots', style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 6),
              if (slots.isNotEmpty)
                Text('Swipe left to remove slot', style: Theme.of(context).textTheme.caption),
              const SizedBox(height: 12),
              slots.isEmpty
                  ? const Center(child: Text('No slots have been added to cart.'))
                  : ListView.builder(
                      itemCount: slots.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Dismissible(
                          background: Container(
                            color: Theme.of(context).errorColor,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.delete, color: Colors.white, size: 40),
                          ),
                          direction: DismissDirection.endToStart,
                          key: Key(slots[index].cartItemId!),
                          onDismissed: (direction) {
                            cartVM.removeItem(cartItemId: slots[index].cartItemId!);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
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
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
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
