import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailwag/controller/admin_controller.dart';
import 'package:tailwag/controller/bottomnavbar_controller.dart';
import 'package:tailwag/controller/controller.dart';
import 'package:tailwag/controller/sitter_bottomnavbar_controller.dart';
import 'package:tailwag/controller/sitter_controller.dart';
import 'package:tailwag/firebase_options.dart';
import 'package:tailwag/views/admin/admin_login.dart';
import 'package:tailwag/views/care.dart';
import 'package:tailwag/views/sitter_profile.dart';
import 'package:tailwag/views/sitter_signup/sitter_signup.dart';
import 'package:tailwag/views/splash_screen.dart';
import 'package:tailwag/views/user_signup/continue_as.dart';
import 'package:tailwag/views/user_signup/user_signup.dart';
import 'package:tailwag/widgets/sitter_bottom_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Controller>(
          create: (context) => Controller(),
        ),
        ChangeNotifierProvider<BottomNavBarController>(
          create: (context) => BottomNavBarController(),
        ),
        ChangeNotifierProvider<SitterController>(
          create: (context) => SitterController(),
        ),
        ChangeNotifierProvider<SitterBottomNavBarController>(
          create: (context) => SitterBottomNavBarController(),
        ),
        // ChangeNotifierProvider<HospitalController>(
        //   create: (context) => HospitalController(),
        // ),
        ChangeNotifierProvider<AdminController>(
          create: (context) => AdminController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tailwag',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  AdminLogin(),
      ),
    );
  }
}
