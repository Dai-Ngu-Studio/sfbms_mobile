import 'package:sfbms_mobile/data/models/feedback.dart';

abstract class FeedbackRepository {
  Future postFeedback({required String idToken, required Feedback feedback});
  Future updateFeedback({required String idToken, required Feedback feedback});
}
