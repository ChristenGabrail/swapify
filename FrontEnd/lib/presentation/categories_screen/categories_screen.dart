import 'package:christine_s_application20/presentation/items_category_tab_container_screen/items_category_tab_container_screen.dart';
import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

import '../../api/apimethods.dart';
import '../../models/categoryModel.dart';

// ignore_for_file: must_be_immutable
class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  late List<CategoryModel> _Category;
  bool is_loading = true;

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  Future<void> getCategory() async {
    _Category = (await ApisMethods.getAllCategories());
    setState(() {
      is_loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(context),
      body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                  height: 1.v,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color:
                          theme.colorScheme.primaryContainer.withOpacity(1))),
              SizedBox(height: 20.v),
              is_loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      shrinkWrap: true, // Add this line
                      physics: NeverScrollableScrollPhysics(), // And this one
                      itemCount: _Category.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.h),
                          child: _buildMakeup(context,
                              makeup: "${_Category[index].Name}",
                              onTapMakeup: () {
                            onTapElectronics(context,
                                name: _Category[index].Name,
                                id: _Category[index].CategoryModelID);
                          }),
                        );
                      },
                    ),
            ]),
          )),
    ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftTeal900,
            margin: EdgeInsets.only(left: 16.h, top: 14.v, bottom: 14.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarTitle(
            text: "Categories", margin: EdgeInsets.only(left: 16.h)),
        styleType: Style.bgOutline);
  }

  /// Common widget
  Widget _buildMakeup(
    BuildContext context, {
    required String makeup,
    Function? onTapMakeup,
  }) {
    return GestureDetector(
        onTap: () {
          onTapMakeup!.call();
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 5.v),
            decoration: AppDecoration.fillBlue
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 4.v),
                      child: Text(makeup,
                          style: CustomTextStyles
                              .titleMediumOnPrimaryContainer_1
                              .copyWith(
                                  color:
                                      theme.colorScheme.onPrimaryContainer))),
                  CustomImageView(
                      imagePath: ImageConstant.imgArrowRight,
                      height: 13.v,
                      width: 6.h,
                      margin: EdgeInsets.symmetric(vertical: 7.v))
                ])));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the electronicsCatTabContainerScreen when the action is triggered.
  onTapElectronics(
    BuildContext, {
    required String name,
    required String id,
  }) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ItemsCategoryTabContainerScreen(
                CategoryName: name, CategoryID: id)));
  }
}
