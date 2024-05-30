import 'package:belajar/login.dart';
import 'package:flutter/material.dart';

class OnboardModel {
  final String image;
  final String title;
  final String description;

  OnboardModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnboardModel> onboard_data = [
  OnboardModel(
    image: "images/kamera.jpeg",
    title: "Rumah Rental Camera",
    description:
        "Raih pengalaman fotografi tanpa batas dengan perentalan kamera kami!",
  ),
  OnboardModel(
    image: "images/lensa2.jpeg",
    title: "Rumah Rental Camera",
    description:
        "Tingkatkan kreativitas fotografi Anda dengan koleksi kamera terbaik kami!",
  ),
  OnboardModel(
    image: "images/aksesoris.jpeg",
    title: "Rumah Rental Camera",
    description:
        "Abadikan momen berharga Anda dengan kualitas gambar yang luar biasa! Sewa kamera kami sekarang!",
  ),
];

class OnboardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                image,
                width: 270,
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 99, 98, 98),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _indexPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     // Handle skipping onboarding
                  //   },
                  //   child: const Text(
                  //     "Skip",
                  //     style: TextStyle(
                  //       color: Colors.orange,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w400,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _indexPage = index;
                  });
                },
                itemCount: onboard_data.length,
                controller: _pageController,
                itemBuilder: (context, index) => OnboardingContent(
                  image: onboard_data[index].image,
                  title: onboard_data[index].title,
                  description: onboard_data[index].description,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  onboard_data.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: DotIndicator(
                      isActive: index == _indexPage,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40),
              child: InkWell(
                onTap: () {
                  if (_indexPage == onboard_data.length - 1) {
                    // Navigasi ke halaman login jika di halaman terakhir
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LoginPage(), // Ganti dengan nama halaman login Anda
                      ),
                    );
                  } else {
                    // Pindah ke halaman berikutnya jika bukan halaman terakhir
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromARGB(255, 157, 42, 34),
                  ),
                  child: Center(
                    child: Text(
                      _indexPage == onboard_data.length - 1
                          ? "Get Started"
                          : "Next",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 85,
            ),
          ],
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({Key? key, this.isActive = false}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: isActive ? Colors.red : Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
