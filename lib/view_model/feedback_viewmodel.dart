import 'package:flutter/material.dart';
import 'package:sfbms_mobile/data/models/feedback.dart' as m_feedback;
import 'package:sfbms_mobile/data/repository/feedback_repository_impl.dart';

class FeedbackViewModel extends ChangeNotifier {
  final _feedbackRepo = FeedbackRepositoryImpl();

  Future postFeedback({required idToken, required m_feedback.Feedback feedback}) async {
    try {
      await _feedbackRepo.postFeedback(idToken: idToken, feedback: feedback);
    } catch (e) {
      rethrow;
    }
  }

  Future updateFeedback({required idToken, required m_feedback.Feedback feedback}) async {
    try {
      await _feedbackRepo.updateFeedback(idToken: idToken, feedback: feedback);
    } catch (e) {
      rethrow;
    }
  }
}
