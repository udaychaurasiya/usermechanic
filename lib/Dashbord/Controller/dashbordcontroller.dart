import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:usermechanic/AppConstant/APIConstant.dart';
import 'package:usermechanic/Dashbord/Model/BannerModel.dart';
import 'package:usermechanic/Dashbord/Model/BookingServiceDetailsModel.dart';
import 'package:usermechanic/Dashbord/Model/CategryModel.dart';
import 'package:usermechanic/Dashbord/Model/ContactUs.dart';
import 'package:usermechanic/Dashbord/Model/FaqModel.dart';
import 'package:usermechanic/Dashbord/Model/NotificationModel.dart';
import 'package:usermechanic/Dashbord/Model/ServiceBrandModel.dart';
import 'package:usermechanic/Dashbord/Model/ShopDetailsModel.dart';
import 'package:usermechanic/Dashbord/Model/ShopListModel.dart';
import 'package:usermechanic/Dashbord/Model/TranscationModel.dart';
import 'package:usermechanic/Dashbord/View/Dashbord.dart';
import 'package:usermechanic/Splash/Onboarding_Screen.dart';
import 'package:usermechanic/auth/logincontroller.dart';
import 'package:usermechanic/mathod/AppConstant.dart';
import 'package:usermechanic/mathod/BaseClient.dart';
import 'package:usermechanic/mathod/BaseController.dart';
import '../Model/BookingModel.dart';

class HomePageController extends GetxController {
  var bannerModel = BannerModel().obs;
  GetStorage storage = GetStorage();
  List dataa2 = [];
  final ScrollController scrollController = ScrollController();
  final ScrollController BookingScroller = ScrollController();
  TextEditingController etMobile = TextEditingController();
  TextEditingController etName = TextEditingController();
  TextEditingController etZipCode = TextEditingController();
  TextEditingController etBikeCC = TextEditingController();
  TextEditingController etDate = TextEditingController();
  TextEditingController ServiceType = TextEditingController();
  TextEditingController SearchKey2 = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController bookingSearch = TextEditingController();
  TextEditingController etAddress = TextEditingController();
  TextEditingController Remark = TextEditingController();


  RxInt start = 0.obs;
  int end = 10;
  List<dynamic> bookingData = [];
  RxInt idProveType = 0.obs;
  RxString idProveType2 = "".obs;
  RxString Categary_Id = "".obs;
  RxInt selectedHomeIndex = 0.obs;
  RxInt bookingScoller = 0.obs;
  RxInt idBrandType = 0.obs;
  RxInt CategaryId = 0.obs;
  RxInt idServiceType = 0.obs;
  String SearchKey = '';
  RxInt ShopServiceId = 0.obs;
  RxInt idslotType = 0.obs;
  RxString IdProve = "".obs;
  RxString VinNo = "".obs;
  RxString selectValue = "All".obs;
  RxInt selectedIndex = 0.obs;
  RxBool isLoadingPage = false.obs;
  RxBool isBookingLoadingPage = false.obs;
  RxBool isBookingPagenation = false.obs;
  RxBool isLodingShopList = false.obs;
  LoginController loginController=Get.put(LoginController());
  var categryModel2 = CategryModel(data: []).obs;
  var categryModel = [].obs;

  var faqModel = FaqModel().obs;
  var shoplistModel = ShopListModel(data: []).obs;
  var bookingservicedetails = BookingServiceDeatilsModel().obs;
  var brandModel = BrandTypeModel(data: []).obs;
  var shopDetailsModel = ShopDeatilsModel().obs;
  var bookingmodel = BookingModel(data: []).obs;
  var notificationModel = NotificationModel().obs;
  var transcationModel = TranscationHistoryModel().obs;
  var contactUs = ContactUsModel().obs;
  final formKey = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  var currentIndex = 0.obs;
  GetStorage _storage = GetStorage();
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  var selectedValue = ''.obs;
  String image = "";
  String image2 = "";
  RxString current_address = "".obs;
  var shop_id = ''.obs;
  var shop_Details = ''.obs;
  var Transction_Details='';
  var CategryId = ''.obs;
  var mechanic_id=''.obs;
  int booktype = 0;
  var Booking;
  var Transction;
  var Booking_id2='';
  var Categry;
  var ShopDetails;
  RxString rxPath = "".obs;
  var address = ''.obs;
  @override
  void onInit() {
    getBannerNetworkApi();
    print("fdjkhgjkfg");
    addItems();
    getLocation();
    getAddressFromLatLong();
    super.onInit();
  }


  final shop = ShopListModel(data: []).data;

  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  /// get current address api integrate
  Future<void> getAddressFromLatLong() async {
    Position position = await getLocation();
    List<Placemark> placemarks=await placemarkFromCoordinates(position.latitude, position.longitude);
    latitude.value = position.latitude;
    longitude.value = position.longitude;
    print("lat ${position.latitude}");
    print("long ${position.longitude}");
    Placemark place = placemarks[0];
    current_address.value = "${place.street}, ${place.subLocality}, ${place.locality.toString()}, ${place.country}";
    etAddress.text = current_address.value;
  }




  Future<bool> postFeedbackRatingNetworkApi(String message,String rating) async
  {
    var bodyRequest =
    {
      "lng": language,
      "mechanic_id":shop_id.value,
      "user_id":_storage.read(AppConstant.id),
      "rating":rating,
      "description":message
    };
    print("djfgjh"+mechanic_id.value);
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .post(postfeedbackApi, bodyRequest)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();

    print("dgfghfhjj"+response);
    if (jsonDecode(response)["status"] == 1)
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      return true;
    }
    else
    {
      print("dfgfmdgjkdfhg");
      BaseController().successSnack(jsonDecode(response)["message"]);
      return false;
    }
  }


  setData() {
    etMobile.text = _storage.read(AppConstant.mobile) ?? "";
    etName.text = _storage.read(AppConstant.userName) ?? "";
  }

  DateRemove() async {
    etName.clear();
    etMobile.clear();
    etDate.clear();
    etBikeCC.clear();
    _storage.remove(AppConstant.vin_no_pic);
    _storage.remove(AppConstant.IdProve);
    VinNo.value = "";
    rxPath.value = "";
    idslotType.value = 0;
  }

  getBannerNetworkApi() async {
    var response = await BaseClient()
        .get("$getBannerApi?lng=eng")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      bannerModel.value = bannerModelFromJson(response);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  Future<dynamic>getCategryNetworkApi() async {
    categryModel2.value.data.clear();
    categryModel.value=[];
    var response = await BaseClient()
        .get("$getCategryApi?lng=eng")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      categryModel2.value = categryModelFromJson(response);
      categryModel.value = categryModel2.value.data;
      update();
      categryModel.refresh();
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getNotificationNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(
            "$getnotification?limit=1000&page=0&id=${_storage.read(AppConstant.id)}&type=1")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print(response + "dlifhugfg");
    if (jsonDecode(response)["status"] == 1) {
      notificationModel.value = notificationModelFromJson(response);
      return;
    }
  }

  Future<void> getServiceBrandType() async {
    var response = await BaseClient()
        .get("$getbrandType?lng=eng")
        .catchError(BaseController().handleError);
    print(response + "jkejfnbji");
    if (jsonDecode(response)["status"] == 1) {
      brandModel.value = brandTypeModelFromJson(response);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getFaqNetworkApi() async {
    var response = await BaseClient()
        .get("$getFaqApi?lng=eng&limit=100&page=0")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      faqModel.value = faqModelFromJson(response);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getShopDetailsNetworkApi(String id) async {
    var response = await BaseClient()
        .get("$getShopDetailsApi?shop_id=$id")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      shopDetailsModel.value = shopDeatilsModelFromJson(response);
      print("ewpodfjiohf" + response);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  Future<dynamic> getShopListNetworkApi(searchKey) async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get("$getShopListApi?lng=eng&limit=${10}&page=0&searchkey=$searchKey&category_id=")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("body response =================>>>>>>>>>>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      shoplistModel.value = shopListModelFromJson(response);
      isLoadingPage.value = true;
    }
    // isLoadingPage.value = false;
    // BaseController().errorSnack(jsonDecode(response)["message"]);
  }



  Future<dynamic> getOnRoadServiceApi(searchKey) async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get("$getShopListApi?lng=eng&limit=1000&page=0&searchkey=$searchKey&category_id=")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("body response =================>>>>>>>>>>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      shoplistModel.value = shopListModelFromJson(response);
    }
  }

  void getShopListSearchNetworkApi(searchKey) async {
    // Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(
        "$getShopListApi?lng=eng&limit=${10}&page=0&searchkey=$searchKey&category_id=")
        .catchError(BaseController().handleError);
    // Get.context!.loaderOverlay.hide();
    // print("body response =================>>>>>>>>>>>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      shoplistModel.value = shopListModelFromJson(response);
      isLoadingPage.value = false;
    }
    // isLoadingPage.value = false;
    // BaseController().errorSnack(jsonDecode(response)["message"]);
  }


  logout() async {
    _storage.remove(AppConstant.id);
    _storage.remove(AppConstant.userId);
    _storage.remove(AppConstant.userName);
    _storage.remove(AppConstant.profileImg);
    _storage.remove(AppConstant.email);
    _storage.remove(AppConstant.mobile);
    Get.delete<LoginController>();
    final _auth = FirebaseAuth.instance;
    final _googleSignIn = GoogleSignIn();
    await _auth.signOut();
    await _googleSignIn.signOut();
    Get.offAll(() => OnboardingScreen());
  }

  Future<bool> postcurrentaddressNetworkApi() async {
    var bodyRequest = {
      "user_id": _storage.read(AppConstant.id),
      "latitude": latitude.value.toString(),
      "longitude": longitude.value.toString(),
      "address": address.value.toString(),
    };
    print("fghfhf $bodyRequest");
    // Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .post(getcurrentaddressApi, bodyRequest)
        .catchError(BaseController().handleError);
    // Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      return true;
    }
    return false;
  }

  addItems() async {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {

        if (isLoadingPage.value == true /*&& selectedIndex.value==0&&selectedHomeIndex.value==0*/) {
          start.value = start.value + int.parse(shoplistModel.value.page!.toString());
          getShopListPagenationNetworkApi(start.value);
        }
        else if(isBookingLoadingPage==true)
        {
          start = start + int.parse(bookingmodel.value.page!.toString());
          getBookingPagenationDataNetworkApi(start.value,'','');
          print("jhgj");
        }
      }
    });
  }

  getShopListPagenationNetworkApi(int end) async {
    var response = await BaseClient()
        .get(
        "$getShopListApi?lng=eng&limit=${10}&page=$end&searchkey=&category_id=")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      if (isLoadingPage.value == true) {
        shoplistModel.value.data.addAll(shopListModelFromJson(response).data);
        shoplistModel.refresh();
        update();
        refresh();
      }
    } else {
      isLoadingPage.value = false;
      Fluttertoast.showToast(msg: "No more data available ! ");
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getBookingPagenationDataNetworkApi(int end,type, categoryId,) async {
    bookingmodel.value.data.clear();
    shimmer.value = true;
    var response = await BaseClient()
        .get(
        "$getBookingApi?limit=${10}&page=$end&searchkey=&category_id=$categoryId&user_id=${_storage.read(AppConstant.id)}&type=$type&mechanic_id=")
        .catchError(BaseController().handleError);
    shimmer.value = false;
    print("response ======>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      if(isBookingLoadingPage==true){
        bookingmodel.value = bookingModelFromJson(response);
        refresh();
        update();
        refresh();
      }
    }else{
      isBookingLoadingPage.value=false;
      Fluttertoast.showToast(msg: "No more data available ! ");
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
  }


  Future<bool> bookingNetworkApi(String id) async {
    var bodyRequest = {
      "lng": language,
      "user_id": _storage.read(AppConstant.id).toString(),
      "brand_id": idProveType2.value.toString(),
      "mobile_no": etMobile.text.toString(),
      "owner_name": etName.text.toString(),
      "bike_cc": etBikeCC.text.toString(),
      "service_type": id.toString(),
      "service_date": etDate.text.toString(),
      "slot_id": idslotType.value.toString(),
      "vin_no_pic": "",
      "id_prove": "",
      "booking_address": etAddress.text.toString(),
      "latitude": latitude.value.toString(),
      "longitude": longitude.value.toString(),
      "mechanic_id": "",
    };
    print("ekwjfoihfohe9ug $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient().BookingService(bodyRequest, PostBookApi, rxPath.value, VinNo.value)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("reponse =======>>>>>>>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      BaseController().successSnack(jsonDecode(response)["message"]);
      Get.to(() => const Dashbord());
      DateRemove();
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }

  ShopBookingServiceApi() async {
    var bodyRequest = {
      "lng": language,
      "user_id": _storage.read(AppConstant.id).toString(),
      "brand_id": idProveType2.value.toString(),
      "mobile_no": etMobile.text.toString(),
      "owner_name": etName.text.toString(),
      "bike_cc": etBikeCC.text.toString(),
      "service_type": Categary_Id.value.toString(),
      "service_date": etDate.text.toString(),
      "slot_id": idslotType.value.toString(),
      "vin_no_pic": "",
      "id_prove": "",
      "booking_address": etAddress.text.toString(),
      "latitude": latitude.value.toString(),
      "longitude": longitude.value.toString(),
      "mechanic_id": shop_id.value.toString()
    };
    print("ekwjfoihfohe9ug$bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .BookingService(
          bodyRequest,
          PostBookApi,
          rxPath.value,
          VinNo.value,
        )
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("gfgf $response");
    if (jsonDecode(response)["status"] == 1) {
      BaseController().successSnack(jsonDecode(response)["message"]);
      Get.to(() => Dashbord());
      DateRemove();
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
   var booking_id=''.obs;
  TransactionBookingApi(String Booking_id,String mechanic_id,String Amount ) async {
    var bodyRequest = {
      "lng": language,
      "user_id": _storage.read(AppConstant.id).toString(),
      "booking_id": Booking_id.toString(),
      "amount": Amount.toString(),
      "mechanic_id":mechanic_id.toString(),
      "status": "1",
      "transaction_id": "diohu9g8dfg78gt897gf",
      "remark": Remark.text.toString(),
    };
    print("ekwjfoihfohe9ug$bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .post(postTransctionApi,bodyRequest)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("gfgf $response");
    if (jsonDecode(response)["status"] == 1) {
      BaseController().successSnack(jsonDecode(response)["message"]);
      Get.to(() => Dashbord());
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  IDProve(bool isCamera) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 60);
      if (image != null) {
        rxPath.value = image.path;
      }
    } on Exception catch (e) {
      print("cxjkbjvkbsdjv$e");
    }
  }

  VINNOPIC(bool isCamera) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 60);
      if (image != null) {
        VinNo.value = image.path;
      }
    } on Exception catch (e) {
      print("cxjkbjvkbsdjv$e");
    }
  }

  // Future<dynamic> getBookingNetworkApi() async {
  //   Get.context!.loaderOverlay.show();
  //   var response = await BaseClient()
  //       .get(
  //           "$getBookingApi?limit=500&page=0&searchkey=&category_id=&user_id=${_storage.read(AppConstant.id)}")
  //       .catchError(BaseController().handleError);
  //   Get.context!.loaderOverlay.hide();
  //   if (jsonDecode(response)["status"] == 1) {
  //     bookingmodel.value = bookingModelFromJson(response);
  //     return;
  //   }
  //   BaseController().errorSnack(jsonDecode(response)["message"]);
  // }

  RxInt indexValue = 0.obs;
  RxBool shimmer = false.obs;

  Future<dynamic> getBookingAllDataNetworkApi(type, categoryId, searchKey) async {
    bookingmodel.value.data.clear();
    // Get.context!.loaderOverlay.show();
    shimmer.value = true;
    var response = await BaseClient()
        .get(
            "$getBookingApi?limit=500&page=0&searchkey=$searchKey&category_id=$categoryId&user_id=${_storage.read(AppConstant.id)}&type=$type&mechanic_id=")
        .catchError(BaseController().handleError);
    // Get.context!.loaderOverlay.hide();
    shimmer.value = false;
    print("response ======>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      bookingmodel.value = bookingModelFromJson(response);
      // isBookingLoadingPage.value=true;
      // refresh();
      // update();
    }
    // BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getBookingAllDataSearchNetworkApi(type, categoryId, searchKey) async {
    bookingmodel.value.data.clear();
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(
        "$getBookingApi?limit=500&page=0&searchkey=$searchKey&category_id=$categoryId&user_id=${_storage.read(AppConstant.id)}&type=$type&mechanic_id=")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ======>>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      bookingmodel.value = bookingModelFromJson(response);
      refresh();
      update();
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }


  getContactUsNetworkApi() async {
    var response = await BaseClient()
        .get("$getContactUsApi?lng=eng")
        .catchError(BaseController().handleError);

    if (jsonDecode(response)["status"] == 1) {
      contactUs.value = contactUsModelFromJson(response);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getBookingServiceDetails(String id) async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get("$bookingdetails?booking_id=$id")
        .catchError(BaseController().handleError);
    print(response + "eljkfhy8g");
    print(id);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      bookingservicedetails.value =
          bookingServiceDeatilsModelFromJson(response);
      // BaseController().successSnack(jsonDecode(response)["message"]);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  Future<bool> getTransctionDetails(String id) async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get("$bookingdetails?booking_id=$id")
        .catchError(BaseController().handleError);
    print(response + "eljkfhy8g");
    print(id);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      bookingservicedetails.value = bookingServiceDeatilsModelFromJson(response);
      return  true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return  false;
  }

  Future<dynamic> getSerachNetworkApi() async {
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get(
            "$getBookingSearch?limit=100&page=0&searchkey=$SearchKey&category_id=1")
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      bookingmodel.value = bookingModelFromJson(response);
      // BaseController().successSnack(jsonDecode(response)["message"]);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  Future<dynamic> getTransctionHistoryApi(searchKey) async {
    shimmer.value = true;
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .get("$TransctionHistoryApi?limit=1000&page=0&user_id=${_storage.read(AppConstant.id)}&searchkey=$searchKey")
        .catchError(BaseController().handleError);
    shimmer.value = true;
    Get.context!.loaderOverlay.hide();
    print(response+"ekfhuigf");
    if (jsonDecode(response)["status"] == 1) {
      transcationModel.value = transcationHistoryModelFromJson(response);
      // BaseController().successSnack(jsonDecode(response)["message"]);
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }
}
