import 'package:christine_s_application20/presentation/requests_page/widgets/ARrequests_item_widget.dart';
import '../../api/apimethods.dart';
import '../../main.dart';
import '../../models/RequestModel.dart';
import '../../models/itemModel.dart';
import '../view_request_screen/view_request_screen.dart';
import 'widgets/requests_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:christine_s_application20/core/app_export.dart';

class AcceptedRequestsPage extends StatefulWidget {
  const AcceptedRequestsPage({Key? key}) : super(key: key);

  @override
  AcceptedRequestsPageState createState() => AcceptedRequestsPageState();
}

class AcceptedRequestsPageState extends State<AcceptedRequestsPage>
    with AutomaticKeepAliveClientMixin<AcceptedRequestsPage> {
  @override
  bool get wantKeepAlive => true;
  String? token = sharedPreferences.getString('token');

  List<Request> requests = [];
  bool isLoadingRequests = true;
  bool ForALL = true;

  Future<void> getRequests() async {
    try {
      requests = await ApisMethods.getAcceptedrequests(token!);
      if (mounted) {
        setState(() {
          isLoadingRequests = false;
        });
      }
    } catch (e) {
      // Handle error
      print("Error fetching requests: $e");
      if (mounted) {
        setState(() {
          isLoadingRequests = false;
        });
      }
    }
  }

  Future<void> fetchItemsAndUsers() async {
    if (requests.isEmpty) {
      setState(() {
        ForALL = false;
      });
      return;
    }

    try {
      await Future.wait(requests.map((request) async {
        // Fetch item1
        request.item1 =
            await ApisMethods.getitembyID(request.Item_requested_id);
        // Fetch item2
        request.item2 = await ApisMethods.getitembyID(request.Item_offered_id);
        // Fetch user
        request.user =
            await ApisMethods.getuserinfoForItem(request.requester_id);
      }));

      if (mounted) {
        setState(() {
          ForALL = false;
        });
      }
    } catch (e) {
      // Handle error
      print("Error fetching item or user: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await getRequests();
    await fetchItemsAndUsers();
  }

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Don't forget to call super.build when using AutomaticKeepAliveClientMixin
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.white,
          child: Column(
            children: [
              SizedBox(height: 31.v),
              ForALL
                  ? Center(child: CircularProgressIndicator())
                  : requests.isNotEmpty
                      ? Expanded(child: _buildRequests(context))
                      : Center(child: Text('No Requests Found')),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRequests(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.h),
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 16.v),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return ARRequestsItemWidget(
            image: requests[index].user!.image,
            RequestID: requests[index].RequestId,
            RequesterName: requests[index].user!.username,
            firstItem: requests[index].item1!.Title,
            secondItem: requests[index].item2!.Title,
          );
        },
      ),
    );
  }
}
