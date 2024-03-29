import 'package:flutter/material.dart';
import 'package:sfbms_mobile/data/models/feedback.dart' as m_feedback;
import 'package:sfbms_mobile/views/screens/field_details/widgets/feedback_item.dart';

class FeedbackBox extends StatelessWidget {
  const FeedbackBox({Key? key, required this.feedbacks}) : super(key: key);

  final List<m_feedback.Feedback> feedbacks;

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
          Text('Feedback', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 12),
          feedbacks.isEmpty
              ? const Center(child: Text('No feedback yet'))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: feedbacks.length,
                  itemBuilder: (context, index) {
                    return FeedbackItem(feedback: feedbacks[index]);
                  },
                ),
        ],
      ),
    );
  }
}
