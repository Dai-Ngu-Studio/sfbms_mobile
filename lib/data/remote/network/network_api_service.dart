import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sfbms_mobile/data/remote/app_exception.dart';
import 'package:sfbms_mobile/data/remote/network/base_api_service.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getResponse(
    String url, {
    bool isOdataApi = true,
    String? function,
    required header,
  }) async {
    http.Response response;
    dynamic responseJson;

    try {
      if (isOdataApi) {
        response = await http
            .get(
              function == null
                  ? Uri.parse("$baseOdataUrl$url")
                  : Uri.parse("$baseOdataUrl$url/$function"),
              headers: header,
            )
            .timeout(const Duration(seconds: 10));
      } else {
        response = await http
            .get(
              function == null ? Uri.parse("$baseUrl$url") : Uri.parse("$baseUrl$url/$function"),
              headers: header,
            )
            .timeout(const Duration(seconds: 10));
      }

      responseJson = returnResponse(response);
    } on TimeoutException catch (_) {
      throw FetchDataException('Failed To Connect To The Server');
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future postResponse(
    String url, {
    bool isOdataApi = true,
    String? function,
    required header,
    dynamic body,
    String? odataSegment,
  }) async {
    http.Response response;
    dynamic responseJson;

    try {
      if (isOdataApi) {
        response = await http
            .post(
              function == null
                  ? Uri.parse("$baseOdataUrl$url?$odataSegment")
                  : Uri.parse("$baseOdataUrl$url/$function?$odataSegment"),
              headers: header,
              body: body,
            )
            .timeout(const Duration(seconds: 10));
      } else {
        response = await http
            .post(
              function == null ? Uri.parse("$baseUrl$url") : Uri.parse("$baseUrl$url/$function"),
              headers: header,
              body: body,
            )
            .timeout(const Duration(seconds: 10));
      }

      responseJson = returnResponse(response);
    } on TimeoutException catch (_) {
      throw FetchDataException('Failed To Connect To The Server');
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future putResponse(
    String url, {
    bool isOdataApi = true,
    required header,
    dynamic body,
  }) async {
    http.Response response;
    dynamic responseJson;

    try {
      if (isOdataApi) {
        response = await http
            .put(
              Uri.parse("$baseOdataUrl$url"),
              headers: header,
              body: body,
            )
            .timeout(const Duration(seconds: 10));
      } else {
        response = await http
            .put(
              Uri.parse("$baseUrl$url"),
              headers: header,
              body: body,
            )
            .timeout(const Duration(seconds: 10));
      }

      responseJson = returnResponse(response);
    } on TimeoutException catch (_) {
      throw FetchDataException('Failed To Connect To The Server');
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future deleteResponse(
    String url, {
    bool isOdataApi = true,
    required header,
    dynamic body,
  }) async {
    http.Response response;
    dynamic responseJson;

    try {
      if (isOdataApi) {
        response = await http
            .put(
              Uri.parse("$baseOdataUrl$url"),
              headers: header,
              body: body,
            )
            .timeout(const Duration(seconds: 10));
      } else {
        response = await http
            .put(
              Uri.parse("$baseUrl$url"),
              headers: header,
              body: body,
            )
            .timeout(const Duration(seconds: 10));
      }

      responseJson = returnResponse(response);
    } on TimeoutException catch (_) {
      throw FetchDataException('Failed To Connect To The Server');
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 201:

      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
          'Error occured while communication with server with status code : ${response.statusCode}',
        );
    }
  }
}
