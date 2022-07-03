import 'package:sfbms_mobile/data/models/slot.dart';

abstract class SlotRepository {
  Future<List<Slot>> getSlotsByFieldID({required String idToken, required int fieldID});
}
