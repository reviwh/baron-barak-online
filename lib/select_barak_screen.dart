import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reservasi/app_assets.dart';
import 'package:reservasi/app_colors.dart';
import 'package:reservasi/app_styles.dart';
import 'package:reservasi/component.dart';
import 'package:reservasi/title_bar.dart';

class SelectBarakScreen extends StatelessWidget {
  final data;
  @override
  SelectBarakScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: WindowBorder(
        width: 2,
        color: AppColors.mainColor,
        child: SizedBox(
          width: width,
          height: height,
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: AppColors.mainColor,
                  child: Column(
                    children: [
                      HalfLeftTitleBar(),
                      Column(
                        children: [
                          SizedBox(
                            height: height * .04,
                          ),
                          SizedBox(
                            width: 130,
                            height: 60,
                            child: Align(
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                AppAssets.logo,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SidebarMenu(activePage: "menu"),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
            Expanded(
              flex: 3,
              child: Container(
                height: height,
                color: AppColors.whiteColor,
                child: Column(
                  children: [
                    HalfRightTitleBar(),
                    SizedBox(height: height * .04),
                    Container(
                      height: 435,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          childAspectRatio: 27 / 10,
                        ),
                        itemCount: data.length,
                        // padding: EdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return Container(
                            width: 216,
                            height: 80,
                            child: GridTile(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [BarakList(data: item)],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
