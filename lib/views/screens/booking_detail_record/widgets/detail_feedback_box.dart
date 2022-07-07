import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/data/models/feedback.dart' as m_feedback;
import 'package:sfbms_mobile/view_model/booking_details_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/booking_detail_record/widgets/detail_feedback_item.dart';
import 'package:sfbms_mobile/views/screens/write_feedback/write_feedback_screen.dart';

class DetailFeedbackBox extends StatelessWidget {
  const DetailFeedbackBox({
    Key? key,
    required this.feedbacks,
    required this.bookingDetailID,
    required this.fieldID,
  }) : super(key: key);

  final List<m_feedback.Feedback?> feedbacks;
  final int bookingDetailID;
  final int fieldID;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(
            height: 40,
            indent: mediaQuery.size.width * 0.2,
            endIndent: mediaQuery.size.width * 0.2,
            thickness: 1,
            color: Colors.black12,
          ),
          Text('Your Feedback', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 12),
          InkWell(
            child: feedbacks.isEmpty
                ? Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 35,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                        child: Text('Tap here to start writing.'),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: feedbacks.length,
                    itemBuilder: (context, index) {
                      return DetailFeedbackItem(feedback: feedbacks[index]!);
                    },
                  ),
            onTap: () => Navigator.of(context)
                .pushNamed(
                  WriteFeedbackScreen.routeName,
                  arguments: WriteFeedbackScreenArguments(
                    feedback: feedbacks.isNotEmpty ? feedbacks.first : null,
                    bookingDetailID: bookingDetailID,
                    fieldID: fieldID,
                  ),
                )
                .then(
                  (_) => Provider.of<UserViewModel>(context, listen: false).idToken.then(
                    (idToken) {
                      Provider.of<BookingDetailsViewModel>(context, listen: false).getBookingDetail(
                        idToken: idToken,
                        bookingDetailID: bookingDetailID,
                      );
                    },
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
