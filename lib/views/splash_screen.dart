import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tailwag/controller/admin_bottom_navbar.dart';
import 'package:tailwag/controller/admin_controller.dart';
import 'package:tailwag/controller/controller.dart';
import 'package:tailwag/controller/sitter_controller.dart';
import 'package:tailwag/views/admin/hospital/admin_hospitals.dart';
import 'package:tailwag/views/on_boarding/onboarding_4.dart';
import 'package:tailwag/views/sitter_main_profile.dart';
import 'package:tailwag/widgets/bottomnavbar.dart';
import 'package:tailwag/widgets/sitter_bottom_navbar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userProvider = Provider.of<Controller>(context, listen: false);
    final sitterProvider =
        Provider.of<SitterController>(context, listen: false);
    final adminProvider = Provider.of<AdminController>(context, listen: false);
    // final bottomProvider =
    //     Provider.of<BottomNavBarController>(context, listen: false);

    gotoNext(context) async {
      await userProvider.getDataFromFirestore();
      await sitterProvider.fetchSitterData();
      await adminProvider.fetchHospitals();
      await adminProvider.fetchShops();
      await adminProvider.fetchPharmacy();
      userProvider.notificationServices.initialiseNotifications();
      if (userProvider.isSignedIn == true) {
        PermissionStatus notificationPermission =
            await Permission.notification.request();
        if (notificationPermission == PermissionStatus.granted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
          );
        }
      } else if (sitterProvider.sitterSignIn == true) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SitterMainProfile(),
          ),
        );
      } else if (adminProvider.adminSignIn == true) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AdminBottomNavBar(),
          ),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const OnBoarding4(),
          ),
        );
      }
    }

    return Scaffold(
      body: FutureBuilder(
        future: gotoNext(context),
        builder: (context, snapShot) {
          return Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/splashScreen.png'),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/splash_screen_title.png',
                      scale: 1.5,
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
