import 'package:flutter/material.dart';
import 'package:sfbms_mobile/data/models/feedback.dart' as m_feedback;
import 'package:sfbms_mobile/views/screens/write_feedback/body.dart';

class WriteFeedbackScreen extends StatelessWidget {
  const WriteFeedbackScreen({Key? key}) : super(key: key);

  static const String routeName = "/write-feedback";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WriteFeedbackScreenArguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Feedback'), centerTitle: true),
      body: Body(
        feedback: args.feedback,
        bookingDetailID: args.bookingDetailID,
        fieldID: args.fieldID,
      ),
    );
  }
}

class WriteFeedbackScreenArguments {
  final m_feedback.Feedback? feedback;
  final int bookingDetailID;
  final int fieldID;

  WriteFeedbackScreenArguments({
    required this.feedback,
    required this.bookingDetailID,
    required this.fieldID,
  });
}
