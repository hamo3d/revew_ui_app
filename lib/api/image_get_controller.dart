import 'package:get/get.dart';
import 'package:revew_ui_app/screen/model/student_image.dart';

import 'image_api_controller.dart';

class ImageGetController extends GetxController {
  final ImagesApiController _apiController = ImagesApiController();
  bool loading = false;
  List<StudentImage> images = <StudentImage>[];

  @override
  void onInit() {
    // TODO: implement onInit
    read();
    super.onInit();
  }

  Future<bool> upload(String path) async {
    StudentImage? image = await _apiController.upload(path);
    if (image != null) {
      print("Success");
      images.add(image);
      update();
      return true;
    }
    return false;
  }

  void read() async {
    loading = true;
    images = await _apiController.read();
    loading = false;
    print(images.length);
    update();
  }

  Future<bool> delete(int id) async {
    bool result = await _apiController.delete(id);
    if (result) {
      images.removeWhere((element) => element.id == id);
      update();
    }
    return result;
  }
}
