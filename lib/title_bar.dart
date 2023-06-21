import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:reservasi/app_colors.dart';
import 'package:reservasi/app_styles.dart';
import 'package:reservasi/navigation_helper.dart';

var buttonColors = WindowButtonColors(
  iconNormal: AppColors.darkGreyColor,
  mouseOver: AppColors.textColor.withOpacity(.25),
  mouseDown: AppColors.textColor.withOpacity(.50),
  iconMouseOver: AppColors.whiteColor,
  iconMouseDown: AppColors.whiteColor,
);

var closeButtonColors = WindowButtonColors(
  iconNormal: AppColors.darkGreyColor,
  mouseOver: AppColors.mainColor,
  mouseDown: AppColors.lightColor,
  iconMouseOver: AppColors.whiteColor,
  iconMouseDown: AppColors.whiteColor,
);

class TitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WindowTitleBarBox(
          child: Row(
            children: [
              Expanded(
                child: MoveWindow(
                  child: Row(
                    children: [
                      Text(
                        '    Baron (Barak Online)',
                        textAlign: TextAlign.center,
                        style: textStyle.copyWith(
                          fontSize: 15.0,
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  MinimizeWindowButton(
                    colors: buttonColors,
                  ),
                  // MaximizeWindowButton(
                  //   colors: buttonColors,
                  // ),
                  CloseWindowButton(
                    colors: closeButtonColors,
                    onPressed: () {
                      NavigationHelper.exitApplication(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HalfLeftTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WindowTitleBarBox(
          child: MoveWindow(),
          // child: Text('test'),
        ),
      ],
    );
  }
}

class HalfRightTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WindowTitleBarBox(
          child: Row(
            children: [
              Expanded(
                child: MoveWindow(),
              ),
              Row(
                children: [
                  MinimizeWindowButton(
                    colors: buttonColors,
                  ),
                  // MaximizeWindowButton(
                  //   colors: buttonColors,
                  //   onPressed: () {},
                  // ),
                  CloseWindowButton(
                    colors: closeButtonColors,
                    onPressed: () {
                      NavigationHelper.exitApplication(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
