// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

enum BookingDetailStatus { NOTYET, OPEN, ATTENDED, ABSENT }

class BookingDetailStatusMap {
  static final Map<int, String> _statusMap = {
    BookingDetailStatus.NOTYET.index: "Not yet",
    BookingDetailStatus.OPEN.index: "Currently Open",
    BookingDetailStatus.ATTENDED.index: "Attended",
    BookingDetailStatus.ABSENT.index: "Absent",
  };

  static final Map<int, Color> _colorMap = {
    BookingDetailStatus.NOTYET.index: Colors.transparent,
    BookingDetailStatus.OPEN.index: const Color.fromARGB(255, 255, 239, 170),
    BookingDetailStatus.ATTENDED.index: const Color.fromARGB(255, 209, 255, 182),
    BookingDetailStatus.ABSENT.index: const Color.fromARGB(255, 255, 176, 176),
  };

  static Map<int, String> get statusMap => {..._statusMap};
  static Map<int, Color> get colorMap => {..._colorMap};
}
