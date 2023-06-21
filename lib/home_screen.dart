import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reservasi/app_assets.dart';
import 'package:reservasi/app_colors.dart';
import 'package:reservasi/app_styles.dart';
import 'package:reservasi/main.dart';
import 'package:reservasi/model.dart';
import 'package:reservasi/navigation_helper.dart';
import 'package:reservasi/responsive_widget.dart';
import 'package:reservasi/title_bar.dart';
import 'component.dart';

class HomeScreen extends StatelessWidget {
  final List<Menu> data;
  final id;

  HomeScreen({required this.data, required this.id});

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
                    Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    NavigationHelper.backToSelectBarak(context);
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
                                                context, searchController, id);
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
                    NavigationHelper.isFounded
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            height: 36,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Hasil Penulusuran: " +
                                      NavigationHelper.searchQuery,
                                  style: textStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(height: 10),
                    if (!NavigationHelper.isFounded &&
                        NavigationHelper.isSearched)
                      Container(
                        height: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Menu tidak ditemukan",
                              textAlign: TextAlign.center,
                              style: textStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    if (!NavigationHelper.isSearched ||
                        NavigationHelper.isFounded)
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        height: NavigationHelper.isFounded ? 380 : 400,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0,
                                  childAspectRatio: 2 / 3),
                          itemCount: data.length,
                          // padding: EdgeInsets.all(12),
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return Container(
                              child: GridTile(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [MenuCard(menu: item)],
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
          ],
        ),
      ),
    ));
  }
}
