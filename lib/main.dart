import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sfbms_mobile/constants/colors.dart';
import 'package:sfbms_mobile/data/providers/filter.dart';
import 'package:sfbms_mobile/firebase_options.dart';
import 'package:sfbms_mobile/routes.dart';
import 'package:sfbms_mobile/view_model/booking_details_viewmodel.dart';
import 'package:sfbms_mobile/view_model/booking_viewmodel.dart';
import 'package:sfbms_mobile/view_model/category_viewmodel.dart';
import 'package:sfbms_mobile/view_model/cart_viewmodel.dart';
import 'package:sfbms_mobile/view_model/feedback_viewmodel.dart';
import 'package:sfbms_mobile/view_model/field_viewmodel.dart';
import 'package:sfbms_mobile/view_model/slot_viewmodel.dart';
import 'package:sfbms_mobile/view_model/user_viewmodel.dart';
import 'package:sfbms_mobile/views/screens/home/home_screen.dart';
import 'package:sfbms_mobile/views/screens/login/login_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kReleaseMode) {
    await dotenv.load(fileName: "./env/.env");
  } else {
    await dotenv.load(fileName: "./env/development.env");
  }
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => FieldViewModel()),
        ChangeNotifierProvider(create: (_) => FeedbackViewModel()),
        ChangeNotifierProvider(create: (_) => SlotViewModel()),
        ChangeNotifierProvider(create: (_) => BookingViewModel()),
        ChangeNotifierProvider(create: (_) => BookingDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => Filter()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
      ],
      child: MaterialApp(
        title: 'SFBMS',
        theme: ThemeData(
          primarySwatch: fieldColor,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            foregroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: Selector<UserViewModel, bool>(
          selector: (context, userVM) => userVM.isAuth,
          builder: (context, isAuth, _) => isAuth ? const HomeScreen() : const LoginScreen(),
        ),
        routes: routes,
      ),
    );
  }
}
