import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:usermechanic/AppConstant/APIConstant.dart';
import 'package:usermechanic/Dashbord/View/Dashbord.dart';
import 'package:usermechanic/auth/Model/PrivacyModel.dart';
import 'package:usermechanic/auth/Model/TermConditionModel.dart';
import 'package:usermechanic/loginScreen/OtpVerify.dart';
import 'package:usermechanic/loginScreen/Registration.dart';
import 'package:usermechanic/mathod/AppConstant.dart';
import 'package:usermechanic/mathod/BaseClient.dart';
import 'package:usermechanic/mathod/BaseController.dart';


class LoginController extends GetxController {
  OtpFieldController otpController = OtpFieldController();
  TextEditingController etMobile = TextEditingController();
  TextEditingController etZipCode = TextEditingController();
  TextEditingController etName = TextEditingController();
  TextEditingController etIdProve = TextEditingController();
  TextEditingController etAddress = TextEditingController();
  TextEditingController etEmail = TextEditingController();
  final RoundedLoadingButtonController googleController = RoundedLoadingButtonController();
  RxInt etIdProvetype=0.obs;
  RxInt minutes = 1.obs;
  RxInt seconds = 0.obs;
  RxString FCM_TOKEN = "".obs;
  RxString rxPath="".obs;
  String image="";
  RxDouble longitude = 0.0.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble long = 0.0.obs;
  RxDouble lat = 0.0.obs;
  RxString current_address = "".obs;
  RxString Address = "".obs;
  Timer? timer;
  GetStorage _storage=GetStorage();
  var privacymodel=PrivacyModel().obs;
  var termcondition=TermConditionModel().obs;

  loginNetworkApi() async {
    final fcmTokan=await FirebaseMessaging.instance.getToken();
    var bodyRequest = {
      "lng": language,
      "mobile": etMobile.text.toString(),
      "device_id": "",
      "fcm_id": fcmTokan.toString(),
    };
    print("request >>>>>>>>>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .post(SignIn, bodyRequest)
        .catchError(BaseController().handleError);
    print("Mobile No : ${etMobile.text}");
    print(response);
    Get.context!.loaderOverlay.hide();
    if (jsonDecode(response)["status"] == 1) {
      // isLoading.value = true;
      BaseController().successSnack(jsonDecode(response)["message"]+ " " + jsonDecode(response)["Data"]["otp"]);
      Get.to(() => OtpVeriffy(id: jsonDecode(response)["Data"]["id"] ?? "",otp: jsonDecode(response)["Data"]["otp"] ?? "",));
      return;
    }
    _storage.write(AppConstant.fcm_token, jsonDecode(response)["Data"]["fcm_id"] ?? "");
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }


  // loginNetworkApi() async{
  //   final fcmToken = await FirebaseMessaging.instance.getToken();
  //   var bodyRequest={
  //     "mobile":etMobile.text.toString(),
  //     "device_id":"",
  //     "fcm_id":fcmToken.toString(),
  //   };
  //    Get.context!.loaderOverlay.show();
  //    var response=await BaseClient().post(SignIn, bodyRequest).catchError(BaseController().handleError);
  //    Get.context!.loaderOverlay.hide();
  //   print("vsdfbfd"+fcmToken.toString());
  //   print("edhuiguguif $bodyRequest");
  //   if(jsonDecode(response)["status"]==1)
  //   {
  //     BaseController().successSnack(jsonDecode(response)["message"]+" "+jsonDecode(response)["Data"]["otp"]);
  //     Get.offAll(()=>OtpVeriffy(id: jsonDecode(response)["Data"]["id"]??"",otp:jsonDecode(response)["Data"]["otp"]??""));
  //     return;
  //   }
  //   _storage.write(AppConstant.fcm_token, jsonDecode(response)["Data"]["fcm_id"] ?? "");
  //   BaseController().errorSnack(jsonDecode(response)["message"]);
  // }

  setEtDataController()
  {
    etName.text=_storage.read(AppConstant.userName)??"";
    etEmail.text=_storage.read(AppConstant.email)??"";
    etMobile.text=_storage.read(AppConstant.mobile)??"";
    etZipCode.text=_storage.read(AppConstant.zipcode)??"";
  }
  setData()
  {
    etMobile.text=_storage.read(AppConstant.mobile);
  }

  // verifyNetworkApi(String id,String otp)async{
  //   var bodyRequest={
  //     "lng":language,
  //     "id":id.toString(),
  //     "otp":otp.toString(),
  //   };
  //   print("guggy $bodyRequest");
  //   Get.context!.loaderOverlay.show();
  //   var response=await BaseClient().post(OtpVerify, bodyRequest).catchError(BaseController().handleError);
  //   print(response+"khdiogu");
  //   Get.context!.loaderOverlay.hide();
  //   if(jsonDecode(response)["status"]==1) {
  //     if (jsonDecode(response)["Data"].isNotEmpty) {
  //       if(jsonDecode(response)["Data"]["id"].toString().isNotEmpty && jsonDecode(response)["Data"]
  //       ["email"].toString().isNotEmpty)
  //       {
  //         _storage.write(AppConstant.id, jsonDecode(response)["Data"]["id"]??"");
  //         _storage.write(AppConstant.mobile, jsonDecode(response)["Data"]["mobile"]??"");
  //         _storage.write(AppConstant.userId, jsonDecode(response)["Data"]["user_login"]??"");
  //         _storage.write(AppConstant.userName, jsonDecode(response)["Data"]["name"]??"");
  //         _storage.write(AppConstant.profileImg, jsonDecode(response)["Data"]["profile"]??"");
  //         _storage.write(AppConstant.zipcode, jsonDecode(response)["Data"]["zip_code"]??"");
  //         _storage.write(AppConstant.email, jsonDecode(response)["Data"]["email"]??"");
  //          setEtDataController();
  //          Get.offAll(() => Dashbord());
  //         }
  //        else{
  //         _storage.write(AppConstant.id, jsonDecode(response)["Data"]["id"]??"");
  //         _storage.write(AppConstant.mobile, jsonDecode(response)["Data"]["mobile"]??"");
  //         Get.to(() => Registration());
  //       }
  //       BaseController().successSnack(jsonDecode(response)["message"]);
  //     }
  //   }
  //   else{
  //     BaseController().errorSnack(jsonDecode(response)["message"]);
  //   }
  //
  // }


  /// get current location address
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


  Future<bool> verifyNetworkkApi(String id, String otp) async {
    var bodyRequest = {
      "lng": language,
      "id": id.toString(),
      "otp": otp.toString(),
    };
    print("body ==>>>>> $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response = await BaseClient()
        .post(OtpVerify, bodyRequest)
        .catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print("response ===>>>>>> $response");
    if (jsonDecode(response)["status"] == 1) {
      if (jsonDecode(response)["Data"].isNotEmpty) {
        if (jsonDecode(response)["Data"]["id"].toString().isNotEmpty
            && jsonDecode(response)["Data"]["email"].toString().isNotEmpty) {
          _storage.write(AppConstant.id, jsonDecode(response)["Data"]["id"]??"");
          _storage.write(AppConstant.mobile, jsonDecode(response)["Data"]["mobile"]??"");
          _storage.write(AppConstant.userId, jsonDecode(response)["Data"]["user_login"]??"");
          _storage.write(AppConstant.userName, jsonDecode(response)["Data"]["name"]??"");
          _storage.write(AppConstant.profileImg, jsonDecode(response)["Data"]["profile"]??"");
          _storage.write(AppConstant.zipcode, jsonDecode(response)["Data"]["zip_code"]??"");
          _storage.write(AppConstant.email, jsonDecode(response)["Data"]["email"]??"");
          setEtDataController();
          Get.offAll(() => Dashbord());
          BaseController().successSnack(jsonDecode(response)["message"]);
        } else {
          _storage.write(AppConstant.id, jsonDecode(response)["Data"]["id"]??"");
          _storage.write(AppConstant.mobile, jsonDecode(response)["Data"]["mobile"]??"");
          Get.to(() => Registration());
        }
      } else {
      }
      return true;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
    return false;
  }



  signUpNetworkApi()async
  {
    var bodyRequest=
    {
      "lng":language,
      "mobile":_storage.read(AppConstant.mobile).toString().trim(),
      "zip_code":etZipCode.text.toString(),
      "name":etName.text.toString(),
      "email":etEmail.text.toString(),
      "gender":"",
      // "id_prove_no":etIdProve.text.toString(),
      // "address":etAddress.text.toString(),
      // "id_prove_type":etIdProvetype.value.toString(),
      "id":_storage.read(AppConstant.id).toString().trim(),
      "profile":"",
    };
     print("ekwjfoihfohe9ug$bodyRequest");
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().post(signUpApi,bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if(jsonDecode(response)["status"]==1)
    {
      BaseController().successSnack(jsonDecode(response)["message"]);
      _storage.write(AppConstant.mobile, jsonDecode(response)["Data"]["mobile"]??"");
      _storage.write(AppConstant.userId, jsonDecode(response)["Data"]["user_login"]??"");
      _storage.write(AppConstant.userName, jsonDecode(response)["Data"]["name"]??"");
      _storage.write(AppConstant.profileImg, jsonDecode(response)["Data"]["profile"]??"");
      _storage.write(AppConstant.zipcode, jsonDecode(response)["Data"]["zip_code"]??"");
      _storage.write(AppConstant.email, jsonDecode(response)["Data"]["email"]??"");
      _storage.write(AppConstant.address, jsonDecode(response)["Data"]["address"]??"");
      // _storage.write(AppConstant.gender, jsonDecode(response)["Data"]["gender"]??"");

      Get.offAll(() => Dashbord());
      return;
    }
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }


  UpdateNetworkApi()async {
    var bodyRequest=
    {
      "lng":language,
      "mobile":etMobile.text.toString(),
      "zip_code":etZipCode.text.toString(),
      "name":etName.text.toString(),
      "email":etEmail.text.toString(),
      "id_prove_no":etIdProve.text.toString(),
      "address":etAddress.text.toString(),
      "id_prove_type":etIdProvetype.value.toString(),
      "id":_storage.read(AppConstant.id).toString().trim(),
      "gender":"",
      "profile":"",
    };
    print("ekwjfoihfohe9ug$bodyRequest");
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().profileUpdate(rxPath.value,bodyRequest,signUpApi).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    print(response+"erfhiug");
    if(jsonDecode(response)["status"]==1)
    {
      // BaseController().successSnack(jsonDecode(response)["message"]);
      _storage.write(AppConstant.mobile, jsonDecode(response)["Data"]["mobile"]??"");
      _storage.write(AppConstant.userId, jsonDecode(response)["Data"]["user_login"]??"");
      _storage.write(AppConstant.userName, jsonDecode(response)["Data"]["name"]??"");
      _storage.write(AppConstant.profileImg, jsonDecode(response)["Data"]["profile"]??"");
      _storage.write(AppConstant.zipcode, jsonDecode(response)["Data"]["zip_code"]??"");
      _storage.write(AppConstant.email, jsonDecode(response)["Data"]["email"]??"");
      _storage.write(AppConstant.address, jsonDecode(response)["Data"]["address"]??"");
      // Get.back();
      Get.offAll(()=>Dashbord());
      BaseController().successSnack(jsonDecode(response)["message"]);
      return;
    }

    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  chooseImage(bool isCamera)async{
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source:isCamera?
      ImageSource.camera:ImageSource.gallery,imageQuality: 60);
      if(image!=null)
      {
        rxPath.value=image.path;
      }
    } on Exception catch (e) {
      print("cxjkbjvkbsdjv"+e.toString());
    }

  }

  getCscNetworkApi() async {
    var response = await BaseClient()
        .get(getPrivacy + "?lng=eng")
        .catchError(BaseController().handleError);
    print("vdfvsds");
    print(response);
    if (jsonDecode(response)["status"] == 1) {
      privacymodel.value = privacyModelFromJson(response);
      return;
    }
    privacymodel.value = privacyModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }

  getTermAndCondition() async {
    var response = await BaseClient()
        .get(getTermCondition + "?lng=eng")
        .catchError(BaseController().handleError);
    print("vdfvsds");
    print(response);
    if (jsonDecode(response)["status"] == 1) {
      termcondition.value = termConditionModelFromJson(response);
      return;
    }
    termcondition.value = termConditionModelFromJson(response);
    BaseController().errorSnack(jsonDecode(response)["message"]);
  }


  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0.0) {
        seconds.value--;
      } else {
        if (minutes.value > 0.0) {
          minutes.value--;
          seconds.value = 30;
        } else {
          timer.cancel();
        }
      }
    });
  }
  void resetTimer() {
    timer?.cancel();
    minutes.value = 1;
    seconds.value = 0;
    startTimer();
    Future.delayed(const Duration(milliseconds: 500));
  }

  signUpwithSocialLoginNetworkApi(UserCredential userCredential,String deviceId)async
  {
    final user = userCredential.user;

    var bodyRequest={
      "lng":language,
      "name":user?.displayName.toString(),
      "email":user?.email.toString(),
      "mobile":" ",
      "device_id":" ",
      "fcm_id":FCM_TOKEN.value.toString(),
    };
    print("niuhh7gf   $bodyRequest");
    Get.context!.loaderOverlay.show();
    var response=await BaseClient().post(socialSignUp, bodyRequest).catchError(BaseController().handleError);
    Get.context!.loaderOverlay.hide();
    if(jsonDecode(response)["status"]==1)
    {
      print(response+"jkfgyfyvf");
      BaseController().successSnack(jsonDecode(response)["message"]);
      _storage.write(AppConstant.id, jsonDecode(response)["Data"]["id"]??"");
      _storage.write(AppConstant.userId, jsonDecode(response)["Data"]["user_login"]??"");
      _storage.write(AppConstant.userName, jsonDecode(response)["Data"]["name"]??"");
      _storage.write(AppConstant.profileImg, jsonDecode(response)["Data"]["profile"]??"");
      _storage.write(AppConstant.email, jsonDecode(response)["Data"]["email"]??"");
      Get.offAll(() => Dashbord());
      return;
    }
    else {
      final _auth = FirebaseAuth.instance;
      final _googleSignIn = GoogleSignIn();
      await _auth.signOut();
      await _googleSignIn.signOut();
      BaseController().errorSnack(jsonDecode(response)["message"]);
    }
  }


}
