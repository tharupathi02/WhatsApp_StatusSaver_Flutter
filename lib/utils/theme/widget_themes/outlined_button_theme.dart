import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class SOutlinedButtonTheme {
  SOutlinedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: SColors.dark,
      side: const BorderSide(color: SColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: SColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: SSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: SColors.light,
      side: const BorderSide(color: SColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: SColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: SSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SSizes.buttonRadius)),
    ),
  );
}
