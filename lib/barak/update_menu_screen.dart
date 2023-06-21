import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:reservasi/app_assets.dart';
import 'package:reservasi/app_colors.dart';
import 'package:reservasi/app_styles.dart';
import 'package:reservasi/main.dart';
import 'package:reservasi/model.dart';
import 'package:reservasi/navigation_helper.dart';
import 'package:reservasi/responsive_widget.dart';
import 'package:reservasi/title_bar.dart';
import 'package:reservasi/component.dart';

class UpdateMenuScreen extends StatefulWidget {
  final Menu menu;

  UpdateMenuScreen({required this.menu});

  @override
  State<UpdateMenuScreen> createState() => _UpdateMenuScreenState();
}

class _UpdateMenuScreenState extends State<UpdateMenuScreen> {
  File? image;
  String filepath = "";
  final TextEditingController menuController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    menuController.text = widget.menu.namaMenu;
    hargaController.text = MyApp.getInt(widget.menu.harga).toString();
    imageController.text = "default";
  }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        menuController.text = menuController.text;
        hargaController.text = hargaController.text;
        imageController.text = path.basename(pickedImage.path);
        filepath = pickedImage.path;
        image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Uint8List imageData = base64Decode(widget.menu.image);

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
                            child: BarakSidebarMenu(activePage: "menu"),
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
                                child: Container(
                                  width: 495,
                                  height: 382,
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
                                        "Menu",
                                        style: textStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
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
                                          controller: menuController,
                                          onChanged: (value) {
                                            if (value.length > 40) {
                                              menuController.text =
                                                  value.substring(0, 40);
                                              menuController.selection =
                                                  TextSelection.fromPosition(
                                                TextPosition(offset: 40),
                                              );
                                            }
                                          },
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: textStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "Harga",
                                        style: textStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        height: 30,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.lightGreyColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Rp",
                                              style: textStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: 397,
                                                padding: EdgeInsets.all(10),
                                                alignment: Alignment.center,
                                                child: TextField(
                                                  controller: hargaController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  onChanged: (value) {
                                                    if (value.length > 5) {
                                                      hargaController.text =
                                                          value.substring(0, 5);
                                                      hargaController
                                                              .selection =
                                                          TextSelection
                                                              .fromPosition(
                                                        TextPosition(offset: 5),
                                                      );
                                                    }
                                                  },
                                                  maxLines: 1,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style: textStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.textColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "Foto",
                                        style: textStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(height: 5),
                                      Stack(
                                        children: [
                                          Container(
                                            height: 30,
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              color: AppColors.lightGreyColor,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: TextField(
                                              controller: imageController,
                                              enabled: false,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: textStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            alignment: Alignment.centerRight,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: pickImage,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Ink(
                                                  width: 90,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: AppColors
                                                        .secondaryColor,
                                                  ),
                                                  child: Text(
                                                    "Pilih Foto",
                                                    textAlign: TextAlign.center,
                                                    style: textStyle.copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          width: 150,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColors.lightGreyColor,
                                            // image: FileImage(image!),
                                          ),
                                          child: image != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.file(
                                                    image!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.memory(
                                                    imageData,
                                                    fit: BoxFit.cover,
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
                                    NavigationHelper.cancelAddMenu(context);
                                  },
                                  buttonWidth: null,
                                ),
                                BaronButton(
                                  text: 'Submit',
                                  color: AppColors.secondaryColor,
                                  callback: () async {
                                    Menu menu = new Menu(
                                      idMenu: widget.menu.idMenu,
                                      namaMenu: menuController.text,
                                      harga: hargaController.text,
                                      penjual: "",
                                      image: filepath,
                                      idPenjual: MyApp.user.username,
                                      qty: "0",
                                    );
                                    NavigationHelper.updateMenuAlert(
                                        context, menu);
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
