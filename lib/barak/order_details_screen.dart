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
import 'package:reservasi/model.dart';
import 'package:reservasi/title_bar.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // Uint8List imageData = base64Decode(data.image);

    return Scaffold(
        body: WindowBorder(
      width: 2,
      color: AppColors.mainColor,
      child: SizedBox(
        width: width,
        height: height,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: AppColors.mainColor,
                  child: Column(
                    children: [
                      HalfLeftTitleBar(),
                      Column(
                        children: [
                          SizedBox(height: height * .04),
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
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: BarakSidebarMenu(activePage: "cart"),
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
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyColor,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: 484,
                              height: 436,
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Rincian Pesanan",
                                      style: textStyle.copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Text(
                                          "Meja",
                                          style:
                                              textStyle.copyWith(fontSize: 14),
                                        ),
                                      ),
                                      Text(
                                        ": ${order.idMeja}",
                                        style: textStyle.copyWith(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Text(
                                          "Hari/Tanggal",
                                          style:
                                              textStyle.copyWith(fontSize: 14),
                                        ),
                                      ),
                                      Text(
                                        ": ${order.tanggal}",
                                        style: textStyle.copyWith(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Text(
                                          "Pemesan",
                                          style:
                                              textStyle.copyWith(fontSize: 14),
                                        ),
                                      ),
                                      Text(
                                        ": ${order.nama}",
                                        style: textStyle.copyWith(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  SingleChildScrollView(
                                    child: Container(
                                      height: 213,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: order.menus.length,
                                        itemExtent: 24,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: OrderList(
                                              data: order.menus[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style: textStyle.copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        order.total,
                                        style: textStyle.copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
