import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:flutter/material.dart';


// ignore_for_file: must_be_immutable
class HomeContainerScreen extends StatelessWidget {
  HomeContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: HomePage(),
          ));
  }


}
