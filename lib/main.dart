import 'package:flashlight/componats.dart';
import 'package:flashlight/view/about_screen.dart';
import 'package:flashlight/view/settings.dart';
import 'package:flashlight/view/torch_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes().appDataTheme,
      darkTheme: Themes().darkTheme,
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => const TorchScreen(),
        ),
        GetPage(
          name: '/setting_screen',
          page: () => const SettingeScreen(),
        ),
        GetPage(
          name: '/about_screen',
          page: () => const About_Screen(),
        ),
      ],
    );
  }
}
