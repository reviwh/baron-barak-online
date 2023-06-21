import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:reservasi/app_assets.dart';
import 'package:reservasi/app_colors.dart';
import 'package:reservasi/app_styles.dart';
import 'package:reservasi/main.dart';
import 'package:reservasi/model.dart';
import 'package:reservasi/navigation_helper.dart';
import 'package:reservasi/responsive_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef FutureCallback = Future<void> Function();

class BaronLoginTextField extends StatelessWidget {
  final controller;
  final hint;
  final obsecure;
  final FutureCallback? callback;

  BaronLoginTextField({
    required this.controller,
    required this.hint,
    required this.obsecure,
    required this.callback,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.lightColor,
      ),
      child: TextFormField(
        controller: this.controller,
        onEditingComplete: callback,
        obscureText: this.obsecure,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: this.hint,
          hintStyle: textStyle.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.textLoginColor.withOpacity(0.8),
            fontSize: 14.0,
          ),
        ),
        style: textStyle.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.textLoginColor,
          fontSize: 14.0,
        ),
      ),
    );
  }
}

class BaronButton extends StatelessWidget {
  final text;
  final color;
  final FutureCallback callback;
  final double? buttonWidth;

  BaronButton({
    required this.text,
    required this.color,
    required this.callback,
    required this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          callback();
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Ink(
          width: buttonWidth != null ? buttonWidth : null,
          padding: buttonWidth != null
              ? EdgeInsets.symmetric(vertical: 7.5)
              : EdgeInsets.symmetric(vertical: 7.5, horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(width: 2.0, color: AppColors.whiteColor),
            color: this.color,
          ),
          child: Text(
            this.text,
            textAlign: TextAlign.center,
            style: textStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}

class SidebarMenu extends StatelessWidget {
  final String activePage;
  SidebarMenu({required this.activePage});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                NavigationHelper.navigateToHome(context);
                NavigationHelper.setIsSearched(false);
              },
              child: activePage == 'menu'
                  ? Container(
                      width: 150,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.whiteColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondaryColor,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.menuBook,
                            width: 25,
                            height: 25,
                            color: AppColors.whiteColor,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * .013),
                            child: Text(
                              'Menu',
                              style: textStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.menuBook,
                            width: 25,
                            height: 25,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * .013),
                            child: Text(
                              'Menu',
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
          SizedBox(
            height: 15,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                NavigationHelper.navigateToCart(context);
              },
              child: activePage == 'cart'
                  ? Container(
                      width: 150,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.whiteColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondaryColor,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.shoppingCart,
                            width: 25,
                            height: 25,
                            color: AppColors.whiteColor,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * .013),
                            child: Text(
                              'Keranjang',
                              style: textStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.shoppingCart,
                            width: 25,
                            height: 25,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * .013),
                            child: Text(
                              'Keranjang',
                              style: textStyle.copyWith(
                                fontSize: 16.0,
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
          SizedBox(
            height: 15,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                NavigationHelper.navigateToProfile(context);
              },
              child: activePage == 'profile'
                  ? Container(
                      width: 150,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.whiteColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondaryColor,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.person,
                            width: 25,
                            height: 25,
                            color: AppColors.whiteColor,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * .013),
                            child: Text(
                              'Profil',
                              style: textStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.person,
                            width: 25,
                            height: 25,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * .013),
                            child: Text(
                              'Profil',
                              style: textStyle.copyWith(
                                fontSize:
                                    ResponsiveWidget.isSmallScreen(context)
                                        ? 16.0
                                        : 20.0,
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
          SizedBox(
            height: 15,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                NavigationHelper.exitApplication(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.logOut,
                      width: 25,
                      height: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * .013),
                      child: Text(
                        'Keluar',
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
        ],
      ),
    );
  }
}

class BarakSidebarMenu extends StatelessWidget {
  final String activePage;
  BarakSidebarMenu({required this.activePage});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                NavigationHelper.navigateToBarakMenu(context);
                NavigationHelper.setIsSearched(false);
              },
              child: activePage == 'menu'
                  ? Container(
                      width: 150,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.whiteColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondaryColor,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.menuBook,
                            width: 25,
                            height: 25,
                            color: AppColors.whiteColor,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * .013),
                            child: Text(
                              'Menu',
                              style: textStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.menuBook,
                            width: 25,
                            height: 25,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * .013),
                            child: Text(
                              'Menu',
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
          SizedBox(
            height: 15,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                NavigationHelper.navigateToOrderScreen(context);
              },
              child: activePage == 'cart'
                  ? Container(
                      width: 150,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.whiteColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondaryColor,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.listAll,
                            width: 25,
                            height: 25,
                            color: AppColors.whiteColor,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * .013),
                            child: Text(
                              'Pesanan',
                              style: textStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.listAll,
                            width: 25,
                            height: 25,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * .013),
                            child: Text(
                              'Pesanan',
                              style: textStyle.copyWith(
                                fontSize: 16.0,
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
          SizedBox(
            height: 15,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                NavigationHelper.navigateToBarakProfile(context);
              },
              child: activePage == 'profile'
                  ? Container(
                      width: 150,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.whiteColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondaryColor,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.store,
                            width: 25,
                            height: 25,
                            color: AppColors.whiteColor,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * .013),
                            child: Text(
                              'Barak',
                              style: textStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.store,
                            width: 25,
                            height: 25,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * .013),
                            child: Text(
                              'Barak',
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
          SizedBox(
            height: 15,
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                NavigationHelper.exitApplication(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.logOut,
                      width: 25,
                      height: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * .013),
                      child: Text(
                        'Keluar',
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
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final Menu menu;
  MenuCard({required this.menu});
  @override
  Widget build(BuildContext context) {
    Uint8List imageData = base64Decode(menu.image);
    return MouseRegion(
      cursor: MyApp.user.kategori == "1"
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: MyApp.user.kategori == "1"
          ? GestureDetector(
              onTap: () {
                NavigationHelper.navigateToMenu(context, menu.idMenu);
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightGreyColor,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: SizedBox(
                      width: 120,
                      height: 180,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: AppColors.whiteColor,
                        borderOnForeground: true,
                        shadowColor: AppColors.textColor.withOpacity(.5),
                        child: Column(
                          children: [
                            Container(
                              width: 120,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                image: DecorationImage(
                                  image: MemoryImage(imageData),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    menu.namaMenu.length > 10
                                        ? menu.namaMenu.substring(0, 10) + '...'
                                        : menu.namaMenu,
                                    style: textStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    menu.harga.toString(),
                                    style: textStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    menu.penjual,
                                    style: textStyle.copyWith(
                                      fontSize: 12,
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
            )
          : Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lightGreyColor,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: SizedBox(
                    width: 120,
                    height: 180,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: AppColors.whiteColor,
                      borderOnForeground: true,
                      shadowColor: AppColors.textColor.withOpacity(.5),
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              image: DecorationImage(
                                image: MemoryImage(imageData),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Text(
                                  menu.namaMenu.length > 10
                                      ? menu.namaMenu.substring(0, 10) + '...'
                                      : menu.namaMenu,
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  menu.harga.toString(),
                                  style: textStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  menu.penjual,
                                  style: textStyle.copyWith(
                                    fontSize: 12,
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
    );
  }
}

class BarakList extends StatelessWidget {
  final Barak data;

  BarakList({required this.data});

  @override
  Widget build(BuildContext context) {
    return data.mejaTersedia != "0"
        ? MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                NavigationHelper.setBarakIsSelected(true, data.idBarak);
                NavigationHelper.navigateToHome(context);
              },
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
                    child: SizedBox(
                      width: 216,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              data.namaBarak,
                              style: textStyle.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Tersedia ${data.mejaTersedia} / ${data.jumlahMeja}",
                              style: textStyle.copyWith(
                                fontSize: 14,
                                color: AppColors.darkGreyColor,
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
          )
        : Container(
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
                child: SizedBox(
                  width: 216,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          data.namaBarak,
                          style: textStyle.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Tersedia ${data.mejaTersedia} / ${data.jumlahMeja}",
                          style: textStyle.copyWith(
                            fontSize: 14,
                            color: AppColors.darkGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

class CartList extends StatelessWidget {
  TextEditingController numberController = TextEditingController();
  final BuildContext context;
  final CartItem data;
  int number;

  CartList({
    required this.context,
    required this.data,
  }) : number = int.parse(data.qty);

  void increment() {
    number += 1;
    numberController.text = number.toString();
    NavigationHelper.updateQty(context, data, numberController);
  }

  void decrement() {
    if (number > 1) {
      number -= 1;
      numberController.text = number.toString();
      NavigationHelper.updateQty(context, data, numberController);
    }
  }

  void deleteItem() {
    NavigationHelper.deleteFromCartAlert(context, data);
  }

  @override
  Widget build(BuildContext context) {
    Uint8List imageData = base64Decode(data.image);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGreyColor,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 60,
                        margin: EdgeInsets.only(right: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          image: DecorationImage(
                            image: MemoryImage(imageData),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.namaMenu,
                            style: textStyle.copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data.harga,
                            style: textStyle.copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 110,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.5),
                          color: AppColors.lightGreyColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  AppAssets.remove,
                                  width: 15,
                                  height: 15,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: decrement,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 2,
                                ),
                                child: TextField(
                                  controller: numberController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: data.qty,
                                    hintStyle: textStyle.copyWith(
                                      color: AppColors.textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: textStyle.copyWith(
                                    color: AppColors.textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  AppAssets.add,
                                  width: 15,
                                  height: 15,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: increment,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: SvgPicture.asset(
                            AppAssets.delete,
                            width: 15,
                            height: 15,
                            fit: BoxFit.cover,
                          ),
                          onPressed: deleteItem,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BarakCard extends StatelessWidget {
  final Menu menu;
  BarakCard({required this.menu});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MenuCard(menu: menu),
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          alignment: Alignment.topRight,
          child: Column(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    NavigationHelper.navigateToUpdateMenuScreen(context, menu);
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: Ink(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: AppColors.secondaryColor,
                    ),
                    child: Transform.scale(
                      scale: 3 / 4,
                      child: SvgPicture.asset(
                        AppAssets.edit,
                        width: 14,
                        height: 14,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    NavigationHelper.deleteMenuAlert(context, menu);
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: Ink(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: AppColors.dangerColor,
                    ),
                    child: Transform.scale(
                      scale: 3 / 4,
                      child: SvgPicture.asset(
                        AppAssets.delete,
                        width: 14,
                        height: 14,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderedTable extends StatelessWidget {
  final Meja data;

  OrderedTable({required this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor,
            blurRadius: 10,
          ),
        ],
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            NavigationHelper.navigateToOrderDetails(context, data.idMeja);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        data.idMeja,
                        style: textStyle.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            NavigationHelper.tableUsingIsCompleted(
                                context, data.idMeja);
                          },
                          child: SvgPicture.asset(
                            AppAssets.checkCircle,
                            width: 28,
                            height: 28,
                            color: AppColors.secondaryColor,
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
    );
  }
}

class OrderList extends StatelessWidget {
  final Menu data;
  OrderList({required this.data});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 200,
          alignment: Alignment.centerLeft,
          child: Text(
            data.namaMenu,
            style: textStyle.copyWith(fontSize: 14),
          ),
        ),
        Container(
          width: 80,
          alignment: Alignment.center,
          child: Text(
            data.qty,
            style: textStyle.copyWith(fontSize: 14),
          ),
        ),
        Container(
          width: 100,
          alignment: Alignment.centerRight,
          child: Text(
            data.harga,
            style: textStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
