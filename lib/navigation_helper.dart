import 'dart:convert';
import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reservasi/app_assets.dart';
import 'package:reservasi/app_colors.dart';
import 'package:reservasi/app_styles.dart';
import 'package:reservasi/barak/add_menu_screen.dart';
import 'package:reservasi/barak/barak_menu_screen.dart';
import 'package:reservasi/barak/barak_profile_screen.dart';
import 'package:reservasi/barak/edit_barak_profile_screen.dart';
import 'package:reservasi/barak/order_details_screen.dart';
import 'package:reservasi/barak/order_screen.dart';
import 'package:reservasi/barak/update_menu_screen.dart';
import 'package:reservasi/cart_screen.dart';
import 'package:reservasi/change_password_screen.dart';
import 'package:reservasi/component.dart';
import 'package:reservasi/home_screen.dart';
import 'package:reservasi/login_screen.dart';
import 'package:reservasi/main.dart';
import 'package:reservasi/menu_screen.dart';
import 'package:reservasi/model.dart';
import 'package:reservasi/profile_screen.dart';
import 'package:reservasi/select_barak_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationHelper {
  static bool isSearched = false;
  static bool isFounded = false;
  static bool showAllMenu = true;
  static String searchQuery = "";
  static bool barakIsSelected = false;
  static String selectedBarak = "";
  static bool cartIsEmpty = true;
  static bool pesananIsEmpty = true;

  // static const String site = "https://baron-api.000webhostapp.com/";
  static const String site = "http://localhost/desktop_api/";

  static void setIsSearched(bool value) {
    isSearched = value;
  }

  static void setBarakIsSelected(bool value, String id) {
    barakIsSelected = value;
    selectedBarak = id;
  }

  static void navigateToHome(BuildContext context) async {
    if (barakIsSelected) {
      final id = selectedBarak;
      var response = await getMenuByBarakId(id);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Menu> data = jsonData.map((e) => Menu.fromJson(e)).toList();
        isFounded = false;
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration.zero,
            pageBuilder: (_, __, ___) => HomeScreen(
              data: data,
              id: selectedBarak,
            ),
          ),
        );
      } else {
        // HTTP request failed
        print('Error: ${response.statusCode}');
      }
    } else {
      var response = await getAllBarak();
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Barak> data = jsonData.map((e) => Barak.fromJson(e)).toList();
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration.zero,
            pageBuilder: (_, __, ___) => SelectBarakScreen(data: data),
          ),
        );
      } else {
        // HTTP request failed
        print('Error: ${response.statusCode}');
      }
    }
  }

  static void navigateToCart(BuildContext context) async {
    final id = MyApp.user.username;
    var response = await getCartById(id);
    if (response.statusCode == 200) {
      dynamic decodedResponse = json.decode(response.body);
      int totalHarga = 0;
      List<CartItem>? data;
      List<String> idList = [];

      if (decodedResponse != null) {
        final List<dynamic> jsonData = decodedResponse;
        data = jsonData.map((e) => CartItem.fromJson(e)).toList();

        totalHarga = data.fold<int>(
            0,
            (previousValue, item) =>
                previousValue +
                MyApp.getInt(item.harga) * MyApp.getInt(item.qty));
        setBarakIsSelected(true, data.first.idPenjual);
        var response2 = await getUnorderedTable(selectedBarak);
        if (response2.statusCode == 200) {
          final List<dynamic> jsonData2 = json.decode(response2.body);
          final List<UnorderedTable> data2 =
              jsonData2.map((e) => UnorderedTable.fromJson(e)).toList();
          idList = data2.map((e) => e.id.toString()).toList();
        } else {
          // HTTP request failed
          print('Error: ${response2.statusCode}');
        }
      } else {
        data = null;
        setBarakIsSelected(false, "");
      }
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => CartScreen(
            data: data,
            totalHarga: totalHarga,
            dropdownOption: idList,
          ),
        ),
      );
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
    }
  }

  static void navigateToProfile(BuildContext context) async {
    final id = MyApp.user.username;
    var response = await getPelangganData(id);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Pelanggan pelanggan = new Pelanggan(
          nama: data['nama'],
          jurusan: data['jurusan'],
          prodi: data['prodi'],
          profileImage: data['profile_image'],
          telepon: data['telepon'],
          email: data['email']);
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => ProfileScreen(
            pelanggan: pelanggan,
          ),
        ),
      );
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
    }
  }

  static void exitApplication(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Keluar dari Aplikasi',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin ingin keluar? Data Anda akan disimpan.',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  appWindow.close();
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void cancelChangePassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Batalkan Ganti Kata Sandi',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin ingin membatalkan perubahan kata sandi?',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  MyApp.user.kategori == "1"
                                      ? navigateToProfile(context)
                                      : navigateToBarakProfile(context);
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void navigateToChangePassword(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => ChangePasswordScreen(),
      ),
    );
  }

  static void search(
      BuildContext context, TextEditingController c, String id) async {
    var response = await findMenu(c.text, id);
    if (response.statusCode == 200) {
      if (response.body == "null") {
        isSearched = true;
        isFounded = false;
        navigateToHome(context);
      } else {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Menu> data = jsonData.map((e) => Menu.fromJson(e)).toList();
        // if (data['found']) {
        isFounded = true;
        searchQuery = c.text;
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration.zero,
            pageBuilder: (_, __, ___) => HomeScreen(
              data: data,
              id: selectedBarak,
            ),
          ),
        );
      }
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
    }
  }

  static void navigateToMenu(BuildContext context, String idMenu) async {
    final response = await getMenuById(idMenu);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Menu menu = new Menu(
        idMenu: data['id_menu'],
        namaMenu: data['nama_menu'],
        harga: MyApp.getIDR(int.parse(data['harga'])),
        penjual: data['nama'],
        image: data['menu_image'],
        idPenjual: data['id_penjual'],
        qty: "0",
      );

      List<Menu> recomendedMenu =
          await getRecomedationMenu(data['id_penjual'], data['id_menu']);
      isSearched = false;
      Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration.zero,
            pageBuilder: (_, __, ___) => MenuScreen(
              data: menu,
              recomendedMenu: recomendedMenu,
            ),
          ));
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
    }
  }

  static void addToCard(
      BuildContext context, Menu menu, TextEditingController c) async {
    var response = await setNewItemToCart(menu.idMenu, c.text);
    if (response.statusCode == 200) {
      cartIsEmpty = false;
      navigateToCart(context);
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
    }
  }

  static void updateQty(
      BuildContext context, CartItem menu, TextEditingController c) async {
    var response = await setQtyValue(menu.idKeranjang, c.text);
    if (response.statusCode == 200) {
      navigateToCart(context);
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
    }
  }

  static void deleteFromCartAlert(BuildContext context, CartItem menu) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hapus Menu dari Keranjang',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin ingin menghapus ${menu.namaMenu} dari keranjang?',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                  deleteFromCart(context, menu);
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void deleteFromCart(BuildContext context, CartItem menu) async {
    final id = menu.idKeranjang;
    var response = await deleteFromCartById(id);
    if (response.statusCode == 200) {
      navigateToCart(context);
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
    }
  }

  static void logOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Anda mencoba keluar',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin ingin keluar? Data Anda akan disimpan.',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  MyApp.user.setUsername("");
                                  MyApp.user.setKategori("");
                                  setBarakIsSelected(false, "");
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration: Duration.zero,
                                        pageBuilder: (_, __, ___) =>
                                            LoginScreen(),
                                      ));
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void changePasswordAlert(
      BuildContext context, String oldPassword, String newPassword) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Konfirmasi Ganti Kata Sandi',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin ingin mengganti kata sandi?',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                  changePassword(
                                      context, oldPassword, newPassword);
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void changePassword(
    BuildContext context,
    String oldPassword,
    String newPassword,
  ) async {
    var response = await updatePassword(oldPassword, newPassword);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final bool success = data['success'];
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Row(
            children: [
              SvgPicture.asset(
                AppAssets.checkCircle,
                color: AppColors.whiteColor,
                height: 24,
                width: 24,
              ),
              SizedBox(width: 10),
              Text(
                'Kata sandi berhasil diganti',
                style: textStyle.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
        );
        MyApp.user.kategori == "1"
            ? NavigationHelper.navigateToProfile(context)
            : NavigationHelper.navigateToBarakProfile(context);
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
                'Kata Sandi Salah',
                style: textStyle.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
        );
      }
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
    }
  }

  static void backToSelectBarak(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kembali ke Pilih Barak',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin ingin memilih barak lagi? Keranjang anda akan dikosongkan.',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                  emptyCart(context);
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void tableUsingIsCompleted(BuildContext context, id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Meja Selesai Digunakan',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin? Pesanan akan dihapus dan meja kembali tersedia.',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                  final response = await updateReservation(id);
                                  if (response.statusCode == 200) {
                                    navigateToOrderScreen(context);
                                  } else {
                                    print("Error: ${response.statusCode}");
                                  }
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void emptyCart(BuildContext context) async {
    var response = await deleteAllFromCartWhereUser();
    if (response.statusCode == 200) {
      setBarakIsSelected(false, "");
      navigateToHome(context);
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
    }
  }

  static void navigateToBarakMenu(BuildContext context) async {
    final id = MyApp.user.username;
    var response = await getMenuByBarakId(id);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Menu> data = jsonData.map((e) => Menu.fromJson(e)).toList();
      isFounded = false;
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => BarakMenuScreen(
            data: data,
          ),
        ),
      );
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
    }
  }

  static void searchAsBarak(
      BuildContext context, TextEditingController c) async {
    final id = MyApp.user.username;
    var response = await findMenu(c.text, id);
    if (response.statusCode == 200) {
      if (response.body == "null") {
        isSearched = true;
        isFounded = false;
        navigateToBarakMenu(context);
      } else {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Menu> data = jsonData.map((e) => Menu.fromJson(e)).toList();
        isFounded = true;
        searchQuery = c.text;
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration.zero,
            pageBuilder: (_, __, ___) => BarakMenuScreen(
              data: data,
            ),
          ),
        );
      }
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
    }
  }

  static void navigateToOrderScreen(BuildContext context) async {
    final id = MyApp.user.username;
    var response = await getOrderedTable(id);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Meja> data = jsonData.map((e) => Meja.fromJson(e)).toList();
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => OrderScreen(
            data: data,
          ),
        ),
      );
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
    }
  }

  static void navigateToBarakProfile(BuildContext context) async {
    final id = MyApp.user.username;
    var response = await getPenjualData(id);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Penjual penjual = new Penjual(
        id: data['id'],
        nama: data['nama'],
        alamat: data['alamat'],
        noTelp: data['no_telp'],
        pemilik: data['pemilik'],
        rekBri: data['rek_bri'],
        saldo: data['saldo'],
      );
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => BarakProfileScreen(
            penjual: penjual,
          ),
        ),
      );
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
    }
  }

  static void addNewMenu(BuildContext context, Menu menu) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tambahkan Menu',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin semua data yang Anda masukkan sudah benar?',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                  var response = await insertMenu(menu.namaMenu,
                                      menu.harga, menu.image, menu.idPenjual);
                                  if (response.statusCode == 200) {
                                    navigateToBarakMenu(context);
                                  } else {
                                    print('Error: ${response.statusCode}');
                                  }
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void updateMenuAlert(BuildContext context, Menu menu) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Perbarui Menu',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin semua data yang Anda masukkan sudah benar?',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                  var response = await updateMenu(menu.namaMenu,
                                      menu.harga, menu.image, menu.idMenu);
                                  if (response.statusCode == 200) {
                                    navigateToBarakMenu(context);
                                  } else {
                                    print('Error: ${response.statusCode}');
                                  }
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void updatePenjualAlert(BuildContext context, Penjual penjual) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Perbarui Data Barak',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin semua data yang Anda masukkan sudah benar?',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                  final response = await updatePenjual(
                                    penjual.pemilik,
                                    penjual.noTelp,
                                    penjual.alamat,
                                    penjual.rekBri,
                                    penjual.id,
                                  );
                                  if (response.statusCode == 200) {
                                    navigateToBarakProfile(context);
                                  } else {
                                    print('Error: ${response.statusCode}');
                                  }
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void cancelAddMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kembali ke Daftar Menu',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin? Perubahan yang Anda lakukan tidak akan disimpan.',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  NavigationHelper.navigateToBarakMenu(context);
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void cancelUpdatePenjual(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Batalkan Perubahan',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin? Perubahan yang Anda lakukan tidak akan disimpan.',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  NavigationHelper.navigateToBarakProfile(
                                      context);
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void navigateToAddMenuScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => AddMenuScreen(),
      ),
    );
  }

  static void navigateToUpdateMenuScreen(BuildContext context, Menu menu) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => UpdateMenuScreen(menu: menu),
      ),
    );
  }

  static void navigateToEditBarakProfile(
      BuildContext context, Penjual penjual) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => EditBarakProfileScreen(penjual: penjual),
      ),
    );
  }

  static void navigateToOrderDetails(BuildContext context, id) async {
    final response = await getOrderDetails(id);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      Order order = Order.fromJson(json);
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (_, __, ___) => OrderDetailsScreen(order: order),
        ),
      );
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  static void navigateToPayment(
      BuildContext context, idMeja, total, menus) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bayar Sekarang',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin data yang Anda masukkan sudah benar?',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  final id = MyApp.user.username;
                                  final url =
                                      '${site}/redirect-to-midtrans.php?id=${id}&id_meja=${idMeja}';
                                  final response = await createReservation(
                                      id, idMeja, total, menus);
                                  if (response.statusCode == 200) {
                                    deleteAllFromCartWhereUser();
                                    await launch(url);
                                    navigateToCart(context);
                                  } else {
                                    print('Error: ${response.statusCode}');
                                  }
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void deleteMenuAlert(BuildContext context, Menu menu) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 480,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.white],
                    stops: [.05, .05],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: 20,
                        right: 10,
                        bottom: 0,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.warningFill,
                            color: AppColors.mainColor,
                            width: 64,
                            height: 64,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hapus Menu',
                                style: textStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                ),
                              ),
                              Container(
                                width: 360,
                                height: 50,
                                child: Text(
                                  'Apa Anda yakin ingin menghapus ${menu.namaMenu} dari menu?',
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          color: AppColors.greyColor,
                          thickness: 1,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BaronButton(
                                text: 'Tidak',
                                color: AppColors.dangerColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                },
                                buttonWidth: 75,
                              ),
                              SizedBox(width: 10),
                              BaronButton(
                                text: 'Ya',
                                color: AppColors.secondaryColor,
                                callback: () async {
                                  Navigator.of(context).pop(false);
                                  deleteMenu(menu.idMenu);
                                  NavigationHelper.navigateToBarakMenu(context);
                                },
                                buttonWidth: 75,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // HTTP REQUEST

  static dynamic getMenuByBarakId(id) async {
    final String apiUrl = '${site}/select-menu.php?id=${id}';
    final response = await http.get(Uri.parse(apiUrl));
    return response;
  }

  static dynamic getAllBarak() async {
    final url = Uri.parse('${site}/get-barak-to-select.php');
    final response = await http.get(url);
    return response;
  }

  static dynamic getCartById(id) async {
    final url = Uri.parse('${site}/select-cart.php?id_pelanggan=${id}');
    final response = await http.get((url));
    return response;
  }

  static dynamic getPelangganData(id) async {
    final url = Uri.parse('${site}/get-pelanggan.php?id=${id}');
    final response = await http.get(url);
    return response;
  }

  static dynamic findMenu(q, id) async {
    final String apiUrl = '${site}/search.php?id=${id}&q=${q}';
    final response = await http.get(Uri.parse(apiUrl));
    return response;
  }

  static dynamic getRecomedationMenu(idPenjual, idMenu) async {
    final url = Uri.parse(
        '${site}/select-barak-menu.php?id_penjual=${idPenjual}&id_menu=${idMenu}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Menu> data = jsonData.map((e) => Menu.fromJson(e)).toList();
      return data;
    } else {
      // HTTP request failed
      print('Error: ${response.statusCode}');
      return [];
    }
  }

  static dynamic getMenuById(id) async {
    final url = Uri.parse('${site}/select-single-menu.php?id=${id}');
    final response = await http.get(url);
    return response;
  }

  static dynamic setNewItemToCart(id, qty) async {
    final String apiUrl = '${site}/add-to-cart.php';
    final response = await http.post(Uri.parse(apiUrl), body: {
      "id_menu": id,
      "qty": qty,
      "id_pelanggan": MyApp.user.username,
    });
    return response;
  }

  static dynamic setQtyValue(id, qty) async {
    final String apiUrl = '${site}/update-qty.php';
    final response = await http.post(Uri.parse(apiUrl), body: {
      "id_keranjang": id,
      "qty": qty,
    });
    return response;
  }

  static dynamic deleteFromCartById(id) async {
    final url = Uri.parse('${site}/delete-from-cart.php?id_keranjang=${id}');
    final response = await http.get(url);
    return response;
  }

  static dynamic deleteAllFromCartWhereUser() async {
    final url = Uri.parse("${site}/empty-cart.php?id=${MyApp.user.username}");
    final response = await http.get(url);
    return response;
  }

  static dynamic updatePassword(old, now) async {
    final url = Uri.parse(
        '${site}/change-password.php?username=${MyApp.user.username}');
    final response =
        await http.post(url, body: {"old_password": old, "new_password": now});
    return response;
  }

  static dynamic getOrderedTable(id) async {
    final url = Uri.parse("${site}/select-ordered-table.php?id=${id}");
    final response = await http.get(url);
    return response;
  }

  static dynamic getUnorderedTable(id) async {
    final url = Uri.parse("${site}/select-unordered-table.php?id=${id}");
    final response = await http.get(url);
    return response;
  }

  static dynamic getPenjualData(id) async {
    final url = Uri.parse('${site}/get-penjual.php?id=${id}');
    final response = await http.get(url);
    return response;
  }

  static dynamic deleteMenu(id) async {
    final url = Uri.parse('${site}/delete-menu.php?id=${id}');
    final response = await http.get(url);
    return response;
  }

  static dynamic getOrderDetails(id) async {
    final url = Uri.parse('${site}/get-order-details.php?id=${id}');
    final response = await http.get(url);
    return response;
  }

  static dynamic updateReservation(id) async {
    final url = Uri.parse('${site}/update-reservation.php?id=${id}');
    final response = await http.get(url);
    return response;
  }

  static dynamic insertMenu(nama, harga, image, id) async {
    final url = Uri.parse('${site}/create-menu.php?id_penjual=${id}');
    final response = await http.post(url, body: {
      "nama_menu": nama,
      "harga": harga,
      "menu_image": image,
    });
    return response;
  }

  static dynamic updateMenu(nama, harga, image, id) async {
    final url = Uri.parse('${site}/update-menu.php?id_menu=${id}');
    final response = await http.post(url, body: {
      "nama_menu": nama,
      "harga": harga,
      "menu_image": image,
    });
    return response;
  }

  static dynamic updatePenjual(pemilik, noTelp, alamat, rekBri, id) async {
    final url = Uri.parse('${site}/update-penjual.php?id=${id}');
    final response = await http.post(url, body: {
      "pemilik": pemilik,
      "no_telp": noTelp,
      "alamat": alamat,
      "rek_bri": rekBri,
      "id": id,
    });
    return response;
  }

  static dynamic createReservation(id, idMeja, total, menus) async {
    final apiUrl = Uri.parse('${site}/create-reservation.php');
    final jsonData = {
      ...menus.asMap().map((index, item) => MapEntry(index.toString(), {
            'id_menu': item.idMenu,
            'qty': item.qty,
          })),
      'id_pelanggan': id,
      'id_meja': idMeja,
      'total': total
    };

    final response = await http.post(apiUrl, body: jsonEncode(jsonData));
    return response;
  }
}
