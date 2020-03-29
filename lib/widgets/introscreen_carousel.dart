import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopkart_frontend/utilities/constants.dart';

final List<String> imgList = [
  'assets/images/shop1.jpg',
  'assets/images/shop1.jpg',
  'assets/images/shop1.jpg',
];

final List<String> textList = [
  'Experience shopping with us. We let you shop, the way you want.',
  'This is the second text line of the intro screen for 2nd photo.',
  'Here comes the third photo for the carousel',
];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        CarouselSlider(
          viewportFraction: 1.0,
          items: map<Widget>(
            imgList,
            (index, i) {
              return Container(
                width: screenWidth - 84,
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        i,
                        fit: BoxFit.cover,
                        width: screenWidth - 84,
                        height: screenHeight / 2,
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8.0),
                          child: CarouselText(
                            text: textList[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
          autoPlay: true,
          autoPlayInterval: Duration(
            seconds: 5,
          ),
          autoPlayAnimationDuration: Duration(
            milliseconds: 1600,
          ),
          height: screenHeight / 2,
          pauseAutoPlayOnTouch: Duration(
            seconds: 2,
          ),
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(
            imgList,
            (index, url) {
              return Container(
                width: _current==index? 32.0 : 20.0,
                height: 3.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color:
                      _current == index ? Color(0xFF1BBC9B) : Color(0xFF707070),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselWithIndicator();
  }
}

class CarouselText extends StatelessWidget {
  CarouselText({
    this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        text,
        style: kButtonTextStyle,
        textAlign: TextAlign.left,
      ),
    );
  }
}
