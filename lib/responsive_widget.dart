import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 1080;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1440;
  }

  static bool isMediumScreen(BuildContext context) {
    // return MediaQuery.of(context).size.width >= 640 &&
    //     MediaQuery.of(context).size.width <= 960;
    return MediaQuery.of(context).size.width <= 1440 &&
        MediaQuery.of(context).size.width >= 1080;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1440) {
          return largeScreen;
        } else if (constraints.maxWidth < 1080) {
          return smallScreen ?? largeScreen;
        } else {
          return mediumScreen ?? largeScreen;
        }
      },
    );
  }
}
