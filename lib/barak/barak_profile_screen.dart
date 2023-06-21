import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reservasi/app_colors.dart';
import 'package:reservasi/app_styles.dart';
import 'package:reservasi/component.dart';
import 'package:reservasi/main.dart';
import 'package:reservasi/model.dart';
import 'package:reservasi/app_assets.dart';
import 'package:reservasi/navigation_helper.dart';
import 'package:reservasi/title_bar.dart';

class BarakProfileScreen extends StatelessWidget {
  final Penjual penjual;

  BarakProfileScreen({required this.penjual});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                            child: BarakSidebarMenu(activePage: "profile"),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  penjual.nama,
                                  style: textStyle.copyWith(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(0, -10),
                                  child: Text(
                                    MyApp.getIDR(int.parse(penjual.saldo)),
                                    style: textStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          Stack(
                            children: [
                              Align(
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
                                      filter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        width: 495,
                                        height: 300,
                                        padding: EdgeInsets.only(
                                          top: 30,
                                          bottom: 15,
                                          left: 15,
                                          right: 15,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Pemilik",
                                                style: textStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                height: 30,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.lightGreyColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: TextField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: penjual.pemilik,
                                                    labelStyle:
                                                        textStyle.copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.textColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                "No. Telepon Seluler",
                                                style: textStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                height: 30,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.lightGreyColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: TextField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: penjual.noTelp,
                                                    labelStyle:
                                                        textStyle.copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.textColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                "Alamat",
                                                style: textStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                height: 30,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.lightGreyColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: TextField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: penjual.alamat,
                                                    labelStyle:
                                                        textStyle.copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.textColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                "No. Rekening BRI",
                                                style: textStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                height: 30,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.lightGreyColor,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: TextField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: penjual.rekBri,
                                                    labelStyle:
                                                        textStyle.copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.textColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 300,
                                padding: EdgeInsets.only(top: 10),
                                alignment: Alignment.topRight,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    NavigationHelper.navigateToEditBarakProfile(
                                        context, penjual);
                                  },
                                  elevation: 0,
                                  fillColor: Colors.white,
                                  shape: CircleBorder(
                                    side: BorderSide(
                                      color: AppColors.greyColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.edit,
                                    width: 18,
                                    height: 18,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BaronButton(
                                  text: 'Ganti Kata Sandi',
                                  color: AppColors.secondaryColor,
                                  callback: () async {
                                    NavigationHelper.navigateToChangePassword(
                                        context);
                                  },
                                  buttonWidth: 206,
                                ),
                                BaronButton(
                                  text: 'Keluar',
                                  color: AppColors.dangerColor,
                                  callback: () async {
                                    NavigationHelper.logOut(context);
                                  },
                                  buttonWidth: 100,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
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
