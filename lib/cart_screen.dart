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

class CartScreen extends StatefulWidget {
  final data, totalHarga, dropdownOption;

  CartScreen({
    required this.data,
    required this.totalHarga,
    required this.dropdownOption,
  });

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String selectedOption = '';

  @override
  void initState() {
    super.initState();
    if (widget.dropdownOption.isNotEmpty) {
      selectedOption = widget.dropdownOption.first;
    }
  }

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
                            child: SidebarMenu(activePage: "cart"),
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
                    if (widget.data == null)
                      Container(
                        height: 400,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Keranjang Anda Masih Kosong",
                            style: textStyle.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                          ),
                        ),
                      )
                    else
                      Column(
                        children: [
                          Container(
                            height: 340,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                                childAspectRatio: 1020 / 210,
                              ),
                              itemCount: widget.data.length,
                              itemBuilder: (context, index) {
                                final item = widget.data[index];
                                return Container(
                                  child: GridTile(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: CartList(
                                              context: context, data: item),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: textStyle.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  MyApp.getIDR(widget.totalHarga),
                                  style: textStyle.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.mainColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.lightGreyColor,
                                  ),
                                  child: DropdownButton<String>(
                                    value: selectedOption,
                                    items: widget.dropdownOption
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: textStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedOption = newValue!;
                                      });
                                    },
                                    underline: Container(),
                                    style: textStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.mainColor,
                                    ),
                                    dropdownColor: AppColors.whiteColor,
                                    focusColor: AppColors.secondaryColor,
                                  ),
                                ),
                                BaronButton(
                                  text: "Bayar",
                                  color: AppColors.secondaryColor,
                                  callback: () async {
                                    NavigationHelper.navigateToPayment(
                                      context,
                                      selectedOption,
                                      widget.totalHarga,
                                      widget.data,
                                    );
                                  },
                                  buttonWidth: 110,
                                ),
                              ],
                            ),
                          ),
                        ],
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
