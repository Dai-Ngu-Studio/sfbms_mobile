import 'package:flutter/material.dart';
import 'package:sfbms_mobile/views/screens/book_field/book_field_screen.dart';
import 'package:sfbms_mobile/views/screens/booking_detail_record/booking_detail_record_screen.dart';
import 'package:sfbms_mobile/views/screens/booking_history/booking_history_screen.dart';
import 'package:sfbms_mobile/views/screens/booking_record/booking_record_screen.dart';
import 'package:sfbms_mobile/views/screens/cart_details/cart_details_screen.dart';
import 'package:sfbms_mobile/views/screens/field_details/field_details_screen.dart';
import 'package:sfbms_mobile/views/screens/home/home_screen.dart';
import 'package:sfbms_mobile/views/screens/login/login_screen.dart';
import 'package:sfbms_mobile/views/screens/settings/settings_screen.dart';
import 'package:sfbms_mobile/views/screens/write_feedback/write_feedback_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  SettingsScreen.routeName: (context) => const SettingsScreen(),
  FieldDetailsScreen.routeName: (context) => const FieldDetailsScreen(),
  BookingHistoryScreen.routeName: (context) => const BookingHistoryScreen(),
  BookingRecordScreen.routeName: (context) => const BookingRecordScreen(),
  BookingDetailRecordScreen.routeName: (context) => const BookingDetailRecordScreen(),
  BookFieldScreen.routeName: (context) => const BookFieldScreen(),
  WriteFeedbackScreen.routeName: (context) => const WriteFeedbackScreen(),
  CartDetailsScreen.routeName: (context) => const CartDetailsScreen(),
};
