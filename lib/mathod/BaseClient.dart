import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:usermechanic/mathod/App_exception.dart';
class BaseClient{
  static const int TIME_OUT_DURATION = 60;
  String? token;

  Future<dynamic> post(String url, dynamic body)async
  {
    var uri=Uri.parse(url);
    var payload=body;
    try {
      var response=await http.post(uri,
          headers:   {
            'x-api-key': 'api@carmachanic.com',
          },
          body: payload).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }


  Future<dynamic> get(String url, [Map<String, dynamic>? bodyRequest])async
  {
    var uri=Uri.parse(url);
    try {
      var response=await http.get(uri,
        headers:   {
          'x-api-key': 'api@carmachanic.com',
        },
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }
  Future<dynamic> profileUpdate(String path,var bodyreq,String url )async
  {
    var uri=Uri.parse(url);
    try {
      var request = await http.MultipartRequest("POST", uri);
      if(path.isNotEmpty) request.files.add(await http.MultipartFile.fromPath('profile',path));
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key': 'api@carmachanic.com'});
      var res = await request.send();
      var response=await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  Future<dynamic> BookingService(var bodyreq,String url,String Vin,String Id, )async
  {
    var uri=Uri.parse(url);
    try {
      var request = await http.MultipartRequest("POST", uri);
        print("fddgf $Vin");
      if(Vin.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('vin_no_pic', Vin));
        request.files.add(await http.MultipartFile.fromPath('id_prove', Id));
          }
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key': 'api@carmachanic.com'});
      var res = await request.send();
      var response=await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }

  Future<dynamic> Documents(String path,var bodyreq,String url)async
  {
    var uri=Uri.parse(url);
    try {
      var request = await http.MultipartRequest("POST", uri);
      if(path.isNotEmpty) request.files.add(await http.MultipartFile.fromPath('id_prove',path));
      request.fields.addAll(bodyreq);
      request.headers.addAll({'x-api-key': 'api@carmachanic.com'});
      var res = await request.send();
      var response=await http.Response.fromStream(res);
      return response.body;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    }
  }
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException('Error occurred with code : ${response.statusCode}', response.request!.url.toString());
    }
  }
}