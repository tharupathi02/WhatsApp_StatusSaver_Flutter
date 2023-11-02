import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:statussaver/provider/get_images.dart';
import 'package:statussaver/provider/get_status.dart';

import 'feature/splash_screen/splash_screen.dart';
import 'utils/constants/text_strings.dart';
import 'utils/theme/theme.dart';

class StatusSaver extends StatelessWidget {
  const StatusSaver({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetStatusProvider()),
        ChangeNotifierProvider(create: (_) => GetImages()),
      ],
      child: GetMaterialApp(
        title: STexts.appName,
        themeMode: ThemeMode.system,
        theme: SAppTheme.lightTheme,
        darkTheme: SAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        // initialBinding: GeneralBindings(),
        home: const SplashScreen(),
      ),
    );
  }
}
