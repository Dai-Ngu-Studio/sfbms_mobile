import 'dart:convert';
import 'dart:developer';

import 'package:sfbms_mobile/data/models/feedback.dart';
import 'package:sfbms_mobile/data/remote/network/api_end_point.dart';
import 'package:sfbms_mobile/data/remote/network/network_api_service.dart';
import 'package:sfbms_mobile/data/repository/interface/feedback_repository.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final _apiService = NetworkApiService();

  @override
  Future<List<Feedback>> getFeedbacksByFieldID({
    required String idToken,
    required int fieldID,
  }) async {
    dynamic response = await _apiService.getResponse(
      "${ApiEndPoint().feedback}?\$filter=fieldId eq $fieldID&\$expand=User",
      header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
    );

    log('FeedbackRepositoryImpl :: getFeedbacksByFieldID :: response: $response');

    var listFeedback = <Feedback>[];

    for (var feedback in response["value"]) {
      listFeedback.add(Feedback.fromJson(feedback));
    }

    return listFeedback;
  }

  @override
  Future<Feedback> postFeedback({
    required String idToken,
    required Feedback feedback,
  }) async {
    dynamic response = await _apiService.postResponse(
      ApiEndPoint().feedback,
      header: Map<String, String>.from({
        "Authorization": "Bearer $idToken",
        "Content-Type": "application/json",
      }),
      body: json.encode(feedback),
    );

    log('FeedbackRepositoryImpl :: postFeedback :: response: $response');

    return Feedback.fromJson(response);
  }

  @override
  Future updateFeedback({
    required String idToken,
    required Feedback feedback,
  }) async {
    dynamic response = await _apiService.putResponse(
      "${ApiEndPoint().feedback}/${feedback.id}",
      header: Map<String, String>.from({
        "Authorization": "Bearer $idToken",
        "Content-Type": "application/json",
      }),
      body: json.encode(feedback),
    );

    log('FeedbackRepositoryImpl :: updateFeedback :: response: $response');

    return response;
  }
}
