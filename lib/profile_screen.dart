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

class ProfileScreen extends StatelessWidget {
  final Pelanggan pelanggan;

  ProfileScreen({required this.pelanggan});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Uint8List? imageData;
    if (pelanggan.profileImage != "") {
      imageData = base64Decode(pelanggan.profileImage);
    }

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
                            child: SidebarMenu(activePage: "profile"),
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
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Profil",
                            style: textStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: imageData == null
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      )
                                    : BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: MemoryImage(imageData),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                // color: AppColors.mainColor,
                                child: imageData == null
                                    ? SvgPicture.asset(
                                        AppAssets.person,
                                        fit: BoxFit.cover,
                                        color: AppColors.darkGreyColor,
                                      )
                                    : Text(""),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pelanggan.nama,
                                    style: textStyle.copyWith(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(0, -12),
                                    child: Text(
                                      "Mahasiswa",
                                      style: textStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 12),
                          Container(
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
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: SizedBox(
                                  width: 515,
                                  height: 257,
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Program Studi",
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          height: 30,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.lightGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: TextField(
                                            enabled: false,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              labelText: pelanggan.prodi,
                                              labelStyle: textStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "Jurusan",
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          height: 30,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.lightGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: TextField(
                                            enabled: false,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              labelText: pelanggan.jurusan,
                                              labelStyle: textStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'No. Telepon',
                                                  style: textStyle.copyWith(
                                                    fontSize: 16,
                                                    color: AppColors.textColor,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Container(
                                                  width: 225,
                                                  height: 30,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .lightGreyColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: TextField(
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      labelText:
                                                          pelanggan.telepon,
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
                                                )
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Email',
                                                  style: textStyle.copyWith(
                                                    fontSize: 16,
                                                    color: AppColors.textColor,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Container(
                                                  width: 225,
                                                  height: 30,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .lightGreyColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: TextField(
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      labelText:
                                                          pelanggan.email,
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
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
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
