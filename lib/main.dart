import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moharrek/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moharrek/pages/home/controller/carController.dart';
import 'package:moharrek/shared_pref.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preference.shared.instance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  CarController().removeAuctionFromCar('carId7', 'participantId70');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          fontFamily: "NotoKufiArabic",
          textTheme: const TextTheme(
            bodySmall: TextStyle(
              fontFamily: "NotoKufiArabic",
              fontSize: 14,
            ),
            bodyMedium: TextStyle(fontFamily: "NotoKufiArabic", fontSize: 16),
            bodyLarge: TextStyle(fontFamily: "NotoKufiArabic", fontSize: 18),
            titleSmall: TextStyle(
                fontFamily: "NotoKufiArabic",
                fontSize: 22,
                fontWeight: FontWeight.bold),
            titleMedium: TextStyle(
                fontFamily: "NotoKufiArabic",
                fontSize: 28,
                fontWeight: FontWeight.bold),
            titleLarge: TextStyle(
                fontFamily: "NotoKufiArabic",
                fontSize: 36,
                fontWeight: FontWeight.bold),
          )),
      initialRoute: FirebaseAuth.instance.currentUser!=null?checkUserName():AppPages.registerPage,
      // home: const Directionality(
      //   textDirection: TextDirection.rtl,
      //   child: RegisterPage(),
      // ),
      getPages: AppPages.appPages,
    );
  }
  checkUserName(){
    if(Preference.shared.getUserId()!.isEmpty){
      return AppPages.registerPage;
    }else if(Preference.shared.getUserName()!.isNotEmpty){
      return AppPages.homePage;
    }else{
      return AppPages.homePage;
    }
  }
}


// BottomNavBar