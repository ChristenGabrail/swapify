import 'package:christine_s_application20/navbar/NavMenu.dart';
import 'package:christine_s_application20/presentation/sign_up_upload_photo_one_screen/sign_up_upload_photo_one_screen.dart';
import 'package:christine_s_application20/presentation/sign_up_user_info_screen/sign_up_user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app_export.dart';
import 'presentation/login_screen/login_screen.dart';

late SharedPreferences sharedPreferences;
String? token;
var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  sharedPreferences = await SharedPreferences.getInstance();
  token = sharedPreferences.getString('token');

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
            theme: theme,
            title: 'tradeapp',
            debugShowCheckedModeBanner: false,
            home: token == null || token == "" ? LoginScreen() : NAVmenu());
      },
    );
  }
}
