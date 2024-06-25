import 'package:christine_s_application20/presentation/requests_tab_container_screen/requests_tab_container_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import '../presentation/add_post_screen/add_post_screen.dart';
import '../presentation/favourites_screen/favourites_screen.dart';
import '../presentation/home_container_screen/home_container_screen.dart';
import '../presentation/masseges_screen/masseges_screen.dart';
import '../presentation/notifications_screen/notifications_screen.dart';

class NAVmenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavController());
    return Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBar(
            height: 80,
            elevation: 0,
            indicatorColor: Colors.black.withOpacity(0.1),
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) {
              controller.selectedIndex.value = index;
            },
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
              NavigationDestination(
                  icon: Icon(Iconsax.notification), label: "Requests"),
              NavigationDestination(icon: Icon(Iconsax.add), label: "Add"),
              NavigationDestination(icon: Icon(Iconsax.heart), label: "Saved"),
              NavigationDestination(
                  icon: Icon(Iconsax.message), label: "Chats"),
            ],
          ),
        ),
        body: /*widget.navigationShell,*/
            Obx(
          () => controller.Screen[controller.selectedIndex.value],
        ));
  }
}

class NavController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  List<Widget> Screen = [
    HomeContainerScreen(),
    RequestsTabContainerScreen(),
    AddPostScreen(),
    FavouritesScreen(),
    MessagesScreen()
  ];
}
