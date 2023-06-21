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

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  bool oldPasswordObscure = true;
  bool newPasswordObscure = true;
  bool confirmNewPasswordObscure = true;

  void toggleVisibility(bool obscureText) {
    setState(() {
      obscureText = !obscureText;
    });
  }

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
                            child: MyApp.user.kategori == 1
                                ? SidebarMenu(activePage: "profile")
                                : BarakSidebarMenu(activePage: "profile"),
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
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Ganti Kata Sandi",
                            style: textStyle.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30),
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
                                          "Kata Sandi Lama",
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: AppColors.lightGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 380,
                                                padding: EdgeInsets.all(10),
                                                child: TextField(
                                                  controller:
                                                      oldPasswordController,
                                                  obscureText:
                                                      oldPasswordObscure,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                  style: textStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.textColor,
                                                  ),
                                                ),
                                              ),
                                              MouseRegion(
                                                cursor:
                                                    SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      oldPasswordObscure =
                                                          !oldPasswordObscure;
                                                    });
                                                  },
                                                  child: oldPasswordObscure
                                                      ? SvgPicture.asset(
                                                          AppAssets.visibility,
                                                          height: 24,
                                                          width: 24,
                                                          color: AppColors
                                                              .darkGreyColor,
                                                        )
                                                      : SvgPicture.asset(
                                                          AppAssets
                                                              .visibilityOff,
                                                          height: 24,
                                                          width: 24,
                                                          color: AppColors
                                                              .darkGreyColor,
                                                        ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "Kata Sandi Baru",
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: AppColors.lightGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 380,
                                                padding: EdgeInsets.all(10),
                                                child: TextField(
                                                  controller:
                                                      newPasswordController,
                                                  obscureText:
                                                      newPasswordObscure,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                  style: textStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.textColor,
                                                  ),
                                                ),
                                              ),
                                              MouseRegion(
                                                cursor:
                                                    SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      newPasswordObscure =
                                                          !newPasswordObscure;
                                                    });
                                                  },
                                                  child: newPasswordObscure
                                                      ? SvgPicture.asset(
                                                          AppAssets.visibility,
                                                          height: 24,
                                                          width: 24,
                                                          color: AppColors
                                                              .darkGreyColor,
                                                        )
                                                      : SvgPicture.asset(
                                                          AppAssets
                                                              .visibilityOff,
                                                          height: 24,
                                                          width: 24,
                                                          color: AppColors
                                                              .darkGreyColor,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "Konfirmasi Kata Sandi Baru",
                                          style: textStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: AppColors.lightGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 380,
                                                padding: EdgeInsets.all(10),
                                                child: TextField(
                                                  controller:
                                                      confirmNewPasswordController,
                                                  obscureText:
                                                      confirmNewPasswordObscure,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                  style: textStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.textColor,
                                                  ),
                                                ),
                                              ),
                                              MouseRegion(
                                                cursor:
                                                    SystemMouseCursors.click,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      confirmNewPasswordObscure =
                                                          !confirmNewPasswordObscure;
                                                    });
                                                  },
                                                  child:
                                                      confirmNewPasswordObscure
                                                          ? SvgPicture.asset(
                                                              AppAssets
                                                                  .visibility,
                                                              height: 24,
                                                              width: 24,
                                                              color: AppColors
                                                                  .darkGreyColor,
                                                            )
                                                          : SvgPicture.asset(
                                                              AppAssets
                                                                  .visibilityOff,
                                                              height: 24,
                                                              width: 24,
                                                              color: AppColors
                                                                  .darkGreyColor,
                                                            ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BaronButton(
                                text: 'Batal',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  NavigationHelper.cancelChangePassword(
                                      context);
                                },
                                buttonWidth: 100,
                              ),
                              BaronButton(
                                text: 'Simpan',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  if (newPasswordController.text ==
                                      confirmNewPasswordController.text) {
                                    NavigationHelper.changePasswordAlert(
                                      context,
                                      oldPasswordController.text,
                                      newPasswordController.text,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppAssets.warning,
                                            color: AppColors.whiteColor,
                                            height: 24,
                                            width: 24,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Kata Sandi Baru Tidak Cocok',
                                            style: textStyle.copyWith(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )),
                                    );
                                  }
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
