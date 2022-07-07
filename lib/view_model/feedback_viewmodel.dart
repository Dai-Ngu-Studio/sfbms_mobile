import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfbms_mobile/data/models/feedback.dart' as m_feedback;
import 'package:sfbms_mobile/data/remote/response/api_response.dart';
import 'package:sfbms_mobile/data/repository/feedback_repository_impl.dart';

class FeedbackViewModel extends ChangeNotifier {
  final _feedbackRepo = FeedbackRepositoryImpl();

  ApiResponse<List<m_feedback.Feedback>> feedbacks = ApiResponse.loading();

  void _setFields(ApiResponse<List<m_feedback.Feedback>> response) {
    log(response.toString());
    feedbacks = response;
    notifyListeners();
  }

  Future getFeedbacksByFieldID({required String idToken, required int fieldID}) async {
    try {
      _setFields(ApiResponse.loading());

      var response = await _feedbackRepo.getFeedbacksByFieldID(idToken: idToken, fieldID: fieldID);

      _setFields(ApiResponse.completed(response));
    } catch (e) {
      _setFields(ApiResponse.error(e.toString()));
      rethrow;
    }
  }

  Future postFeedback({
    required idToken,
    required m_feedback.Feedback feedback,
  }) async {
    try {
      await _feedbackRepo.postFeedback(
        idToken: idToken,
        feedback: feedback,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future updateFeedback({
    required idToken,
    required m_feedback.Feedback feedback,
  }) async {
    try {
      await _feedbackRepo.updateFeedback(
        idToken: idToken,
        feedback: feedback,
      );
    } catch (e) {
      rethrow;
    }
  }
}
