import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/constants/colors.dart';
import 'package:sfbms_mobile/view_model/cart_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/book_field/body.dart';
import 'package:sfbms_mobile/views/screens/cart_details/cart_details_screen.dart';

class BookFieldScreen extends StatelessWidget {
  const BookFieldScreen({Key? key}) : super(key: key);

  static const String routeName = '/book-field';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BookFieldScreenArguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Field'), centerTitle: true),
      body: Body(fieldID: args.fieldID),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              var cartVM = Provider.of<CartViewModel>(context, listen: false);
              cartVM.addItems();
              Provider.of<CartViewModel>(context, listen: false).clearHovering();
              Navigator.of(context).popAndPushNamed(CartDetailsScreen.routeName);
            },
            child: Container(
              width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * 0.5,
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
                  'Add to Cart',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CartDetailsScreen.routeName);
            },
            tooltip: 'Cart',
            child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class BookFieldScreenArguments {
  final int fieldID;

  BookFieldScreenArguments(this.fieldID);
}
