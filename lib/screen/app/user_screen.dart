import 'package:flutter/material.dart';
import 'package:revew_ui_app/api/api_controller.dart';

class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiController().getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                  leading: CircleAvatar(
                      radius: 35,
                      backgroundImage:
                          NetworkImage(snapshot.data![index].image)),
                  title: Text(snapshot.data![index].firstName),
                  subtitle: Text(snapshot.data![index].email),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ));
            },
          );
        } else {
          return const Center(
            child: Text(
              "No Data ",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          );
        }
      },
    );
  }
}
