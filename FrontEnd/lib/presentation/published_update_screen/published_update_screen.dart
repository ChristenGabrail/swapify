import 'package:cached_network_image/cached_network_image.dart';
import 'package:christine_s_application20/presentation/home_page/home_page.dart';
import 'package:christine_s_application20/presentation/published_tab_container_screen/published_tab_container_screen.dart';
import 'package:christine_s_application20/widgets/custom_icon_button.dart';
import 'package:christine_s_application20/widgets/custom_elevated_button.dart';
import 'package:christine_s_application20/widgets/custom_outlined_button.dart';
import 'package:christine_s_application20/widgets/custom_text_form_field.dart';
import 'package:christine_s_application20/widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';
import '../../api/apimethods.dart';
import '../../main.dart';
import '../../models/categoryModel.dart';
import '../../models/itemModel.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class PublishedUpdateScreen extends StatefulWidget {
  final String id;

  PublishedUpdateScreen({Key? key, required this.id})
      : super(
          key: key,
        );

  @override
  State<PublishedUpdateScreen> createState() => _PublishedUpdateScreenState();
}

class _PublishedUpdateScreenState extends State<PublishedUpdateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<dynamic> dropdownItemList = [];
  String? token = sharedPreferences.getString('token');

  TextEditingController priceController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  late List<CategoryModel> _Category;
  bool is_loading = true;
  //late String dropdownValue; // Default value for the dropdown
  String dropdownValue = 'New'; // Default value for the dropdown

  Item? _item;
  bool _isLoading = true;
  //late String _currentSelectedValue;
  String _currentSelectedValue = "65d0ee25d0b5196047e68972";

  bool drop_Loading = true;

  @override
  void initState() {
    super.initState();
    initializeItem();
  }

  Future<void> initializeItem() async {
    _item = await ApisMethods.getitembyID(widget.id);
    _currentSelectedValue = '${_item?.CategoryID}';
    dropdownValue = _item?.condition == true ? 'New' : 'Used';
    titleController = TextEditingController(text: _item!.Title);
    priceController = TextEditingController(text: _item!.Price.toString());
    /*descriptionController =
        TextEditingController(text: _item!.Description.toString());*/
    if (_item != null) {
      _Category = (await ApisMethods.getAllCategories());
      setState(() {
        is_loading = false;
        _isLoading = false;
        drop_Loading = false;
        dropdownItemList.addAll(_Category);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        resizeToAvoidBottomInset: false,
        body: _isLoading && is_loading && drop_Loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: AppDecoration.fillBlueGray,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 1.v,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primaryContainer
                                        .withOpacity(1),
                                  ),
                                ),
                                SizedBox(height: 39.v),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 7.h),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.h,
                                    vertical: 16.v,
                                  ),
                                  decoration: AppDecoration.white.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder15,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: '${_item?.image.trim()}',
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        height: 150.v,
                                        width: 250.h,
                                        alignment: Alignment.center,
                                      ),
                                      SizedBox(height: 4.v),
                                      _buildHeader(
                                        context,
                                        description: "Title",
                                      ),
                                      SizedBox(height: 4.v),
                                      _buildInput(context),
                                      SizedBox(height: 17.v),
                                      _buildHeader(
                                        context,
                                        description: "Description",
                                      ),
                                      SizedBox(height: 2.v),
                                      _buildInput1(context),
                                      SizedBox(height: 18.v),
                                      _buildHeader(
                                        context,
                                        description: "Category",
                                      ),
                                      SizedBox(height: 1.v),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.h),
                                          child: is_loading || drop_Loading
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : DropdownButton<String>(
                                                  value: _currentSelectedValue,
                                                  //hint: Text("category"),
                                                  alignment: Alignment.center,
                                                  items: dropdownItemList
                                                      .map((item) {
                                                    return DropdownMenuItem(
                                                      value: item
                                                              .CategoryModelID
                                                          .toString(), // Assuming each item has an 'id'
                                                      child: Text(item
                                                          .Name), // Assuming each item has a 'name'
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    _currentSelectedValue =
                                                        value!;
                                                    setState(() {});
                                                  },
                                                )),
                                      SizedBox(height: 16.v),
                                      _buildHeader(
                                        context,
                                        description: "Price (L.E)",
                                      ),
                                      SizedBox(height: 3.v),
                                      _buildPrice(context),
                                      SizedBox(height: 15.v),
                                      _buildHeader(
                                        context,
                                        description: "Contion",
                                      ),
                                      SizedBox(height: 1.v),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.h),
                                        child: drop_Loading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : DropdownButton<String>(
                                                value: dropdownValue,
                                                iconSize: 24,
                                                elevation: 16,
                                                items: <String>[
                                                  'New',
                                                  'Used'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
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
                                      SizedBox(height: 10.v),
                                      _buildBtns(context),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.v),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  /// Section Widget
  Widget _buildInput(BuildContext context) {
    return CustomTextFormField(
      controller: titleController,
      hintText: "${_item?.Title}",
    );
  }

  /// Section Widget
  Widget _buildInput1(BuildContext context) {
    return CustomTextFormField(
      controller: descriptionController,
      hintText: "${_item?.Description}",
    );
  }

  /// Section Widget
  Widget _buildPrice(BuildContext context) {
    return CustomTextFormField(
      controller: priceController,
      hintText: "${_item?.Price}",
      textInputAction: TextInputAction.done,
    );
  }

  /// Section Widget
  Widget _buildUpdate(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 41.v,
        text: "Update",
        onPressed: () {
          ApisMethods.updateItem(
              token!,
              priceController.text,
              titleController.text,
              _item!.image.toString(),
              descriptionController.text,
              dropdownValue == 'New' ? true : false,
              _currentSelectedValue,
              widget.id);
        },
        margin: EdgeInsets.only(right: 4.h),
        buttonStyle: CustomButtonStyles.fillPrimaryTL5,
      ),
    );
  }

  /// Section Widget
  Widget _buildDiscard(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        text: "Discard",
        onPressed: () => Navigator.pop(context),
        margin: EdgeInsets.only(left: 4.h),
        buttonStyle: CustomButtonStyles.outlineRedTL5,
      ),
    );
  }

  /// Section Widget
  Widget _buildBtns(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildUpdate(context),
        _buildDiscard(context),
      ],
    );
  }

  /// Common widget
  Widget _buildHeader(
    BuildContext context, {
    required String description,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          style: CustomTextStyles.titleMediumMedium.copyWith(
            color: appTheme.teal900,
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgSolarPenOutline,
          height: 15.adaptSize,
          width: 15.adaptSize,
          margin: EdgeInsets.only(
            top: 2.v,
            bottom: 6.v,
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 42.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftTeal900,
            margin: EdgeInsets.only(left: 18.h, top: 14.v, bottom: 14.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarTitle(
            text: "Published Items", margin: EdgeInsets.only(left: 16.h)),
        styleType: Style.bgOutline);
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
