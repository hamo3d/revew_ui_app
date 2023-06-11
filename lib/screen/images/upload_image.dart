import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revew_ui_app/api/image_get_controller.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  double? _progressValue = 0;
  late ImagePicker _imagePicker;
  XFile? _pickedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: _progressValue,
            color: Colors.green.shade500,
            minHeight: 6,
            backgroundColor: Colors.green.shade100,
          ),
          Expanded(
            child: _pickedImage != null
                ? Image.file(
              File(_pickedImage!.path),
              width: double.infinity,
            )
                : IconButton(
              icon: Icon(Icons.camera_alt, size: 56),
              onPressed: () {
                _pickImage();
              },
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 45),
            ),
            onPressed: () => _performUpload(),
            icon: Icon(Icons.cloud_upload),
            label: Text("Upload"),
          )
        ],
      ),
    );
  }

  void _pickImage() async {
    try {
      // XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _pickedImage = image;
        });
      }
    } catch (e) {
      print('حدث خطأ أثناء اختيار الصورة: $e');
    }
  }

  void _performUpload() async {
    if (_checkData()) {
      _uploadImage();
    }
  }

  bool _checkData() {
    if (_pickedImage != null) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Picked Image to upload "),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
    return false;
  }

  void _uploadImage() async {
    setState(() => _progressValue = null);
    ImageGetController controller = Get.find();
    bool result = await controller.upload(_pickedImage!.path);
    setState(() {
      _progressValue = result ? 1 : 0;
      if (result) _pickedImage = null;
    });
  }
}