import 'dart:io';

import 'package:christine_s_application20/widgets/app_bar/custom_app_bar.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_leading_image.dart';
import 'package:christine_s_application20/widgets/app_bar/appbar_title.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';
import '../../api/apimethods.dart';
import '../../main.dart';
import '../../models/categoryModel.dart';
import '../add_post_screen/widgets/conditioninput6_item_widget.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:christine_s_application20/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

// ignore_for_file: must_be_immutable
class AddPostScreen extends StatefulWidget {
  AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController inputController = TextEditingController();
  List<dynamic> dropdownItemList = [];
  List<dynamic> dropdownConditionList = ['New', 'Used'];

  TextEditingController priceController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? token = sharedPreferences.getString('token');
  File? selesctedItemIamge;

  Future pickimage() async {
    final returnedIamge =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedIamge == null) return;
    setState(() {
      selesctedItemIamge = File(returnedIamge!.path);
    });
  }

  String _currentSelectedValue = "665f62f6e7e2ba8dc5bc0089";

  late List<CategoryModel> _Category;
  bool is_loading = true;
  String dropdownValue = 'new'; // Default value for the dropdown

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  Future<void> getCategory() async {
    _Category = (await ApisMethods.getAllCategories());
    setState(() {
      is_loading = false;
      dropdownItemList.addAll(_Category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 5.v),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 1.v,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer
                                    .withOpacity(1))),
                        Padding(
                            padding: EdgeInsets.only(left: 25.h),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Upload Product photo ",
                                      style: CustomTextStyles
                                          .titleMediumff083344_1),
                                  TextSpan(
                                      text: "*",
                                      style: CustomTextStyles
                                          .titleMediumffea5b5b_1)
                                ]),
                                textAlign: TextAlign.left)),
                        SizedBox(height: 7.v),
                        _buildAddImage(context),
                        SizedBox(height: 23.v),
                        Padding(
                            padding: EdgeInsets.only(left: 16.h),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Add Title ",
                                      style:
                                          CustomTextStyles.titleMediumff083344),
                                  TextSpan(
                                      text: "*",
                                      style:
                                          CustomTextStyles.titleMediumffea5b5b)
                                ]),
                                textAlign: TextAlign.left)),
                        SizedBox(height: 4.v),
                        _buildName(context),
                        SizedBox(height: 17.v),
                        Padding(
                            padding: EdgeInsets.only(left: 16.h),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Describe your product ",
                                      style:
                                          CustomTextStyles.titleMediumff083344),
                                  TextSpan(
                                      text: "*",
                                      style:
                                          CustomTextStyles.titleMediumffea5b5b)
                                ]),
                                textAlign: TextAlign.left)),
                        SizedBox(height: 2.v),
                        _buildInput(context),
                        SizedBox(height: 18.v),
                        Padding(
                            padding: EdgeInsets.only(left: 16.h),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Category ",
                                      style:
                                          CustomTextStyles.titleMediumff083344),
                                  TextSpan(
                                      text: "*",
                                      style:
                                          CustomTextStyles.titleMediumffea5b5b)
                                ]),
                                textAlign: TextAlign.left)),
                        SizedBox(height: 1.v),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.h),
                            child: is_loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : DropdownButton<String>(
                                    value: _currentSelectedValue,
                                    //hint: Text("category"),
                                    alignment: Alignment.center,
                                    items: dropdownItemList.map((item) {
                                      return DropdownMenuItem(
                                        value: item.CategoryModelID
                                            .toString(), // Assuming each item has an 'id'
                                        child: Text(item
                                            .Name), // Assuming each item has a 'name'
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      _currentSelectedValue = value!;
                                      setState(() {});
                                    },
                                  )),
                        SizedBox(height: 15.v),
                        Padding(
                            padding: EdgeInsets.only(left: 16.h),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Price ",
                                      style:
                                          CustomTextStyles.titleMediumff083344),
                                  TextSpan(
                                      text: "*",
                                      style:
                                          CustomTextStyles.titleMediumffea5b5b)
                                ]),
                                textAlign: TextAlign.left)),
                        SizedBox(height: 4.v),
                        _buildPrice(context),
                        SizedBox(height: 15.v),
                        Padding(
                            padding: EdgeInsets.only(left: 15.h),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Condition ",
                                      style:
                                          CustomTextStyles.bodyMediumff083344),
                                  TextSpan(
                                      text: "*",
                                      style:
                                          CustomTextStyles.bodyMediumffea5b5b)
                                ]),
                                textAlign: TextAlign.left)),
                        SizedBox(height: 2.v),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.h),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            iconSize: 24,
                            elevation: 16,
                            items: <String>['new', 'used']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 48.v),
                        _buildBtns(context)
                      ])))),
    ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,
        title:
            AppbarTitle(text: "Add Post", margin: EdgeInsets.only(left: 16.h)),
        styleType: Style.bgOutline);
  }

  /// Section Widget
  Widget _buildAddImage(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: selesctedItemIamge == null
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 15.h),
                decoration: AppDecoration.outlineTeal
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder15),
                child: DottedBorder(
                    color: appTheme.teal900,
                    padding: EdgeInsets.only(
                        left: 1.h, top: 1.v, right: 1.h, bottom: 1.v),
                    strokeWidth: 1.h,
                    radius: Radius.circular(15),
                    borderType: BorderType.RRect,
                    dashPattern: [5, 5],
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 97.h, vertical: 61.v),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomImageView(
                                  onTap: () {
                                    pickimage();
                                  },
                                  imagePath: ImageConstant.imgTypcnUpload,
                                  height: 24.adaptSize,
                                  width: 24.adaptSize,
                                  margin: EdgeInsets.only(top: 1.v)),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 11.h, top: 3.v, right: 1.h),
                                  child: Text("Add image",
                                      style:
                                          CustomTextStyles.titleSmallTeal900))
                            ]))))
            : Image.file(
                selesctedItemIamge!,
                width: 400.v,
                height: 250.h,
              ));
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: CustomTextFormField(
            controller: nameController,
            hintText: "Product name",
            alignment: Alignment.center));
  }

  /// Section Widget
  Widget _buildInput(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: CustomTextFormField(
            controller: inputController,
            hintText: "description",
            alignment: Alignment.center));
  }

  /// Section Widget
  Widget _buildPrice(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: CustomTextFormField(
            controller: priceController,
            hintText: "price",
            textInputAction: TextInputAction.done,
            alignment: Alignment.center));
  }

  /// Section Widget
  Widget _buildAddPost(BuildContext context) {
    return CustomElevatedButton(
        height: 41.v,
        width: 161.h,
        text: "Add Post",
        onPressed: () {
          print(nameController.text +
              dropdownValue +
              priceController.text +
              selesctedItemIamge!.path +
              inputController.text +
              _currentSelectedValue);
          ApisMethods.createItem(
              token!,
              nameController.text,
              dropdownValue == 'new' ? true : false,
              priceController.text,
              selesctedItemIamge!,
              inputController.text,
              _currentSelectedValue);
        },
        buttonStyle: CustomButtonStyles.fillPrimaryTL5);
  }

  /// Section Widget
  Widget _buildCancel(BuildContext context) {
    return CustomOutlinedButton(
        width: 161.h,
        text: "Cancel",
        margin: EdgeInsets.only(left: 8.h),
        buttonStyle: CustomButtonStyles.outlineRedTL5);
  }

  /// Section Widget
  Widget _buildBtns(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildAddPost(context), _buildCancel(context)])));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
