import 'package:flutter/material.dart';
import 'package:revew_ui_app/widget/on_obarding_page.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _pageController;
  List<String> title = <String>[
    'First Page',
    'Second Page',
    'Third Page',
  ];

  int court = 0;
  String texxt = "Next";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Visibility(
                  // maintainAnimation: true,
                  // maintainSize: true,
                  // maintainState: true,
                  visible: court == 2,
                  replacement: TextButton(
                    onPressed: () {
                      setState(() {
                        _pageController.animateToPage(2,
                            duration: const Duration(seconds: 2),
                            curve: Curves.easeInOutBack);
                      });
                    },
                    child: const Text("Skid"),
                  ),
                  child: TextButton(
                    onPressed: () => {
                      Navigator.pushReplacementNamed(context, "/nav_screen")
                    },
                    child: const Text("Start"),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (value) {
                    setState(() {
                      court = value;
                    });
                  },
                  itemCount: title.length,
                  itemBuilder: (context, index) {
                    return OnBoardingPage(title: title[index]);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // OnBording(color: court == 0 ? Colors.orange : Colors.grey),
                  // OnBording(color: court == 1 ? Colors.orange : Colors.grey),
                  // OnBording(color: court == 2 ? Colors.orange : Colors.grey),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 6,
                    margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: court == 0 ? Colors.orange : Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 6,
                    margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: court == 1 ? Colors.orange : Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 6,
                    margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: court == 2 ? Colors.orange : Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      switch (court) {
                        case 0:
                          {
                            _pageController.animateToPage(1,
                                duration: const Duration(seconds: 2),
                                curve: Curves.easeInOut);
                          }
                          break;
                        case 1:
                          {
                            _pageController.animateToPage(2,
                                duration: const Duration(seconds: 2),
                                curve: Curves.linearToEaseOut);
                          }
                          break;
                        case 2:
                          {
                            Navigator.pushReplacementNamed(
                                context, "/nav_screen");
                          }
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(court == 2 ? 'Start' : texxt),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
