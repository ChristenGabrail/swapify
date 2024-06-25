import 'package:flutter/material.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/sign_up_user_info_screen/sign_up_user_info_screen.dart';
import '../presentation/sign_up_upload_photo_one_screen/sign_up_upload_photo_one_screen.dart';
import '../presentation/registration_successful_screen/registration_successful_screen.dart';
import '../presentation/enter_otp_screen/enter_otp_screen.dart';
import '../presentation/new_password_screen/new_password_screen.dart';
import '../presentation/success_reset_screen/success_reset_screen.dart';
import '../presentation/notifications_screen/notifications_screen.dart';
import '../presentation/favourites_screen/favourites_screen.dart';
import '../presentation/recently_posted_screen/recently_posted_screen.dart';
import '../presentation/filter_recently_posted_screen/filter_recently_posted_screen.dart';
import '../presentation/categories_screen/categories_screen.dart';
import '../presentation/filter_cat_screen/filter_cat_screen.dart';
import '../presentation/profile_screen/profile_screen.dart';
import '../presentation/published_tab_container_screen/published_tab_container_screen.dart';
import '../presentation/exchange_process_add_item_screen/exchange_process_add_item_screen.dart';
import '../presentation/exchange_process_no_items_screen/exchange_process_no_items_screen.dart';
import '../presentation/no_items_add_item_screen/no_items_add_item_screen.dart';
import '../presentation/masseges_screen/masseges_screen.dart';
import '../presentation/add_post_screen/add_post_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';

  static const String signUpUserInfoScreen = '/sign_up_user_info_screen';

  static const String signUpUploadPhotoOneScreen =
      '/sign_up_upload_photo_one_screen';

  static const String signUpUploadPhotoScreen = '/sign_up_upload_photo_screen';

  static const String registrationSuccessfulScreen =
      '/registration_successful_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String enterOtpScreen = '/enter_otp_screen';

  static const String newPasswordScreen = '/new_password_screen';

  static const String successResetScreen = '/success_reset_screen';

  static const String homePage = '/home_page';

  static const String homeContainerScreen = '/home_container_screen';

  static const String notificationsScreen = '/notifications_screen';

  static const String favouritesScreen = '/favourites_screen';

  static const String recentlyPostedScreen = '/recently_posted_screen';

  static const String filterRecentlyPostedScreen =
      '/filter_recently_posted_screen';

  static const String categoriesScreen = '/categories_screen';

  static const String electronicsCatPage = '/electronics_cat_page';

  static const String electronicsCatTabContainerScreen =
      '/electronics_cat_tab_container_screen';

  static const String filterCatScreen = '/filter_cat_screen';

  static const String editUsernameScreen = '/edit_username_screen';

  static const String editEmailScreen = '/edit_email_screen';

  static const String editLocationScreen = '/edit_location_screen';

  static const String editPhonenumberScreen = '/edit_phonenumber_screen';

  static const String editPasswordScreen = '/edit_password_screen';

  static const String profileScreen = '/profile_screen';

  static const String requestsPage = '/requests_page';

  static const String requestsTabContainerScreen =
      '/requests_tab_container_screen';

  static const String viewRequestScreen = '/view_request_screen';

  static const String publishedPage = '/published_page';

  static const String publishedTabContainerScreen =
      '/published_tab_container_screen';

  static const String publishedUpdateScreen = '/published_update_screen';

  static const String itemHidedPage = '/item_hided_page';

  static const String itemHidedUpdateScreen = '/item_hided_update_screen';

  static const String itemScreen = '/item_screen';

  static const String seeProfileScreen = '/see_profile_screen';

  static const String exchangeProcessScreen = '/exchange_process_screen';

  static const String exchangeProcessAddItemScreen =
      '/exchange_process_add_item_screen';

  static const String exchangeProcessNoItemsScreen =
      '/exchange_process_no_items_screen';

  static const String noItemsAddItemScreen = '/no_items_add_item_screen';

  static const String massegesScreen = '/masseges_screen';

  static const String chatScreen = '/chat_screen';

  static const String addPostScreen = '/add_post_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    signUpUserInfoScreen: (context) => SignUpUserInfoScreen(),
    signUpUploadPhotoOneScreen: (context) => SignUpUploadPhotoOneScreen(),
    registrationSuccessfulScreen: (context) => RegistrationSuccessfulScreen(),
    enterOtpScreen: (context) => EnterOtpScreen(),
    newPasswordScreen: (context) => NewPasswordScreen(),
    successResetScreen: (context) => SuccessResetScreen(),
    notificationsScreen: (context) => NotificationsScreen(),
    favouritesScreen: (context) => FavouritesScreen(),
    recentlyPostedScreen: (context) => RecentlyPostedScreen(),
    filterRecentlyPostedScreen: (context) => FilterRecentlyPostedScreen(),
    categoriesScreen: (context) => CategoriesScreen(),
    filterCatScreen: (context) => FilterCatScreen(),
    profileScreen: (context) => ProfileScreen(),
    publishedTabContainerScreen: (context) => PublishedTabContainerScreen(),
    exchangeProcessAddItemScreen: (context) => ExchangeProcessAddItemScreen(),
    exchangeProcessNoItemsScreen: (context) => ExchangeProcessNoItemsScreen(),
    noItemsAddItemScreen: (context) => NoItemsAddItemScreen(),
    massegesScreen: (context) => MessagesScreen(),
    addPostScreen: (context) => AddPostScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
