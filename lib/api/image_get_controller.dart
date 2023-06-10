import 'package:get/get.dart';
import 'package:revew_ui_app/screen/model/student_image.dart';

import 'image_api_controller.dart';

class ImageGetController extends GetxController {

  final ImagesApiController _apiController  = ImagesApiController();

  List<StudentImage> _images = <StudentImage> [];

  @override
  void onInit() {
    // TODO: implement onInit
    read();
    super.onInit();
  }

  Future <void> upload () async {

  }

  void read ()async {
    _images = await _apiController.read();
    update();
  }

  Future<bool> delete (int id) async {
    bool result  = await _apiController.delete(id);


    if(result){
      _images.removeWhere((element) => element.id == id);
      update();
    }
    return result;
  }


}