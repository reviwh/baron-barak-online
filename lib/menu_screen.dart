import 'dart:convert';
import 'dart:typed_data';

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

class MenuScreen extends StatelessWidget {
  final Menu data;
  final List<Menu> recomendedMenu;

  final TextEditingController searchController = TextEditingController();
  final TextEditingController numberController =
      TextEditingController(text: "1");
  int number = 1;

  void increment() {
    number += 1;
    numberController.text = number.toString();
  }

  void decrement() {
    if (number > 1) {
      number -= 1;
      numberController.text = number.toString();
    }
  }

  // final item = data[index];
  MenuScreen({required this.data, required this.recomendedMenu});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Uint8List imageData = base64Decode(data.image);

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
                            child: SidebarMenu(
                              activePage: "menu",
                            ),
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
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () async {
                                    NavigationHelper.navigateToHome(context);
                                  },
                                  child: SvgPicture.asset(
                                    AppAssets.arrowBack,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Pilih Menu",
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 22,
                            width: 220,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.lightGreyColor,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.search,
                                      width: 16,
                                      height: 16,
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: TextFormField(
                                          controller: searchController,
                                          onEditingComplete: () {
                                            NavigationHelper.search(
                                              context,
                                              searchController,
                                              data.idPenjual,
                                            );
                                          },
                                          textAlign: TextAlign.left,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Cari menu...',
                                            hintStyle: textStyle.copyWith(
                                              color: AppColors.greyColor
                                                  .withOpacity(0.8),
                                              fontSize: 12,
                                            ),
                                          ),
                                          style: textStyle.copyWith(
                                            color: AppColors.textColor,
                                            fontSize: 12,
                                          ),
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
                    ),
                    Container(
                      height: 416,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 256,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        image: DecorationImage(
                                          image: MemoryImage(imageData),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Container(
                                      width: 202,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.namaMenu,
                                            style: textStyle.copyWith(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.5,
                                          ),
                                          Text(
                                            data.harga,
                                            style: textStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.5,
                                          ),
                                          Text(
                                            data.penjual,
                                            style: textStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 198,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7.5),
                                              color: AppColors.lightGreyColor,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: IconButton(
                                                    icon: SvgPicture.asset(
                                                      AppAssets.remove,
                                                      width: 25,
                                                      height: 25,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    onPressed: decrement,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 118,
                                                  height: 30,
                                                  child: Transform.translate(
                                                    offset: Offset(0, 2),
                                                    child: TextField(
                                                      controller:
                                                          numberController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.center,
                                                      readOnly: true,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: "1",
                                                        hintStyle:
                                                            textStyle.copyWith(
                                                          color: AppColors
                                                              .textColor,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      style: textStyle.copyWith(
                                                        color:
                                                            AppColors.textColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: IconButton(
                                                    icon: SvgPicture.asset(
                                                      AppAssets.add,
                                                      width: 25,
                                                      height: 25,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    onPressed: increment,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          BaronButton(
                                            text: "Pesan Sekarang",
                                            color: AppColors.secondaryColor,
                                            callback: () async {
                                              NavigationHelper.addToCard(
                                                  context,
                                                  data,
                                                  numberController);
                                            },
                                            buttonWidth: 202,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Rekomendasi Lain dari ' + data.penjual,
                                  style: textStyle.copyWith(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                Divider(
                                  color: AppColors.darkGreyColor,
                                  thickness: 1.0,
                                ),
                                Container(
                                  height: 180,
                                  child: ScrollConfiguration(
                                    behavior: ScrollBehavior()
                                        .copyWith(overscroll: false),
                                    child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 3,
                                        mainAxisSpacing: 3,
                                        childAspectRatio: 2 / 3,
                                      ),
                                      primary: false,
                                      itemCount: recomendedMenu.length,
                                      itemBuilder: (context, index) {
                                        final item = recomendedMenu[index];
                                        return Container(
                                          child: GridTile(
                                            child: Column(
                                              children: [MenuCard(menu: item)],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
