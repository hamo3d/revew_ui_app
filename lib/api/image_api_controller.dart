import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:revew_ui_app/api/api_setting.dart';
import 'package:http/http.dart' as http;
import 'package:revew_ui_app/prefs/prefs_controller.dart';
import 'package:revew_ui_app/screen/model/student_image.dart';

/// Requests
/// upload
/// read
/// delete


class ImagesApiController {
  Future<void> upload(String path) async {
    Uri uri =  Uri.parse(ApiSetting.images.replaceFirst("/{id}}", path));


  }

  Future<List<StudentImage>> read() async {
    Uri uri =  Uri.parse(ApiSetting.images.replaceFirst("/{id}}", ""));
    var response = await http.get(uri,headers:{HttpHeaders.authorizationHeader:SharedPrefController().getValue<String>(PrefKeys.token)!});

    if(response.statusCode == 200){
      var jsonResponse  = jsonDecode(response.body);
      var dataJsonArray =  jsonResponse["data"] as List ;
      return  dataJsonArray.map((json) => StudentImage.fromJson(json)).toList();
    }
    return [];
  }

  Future<bool> delete(int id) async {
    Uri uri =  Uri.parse(ApiSetting.images.replaceFirst("{id}}", id.toString()));

    var response =  await http.delete(uri,headers: {HttpHeaders.authorizationHeader:SharedPrefController().getValue<String>(PrefKeys.token)!});
    return response.statusCode == 200;

  }
}


