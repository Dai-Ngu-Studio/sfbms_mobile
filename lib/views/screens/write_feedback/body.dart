import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/constants/colors.dart';
import 'package:sfbms_mobile/data/models/feedback.dart' as m_feedback;
import 'package:sfbms_mobile/view_model/feedback_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/booking_detail_record/booking_detail_record_screen.dart';
import 'package:sfbms_mobile/views/screens/booking_record/booking_record_screen.dart';
import 'package:sfbms_mobile/views/widgets/error_dialog.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.feedback,
    required this.bookingDetailID,
    required this.fieldID,
  }) : super(key: key);

  final m_feedback.Feedback? feedback;
  final int bookingDetailID;
  final int fieldID;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  int selectedRating = 0;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.feedback?.title ?? "";
    contentController.text = widget.feedback?.content ?? "";
    selectedRating = widget.feedback?.rating ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          RatingBar.builder(
            initialRating: widget.feedback?.rating?.toDouble() ?? 5,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) => selectedRating = rating.toInt(),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: contentController,
              decoration: InputDecoration(
                hintText: 'Content',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: MediaQuery.of(context).size.width - 35,
                height: 50,
                decoration: BoxDecoration(
                  color: fieldColor,
                  borderRadius: BorderRadius.circular(8),
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
                    'Post Feedback',
                    style:
                        TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                Provider.of<UserViewModel>(context, listen: false).idToken.then(
                  (idToken) async {
                    try {
                      if (titleController.text.isEmpty || contentController.text.isEmpty) {
                        showErrorDialog(
                          context: context,
                          message: "Title/content must not be empty.",
                        );
                      } else {
                        if (widget.feedback == null) {
                          await Provider.of<FeedbackViewModel>(context, listen: false).postFeedback(
                            idToken: idToken,
                            feedback: m_feedback.Feedback(
                              id: 0,
                              fieldId: widget.fieldID,
                              bookingDetailId: widget.bookingDetailID,
                              title: titleController.text,
                              content: contentController.text,
                              rating: selectedRating,
                            ),
                          );
                        } else {
                          await Provider.of<FeedbackViewModel>(context, listen: false)
                              .updateFeedback(
                            idToken: idToken,
                            feedback: m_feedback.Feedback(
                              id: widget.feedback?.id,
                              title: titleController.text,
                              content: contentController.text,
                              rating: selectedRating,
                            ),
                          );
                        }

                        if (mounted) {
                          Navigator.of(context).popUntil(
                            ModalRoute.withName(BookingRecordScreen.routeName),
                          );
                          Navigator.of(context).pushNamed(
                            BookingDetailRecordScreen.routeName,
                            arguments: BookingDetailRecordScreenArguments(
                              bookingDetailID: widget.bookingDetailID,
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      showErrorDialog(
                        context: context,
                        message: "Could not post feedback. Please try again.",
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
