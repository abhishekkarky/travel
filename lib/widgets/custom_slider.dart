import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_controller.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomerSliderBody();
  }
}

class CustomerSliderBody extends StatefulWidget {
  CustomerSliderBody({Key? key}) : super(key: key);

  @override
  State<CustomerSliderBody> createState() => _CustomerSliderBodyState();
}

class _CustomerSliderBodyState extends State<CustomerSliderBody> {
  int activeIndex = 0;
  final controller = CarouselController();
  final urlImages = [
    'assets/images/b1.png',
    'assets/images/b2.jpeg',
    'assets/images/b3.jpeg',
  ];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
              carouselController: controller,
              itemCount: urlImages.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = urlImages[index];
                return buildImage(urlImage, index);
              },
              options: CarouselOptions(
                  height: 150,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(seconds: 3),
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index))),
          const SizedBox(height: 12),
          buildIndicator()
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
    onDotClicked: animateToSlide,
    effect: const ExpandingDotsEffect(
        dotWidth: 8, dotHeight: 8, activeDotColor: Colors.lightBlueAccent),
    activeIndex: activeIndex,
    count: urlImages.length,
  );

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 3.0),
  child: Image.asset(urlImage, fit: BoxFit.cover),
);
