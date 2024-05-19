
import 'package:get/get.dart';
import 'package:moharrek/bottom_nav_bar.dart';
import 'package:moharrek/pages/auction/auction_page.dart';
import 'package:moharrek/pages/auction/car_details_page.dart';
import 'package:moharrek/pages/auth/binding/auth_binding.dart';
import 'package:moharrek/pages/auth/otp_validation_page.dart';
import 'package:moharrek/pages/auth/register_page.dart';
import 'package:moharrek/pages/auth/username_page.dart';
import 'package:moharrek/pages/home/binding/car_binding.dart';
import 'package:moharrek/pages/home/home_page.dart';
import 'package:moharrek/pages/home/new_car_details_page.dart';
import 'package:moharrek/pages/home/used_car_details_page.dart';
import 'package:moharrek/pages/profile/add_car_page.dart';
import 'package:moharrek/pages/profile/pdf_viewer_page.dart';
import 'package:moharrek/pages/profile/profile_page.dart';
import 'package:moharrek/pages/profile/unavaliable_cars_page.dart';
class AppPages{
  static const String registerPage = '/registerPage';
  static const String otpPage = '/OtpPage';
  static const String userName = '/userNamePage';
  static const String homePage = '/homePage';
  static const String auctionPage = '/auctionPage';
  static const String auctionDetailsPage = '/auctionDetailsPage';
  static const String addCarPage = '/addCarPage';
  static const String newCarDetailsPage = '/newCarDetailsPage';
  static const String usedCarDetailsPage = '/usedCarDetailsPage';
  static const String profilePage = '/profilePage';
  static const String unAvailableCarsPage = '/unAvailableCarsPage';
  static const String pdfViewer = '/pdfViewer';
  static var appPages = [
    GetPage(binding: AuthBinding(), name: profilePage, page: () => const ProfilePage(),),
    GetPage(name: pdfViewer, page: () => PdfViewerPage(),),
    GetPage(binding: AuthBinding(), name: registerPage, page: () => const RegisterPage(),),
    GetPage(binding: AuthBinding(), name: addCarPage, page: () =>  AddCarPage(),),
    GetPage(binding: AuthBinding(),name: otpPage, page: () =>  OTPValidationPage(),),
    GetPage(binding: AuthBinding(),name: userName, page: () => const UsernamePage(),),
    GetPage(binding: CarBinding(),name: auctionDetailsPage, page: () =>  AuctionCarDetailPage(),),
    GetPage(binding: CarBinding(),name: unAvailableCarsPage, page: () =>   UnAvailableCarsPage(),),
    GetPage(binding: CarBinding(),name: newCarDetailsPage, page: () =>  NewCarDetailsPage(),),
    GetPage(binding: CarBinding(),name: usedCarDetailsPage, page: () =>  UsedCarDetailsPage(),),
    GetPage(bindings: [CarBinding(),AuthBinding()],name: homePage, page: () => const BottomNavBar(),),
    GetPage(binding: CarBinding(),name: auctionPage, page: () => const AuctionPage(),),
  ];
}