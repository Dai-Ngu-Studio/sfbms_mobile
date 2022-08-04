import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/constants/colors.dart';
import 'package:sfbms_mobile/view_model/cart_viewmodel.dart';
import 'package:sfbms_mobile/view_model/field_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/book_field/book_field_screen.dart';
import 'package:sfbms_mobile/views/screens/field_details/body.dart';

class FieldDetailsScreen extends StatelessWidget {
  const FieldDetailsScreen({Key? key}) : super(key: key);

  static const String routeName = '/field-details';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FieldDetailsScreenArguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Field Details')),
      body: Body(fieldID: args.fieldID),
      floatingActionButton: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.of(context)
              .pushNamed(
            BookFieldScreen.routeName,
            arguments: BookFieldScreenArguments(args.fieldID),
          )
              .then(
            (_) {
              Provider.of<UserViewModel>(context, listen: false).idToken.then(
                (idToken) {
                  Provider.of<FieldViewModel>(context, listen: false).getField(
                    idToken: idToken,
                    fieldID: args.fieldID,
                  );
                  Provider.of<CartViewModel>(context, listen: false).clearHovering();
                },
              );
            },
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 35,
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
              'Book Now',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class FieldDetailsScreenArguments {
  final int fieldID;

  FieldDetailsScreenArguments({required this.fieldID});
}
