import 'package:flutter/material.dart';
import 'package:sfbms_mobile/views/screens/book_field/body.dart';

class BookFieldScreen extends StatelessWidget {
  const BookFieldScreen({Key? key}) : super(key: key);

  static const String routeName = '/book-field';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BookFieldScreenArguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Field'), centerTitle: true),
      body: Body(fieldID: args.fieldID),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Cart',
        child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
      ),
    );
  }
}

class BookFieldScreenArguments {
  final int fieldID;

  BookFieldScreenArguments(this.fieldID);
}