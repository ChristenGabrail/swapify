class ApiEndPoints {
  static final String baseUrl = "http://192.168.1.9:8000/";
  static AuthEndPoint authEndPoint = AuthEndPoint();
  static ItemEndPoint itemEdPoint = ItemEndPoint();
  static UserEndPoint userEndPoint = UserEndPoint();
  static RequestsEndPoint requestsEndPoint = RequestsEndPoint();
  static categoryEndPoint categoryEndpoint = categoryEndPoint();
  static ChatsEndPoint chatsEndPoint = ChatsEndPoint();
}

class AuthEndPoint {
  final String registerEmail = "User/register";
  final String loginEmail = "User/login";
}

class ItemEndPoint {
  final String getitem = "item";
  final String grtitembyID = "item/id/";
  final String createItem = "item";
  final String getlistitemforoneuser = "Request/listUserItems";
  final String getFav = "item/listSavedItems";
  final String deleteItem = "item/id/";
  final String updateItem = "item/id/";
  final String addTOsaved = "item/addtosaveditems/";
  final String deletefromsaved = "item/removeFromSavedItems/";
  final String getExpireditem = "item/getExpiredItems";
  final String getPendingItems = "item/getPendingItems";
  final String recentPost = 'item/RecentPosted';
}

class RequestsEndPoint {
  final String getlistitemforoneuser = "Request/listUserItems";
  final String sendRequest = "Request/addrequest";
  final String getRequests = "Request/getPendingExchangeRequests";
  final String getAcceptedRequests = "Request/getAcceptedExchangeRequests";
  final String getRejectedRequests = "Request/getRejectedExchangeRequests";
  final String AcceptORreject = 'Request/respondrequest/';
}

class UserEndPoint {
  final String UserInfo = "User/listUserInfo";
  final String userPhoto = "User/UploadUserPhoto";
  final String userUpdate = "User/updateUserInfo";
  final String changePass = "User/changePassword";
  final String userinfoByid = "User/getUserInfoById/";
  final String useritemsByid = 'item/userItemsid/';
}

class categoryEndPoint {
  final String getcategory = "categories/";
  final String getItemsOFCategory = 'categories/';
}

class ChatsEndPoint {
  final String getAllChat = "chat/getchats";
  final String getAllMess = "chat/getmess";
  final String sendMess = "chat/Sendmess";
  final String Sendphoto = "chat/Sendphoto";
}
