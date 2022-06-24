import 'package:sfbms_mobile/data/models/user.dart';

abstract class UserRepository {
  Future<User> login({required String idToken});
}
