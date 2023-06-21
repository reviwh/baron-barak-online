import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class EditBarakProfileScreen extends StatefulWidget {
  final Penjual penjual;

  EditBarakProfileScreen({required this.penjual});

  @override
  _EditBarakProfileScreenState createState() => _EditBarakProfileScreenState();
}

class _EditBarakProfileScreenState extends State<EditBarakProfileScreen> {
  TextEditingController pemilikController = TextEditingController();
  TextEditingController ponselController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController rekController = TextEditingController();

  void initState() {
    super.initState();
    pemilikController.text = widget.penjual.pemilik;
    ponselController.text = widget.penjual.noTelp;
    alamatController.text = widget.penjual.alamat;
    rekController.text = widget.penjual.rekBri;
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
                          child: BarakSidebarMenu(activePage: "profile"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
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
                            child: Text(
                              "Edit Profil Barak",
                              style: textStyle.copyWith(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
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
                                        height: 341,
                                        padding: EdgeInsets.only(
                                          top: 30,
                                          bottom: 15,
                                          left: 15,
                                          right: 15,
                                        ),
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
                                              padding: EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                color: AppColors.lightGreyColor,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: TextField(
                                                controller: pemilikController,
                                                onChanged: (value) {
                                                  if (value.length > 40) {
                                                    pemilikController.text =
                                                        value.substring(0, 40);
                                                    pemilikController
                                                            .selection =
                                                        TextSelection
                                                            .fromPosition(
                                                      TextPosition(offset: 40),
                                                    );
                                                  }
                                                },
                                                maxLines: 1,
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
                                              padding: EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                color: AppColors.lightGreyColor,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: TextField(
                                                controller: ponselController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                onChanged: (value) {
                                                  if (value.length > 13) {
                                                    ponselController.text =
                                                        value.substring(0, 13);
                                                    ponselController.selection =
                                                        TextSelection
                                                            .fromPosition(
                                                      TextPosition(offset: 13),
                                                    );
                                                  }
                                                },
                                                maxLines: 1,
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
                                              padding: EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                color: AppColors.lightGreyColor,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: TextField(
                                                controller: alamatController,
                                                onChanged: (value) {
                                                  if (value.length > 40) {
                                                    alamatController.text =
                                                        value.substring(0, 40);
                                                    alamatController.selection =
                                                        TextSelection
                                                            .fromPosition(
                                                      TextPosition(offset: 40),
                                                    );
                                                  }
                                                },
                                                maxLines: 1,
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
                                              padding: EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                color: AppColors.lightGreyColor,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: TextField(
                                                controller: rekController,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                onChanged: (value) {
                                                  if (value.length > 13) {
                                                    rekController.text =
                                                        value.substring(0, 13);
                                                    rekController.selection =
                                                        TextSelection
                                                            .fromPosition(
                                                      TextPosition(offset: 13),
                                                    );
                                                  }
                                                },
                                                maxLines: 1,
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BaronButton(
                                  text: 'Batal',
                                  color: AppColors.dangerColor,
                                  callback: () async {
                                    NavigationHelper.cancelUpdatePenjual(
                                        context);
                                  },
                                  buttonWidth: null,
                                ),
                                BaronButton(
                                  text: 'Submit',
                                  color: AppColors.secondaryColor,
                                  callback: () async {
                                    Penjual penjual = new Penjual(
                                      id: MyApp.user.username,
                                      nama: widget.penjual.nama,
                                      pemilik: pemilikController.text,
                                      noTelp: ponselController.text,
                                      alamat: alamatController.text,
                                      rekBri: rekController.text,
                                      saldo: widget.penjual.saldo,
                                    );
                                    NavigationHelper.updatePenjualAlert(
                                      context,
                                      penjual,
                                    );
                                  },
                                  buttonWidth: null,
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
