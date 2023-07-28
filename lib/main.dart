import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:third_hand_2_0/category/category_list_screen.dart';
import 'package:third_hand_2_0/category/subcategory_screen.dart';
import 'package:third_hand_2_0/constants/colors.dart';
import 'package:third_hand_2_0/form/common_form.dart';
import 'package:third_hand_2_0/form/user_form_review.dart';
import 'package:third_hand_2_0/provider/category_provider.dart';
import 'package:third_hand_2_0/provider/product_provider.dart';
import 'package:third_hand_2_0/request_display/Requests/product_details_screen.dart';
import 'package:third_hand_2_0/screens/auth/email_verify_screen.dart';
import 'package:third_hand_2_0/screens/auth/login_screen.dart';
import 'package:third_hand_2_0/screens/auth/phone_auth_screen.dart';
import 'package:third_hand_2_0/screens/auth/register_screen.dart';
import 'package:third_hand_2_0/screens/auth/reset_password_screen.dart';
import 'package:third_hand_2_0/screens/home_screen.dart';
import 'package:third_hand_2_0/screens/location_screen.dart';
import 'package:third_hand_2_0/screens/main_navigatiion_screen.dart';
import 'package:third_hand_2_0/screens/profile_screen.dart';
import 'package:third_hand_2_0/screens/splash_screen.dart';
import 'package:third_hand_2_0/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: blackColor,
          backgroundColor: whiteColor,
          fontFamily: 'Oswald',
          scaffoldBackgroundColor: whiteColor,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.screenId,
        routes: {
          
          
          
          
          
          SplashScreen.screenId: (context) => const SplashScreen(),
          LoginScreen.screenId: (context) => const LoginScreen(),
          PhoneAuthScreen.screenId: (context) => const PhoneAuthScreen(),
          WelcomeScreen.screenId: (context) => const WelcomeScreen(),
          RegisterScreen.screenId: (context) => const RegisterScreen(),
          EmailVerifyScreen.screenId: (context) => const EmailVerifyScreen(),
           HomeScreen.screenId: (context) => const HomeScreen(),
          ResetPasswordScreen.screenId: (context) =>
              const ResetPasswordScreen(),
              
          LocationScreen.screenId: (context) => const LocationScreen(),
          MainNavigationScreen.screenId: (context) =>
              const MainNavigationScreen(),
              CategoryListScreen.screenId: (context) => const CategoryListScreen(),
               SubCategoryScreen.screenId: (context) => const SubCategoryScreen(),
       
           ProfileScreen.screenId: (context) => const ProfileScreen(),
            CommonForm.screenId: (context) => const CommonForm(),
             UserFormReview.screenId: (context) => const UserFormReview(),
              ProductDetail.screenId: (context) => const ProductDetail(),
            
        });
  }
}
