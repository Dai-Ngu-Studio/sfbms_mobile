import 'package:sfbms_mobile/data/models/feedback.dart';

abstract class FeedbackRepository {
  Future<List<Feedback>> getFeedbacksByFieldID({required String idToken, required int fieldID});

  Future postFeedback({required String idToken, required Feedback feedback});
  Future updateFeedback({required String idToken, required Feedback feedback});
}
