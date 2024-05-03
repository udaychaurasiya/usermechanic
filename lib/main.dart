import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:usermechanic/Dashbord/View/Dashbord.dart';
import 'package:usermechanic/Splash/Onboarding_Screen.dart';
import 'package:usermechanic/mathod/AppConstant.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String title = 'RepairDo';
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayOpacity: 0.1,
          overlayColor: Colors.white.withOpacity(.1),
          overlayWidget: Center(
            child: Container(
                height: 41,
                width: 41,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 3.5,
                )
            ),
          ),
          child: GetMaterialApp(
            title: title,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: GetStorage().read(AppConstant.userName)!=null&&
            GetStorage().read(AppConstant.userName).toString().isNotEmpty?
            const Dashbord(): const OnboardingScreen(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
