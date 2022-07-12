// ignore_for_file: constant_identifier_names
enum BookingDetailStatus { NOTYET, OPEN, ATTENDED, ABSENT }

class BookingDetailStatusMap {
  static final Map<int, String> _statusMap = {
    BookingDetailStatus.NOTYET.index: "Not yet",
    BookingDetailStatus.OPEN.index: "Currently Open",
    BookingDetailStatus.ATTENDED.index: "Attended",
    BookingDetailStatus.ABSENT.index: "Absent",
  };

  static Map<int, String> get statusMap => {..._statusMap};
}
