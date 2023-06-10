import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revew_ui_app/api/api_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.7);
  }

  @override
  void dispose() {
// TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 190),
          child: FutureBuilder(
            future: ApiController().getUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return PageView.builder(
                  itemCount: snapshot.data!.length,
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.network(snapshot.data![index].image,
                                fit: BoxFit.fill),
                          ),
                          Text(snapshot.data![index].firstName,
                              textAlign: TextAlign.center),
                        ],
                      ),
                    );
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                'Favorite Products',
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'see All',
                  style: GoogleFonts.ubuntu(),
                ),
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 190),
          child: FutureBuilder(
              future: ApiController().getUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 130 / 90),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsetsDirectional.only(end: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image:
                                    NetworkImage(snapshot.data![index].image),
                                fit: BoxFit.fitHeight)),
                      );
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
              }),
        ),
        const SizedBox(
          height: 20,
        ),
        GridView.builder(
          itemCount: 10,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, int index) {
            return Card(
              color: index % 2 == 0 ? Colors.red : Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        ),
      ],
    );
  }
}
