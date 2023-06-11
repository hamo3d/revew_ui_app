import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/image_get_controller.dart';

class ImagesScreen extends StatelessWidget {
  ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Images"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/upload_screen"),
        child: const Icon(Icons.camera),
      ),
      body: GetBuilder<ImageGetController>(
        init: ImageGetController(),
        global: true,
        builder: (ImageGetController controller) {
          if (controller.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.images.isNotEmpty) {
            return GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: controller.images.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Image.network(
                        controller.images[index].imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.black45,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  controller.images[index].image,
                                  style: TextStyle(color: Colors.white),
                                )),
                                IconButton(
                                  onPressed: () {
                                    controller
                                        .delete(controller.images[index].id);
                                  },
                                  icon: const Icon(
                                     Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("No Data"),
            );
          }
        },
      ),
    );
  }
}
