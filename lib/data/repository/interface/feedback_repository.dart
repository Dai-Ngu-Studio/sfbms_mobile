import 'package:sfbms_mobile/data/models/feedback.dart';

abstract class FeedbackRepository {
  Future<List<Feedback>> getFeedbacksByFieldID({required String idToken, required int fieldID});
}
