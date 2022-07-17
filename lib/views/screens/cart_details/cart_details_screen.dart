import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/constants/colors.dart';
import 'package:sfbms_mobile/view_model/booking_viewmodel.dart';
import 'package:sfbms_mobile/view_model/cart_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/booking_history/booking_history_screen.dart';
import 'package:sfbms_mobile/views/screens/cart_details/body.dart';
import 'package:sfbms_mobile/views/screens/home/home_screen.dart';
import 'package:sfbms_mobile/views/widgets/error_dialog.dart';

class CartDetailsScreen extends StatefulWidget {
  const CartDetailsScreen({Key? key}) : super(key: key);

  static const String routeName = "/cart-details";

  @override
  State<CartDetailsScreen> createState() => _CartDetailsScreenState();
}

class _CartDetailsScreenState extends State<CartDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart Details'), centerTitle: true),
      body: const Body(),
      floatingActionButton: Consumer<CartViewModel>(
        builder: (context, cartVM, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cartVM.itemCount > 0
                  ? InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        // book then pop bookings screen
                        Provider.of<UserViewModel>(context, listen: false).idToken.then(
                          (idToken) async {
                            try {
                              await Provider.of<BookingViewModel>(context, listen: false)
                                  .postBooking(
                                idToken: idToken,
                                cartItems: cartVM.items,
                              );

                              cartVM.clear();
                              cartVM.clearHovering();

                              if (mounted) {
                                Navigator.of(context).popUntil(
                                  ModalRoute.withName(HomeScreen.routeName),
                                );
                                Navigator.of(context).pushNamed(HomeScreen.routeName);
                                Navigator.of(context).pushNamed(BookingHistoryScreen.routeName);
                              }
                            } catch (e) {
                              showErrorDialog(
                                context: context,
                                message: "Could not create booking. Please try again.",
                              );
                            }
                          },
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width * 0.5,
                        height: 50,
                        decoration: BoxDecoration(
                          color: fieldColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 7),
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Book',
                            style: TextStyle(
                                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.width * 0.5,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 7),
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Book',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
