import 'dart:convert';
import 'dart:io';

import 'package:revew_ui_app/api/api_setting.dart';
import 'package:http/http.dart' as http;
import 'package:revew_ui_app/prefs/prefs_controller.dart';
import 'package:revew_ui_app/screen/model/student_image.dart';

/// Requests
/// upload
/// read
/// delete

class ImagesApiController {
  Future<StudentImage?> upload(String path) async {
    Uri uri = Uri.parse(ApiSetting.images.replaceFirst('/{id}', ""));
    var request = http.MultipartRequest("POST", uri);
    var file = await http.MultipartFile.fromPath("image", path);
    request.files.add(file);
    request.headers[HttpHeaders.acceptHeader] = "application/json";
    request.headers[HttpHeaders.authorizationHeader] = SharedPrefController().getValue(PrefKeys.token)!;
    var response = await request.send();
    if (response.statusCode == 201) {
      String body = await response.stream.transform(utf8.decoder).first;
      var jsonResponse = jsonDecode(body);
      var imageObject = StudentImage.fromJson(jsonResponse['object']);
      return imageObject;
    }
    return null;
  }

  Future<List<StudentImage>> read() async {
    Uri uri = Uri.parse(ApiSetting.images.replaceFirst('/{id}', ""));
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader:
          SharedPrefController().getValue<String>(PrefKeys.token)!
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var dataJsonArray = jsonResponse["data"] as List;
      return dataJsonArray.map((json) => StudentImage.fromJson(json)).toList();
    }
    return [];
  }

  Future<bool> delete(int id) async {
    Uri uri = Uri.parse(ApiSetting.images.replaceFirst("{id}", id.toString()));
    var response = await http.delete(uri, headers: {
      HttpHeaders.authorizationHeader:
          SharedPrefController().getValue<String>(PrefKeys.token)!
    });
    return response.statusCode == 200;
  }
}
