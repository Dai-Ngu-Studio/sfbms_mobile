import 'package:flutter/material.dart';
import 'package:sfbms_mobile/data/models/feedback.dart' as m_feedback;

class DetailFeedbackItem extends StatelessWidget {
  const DetailFeedbackItem({Key? key, required this.feedback}) : super(key: key);

  final m_feedback.Feedback feedback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      title: Text(feedback.title!, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(feedback.content!),
      trailing: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: feedback.rating!.toString(),
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const TextSpan(
              text: '/5 ',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const WidgetSpan(child: Icon(Icons.star, color: Colors.yellow, size: 20)),
          ],
        ),
      ),
    );
  }
}
