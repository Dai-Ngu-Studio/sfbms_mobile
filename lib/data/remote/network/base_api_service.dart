import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class BaseApiService {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final String baseOdataUrl = dotenv.env['BASE_ODATA_URL']!;

  Future<dynamic> getResponse(
    String url, {
    bool isOdataApi = true,
    String? function,
    required header,
  });

  Future<dynamic> postResponse(
    String url, {
    bool isOdataApi = true,
    String? function,
    required header,
    dynamic body,
  });

  Future<dynamic> putResponse(
    String url, {
    bool isOdataApi = true,
    required header,
    dynamic body,
  });

  Future<dynamic> deleteResponse(
    String url, {
    bool isOdataApi = true,
    required header,
    dynamic body,
  });
}
