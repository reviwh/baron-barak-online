import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reservasi/app_assets.dart';
import 'package:reservasi/app_colors.dart';
import 'package:reservasi/app_styles.dart';
import 'package:reservasi/component.dart';
import 'package:reservasi/main.dart';
import 'package:reservasi/model.dart';
import 'package:reservasi/navigation_helper.dart';
import 'package:reservasi/responsive_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:reservasi/title_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    const String apiUrl = 'http://localhost/desktop_api/login.php';
    // const String apiUrl = 'https://baron-api.000webhostapp.com/login.php';
    final response = await http.post(Uri.parse(apiUrl), body: {
      "username": usernameController.text,
      "password": passwordController.text,
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final bool success = data['success'];
      if (success) {
        // Login success
        MyApp.user.setUsername(data['username']);
        MyApp.user.setKategori(data['kategori']);

        if (data['kategori'] == "1") {
          if (!data['empty_cart']) {
            NavigationHelper.setBarakIsSelected(true, data['selected_barak']);
          }
          NavigationHelper.navigateToHome(context);
        } else {
          NavigationHelper.navigateToBarakMenu(context);
        }
      } else {
        // Login failed
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
                'Nama Pengguna atau Kata Sandi Tidak Valid',
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.reasonPhrase}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                  height: height,
                  color: AppColors.mainColor,
                  child: Column(
                    children: [
                      HalfLeftTitleBar(),
                      Container(
                        height: height - 33.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 210,
                              height: 90,
                              child: SvgPicture.asset(
                                AppAssets.logo,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 35.0,
                              ),
                              child: BaronLoginTextField(
                                controller: usernameController,
                                hint: 'Nama Pengguna',
                                obsecure: false,
                                callback: null,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 35.0,
                              ),
                              child: BaronLoginTextField(
                                controller: passwordController,
                                hint: 'Kata Sandi',
                                obsecure: true,
                                callback: login,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            BaronButton(
                              text: 'Masuk',
                              color: AppColors.secondaryColor,
                              callback: login,
                              buttonWidth: null,
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppAssets.bgLogin), fit: BoxFit.cover),
                ),
                child: HalfRightTitleBar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
