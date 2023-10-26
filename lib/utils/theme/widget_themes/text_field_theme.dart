import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class STextFormFieldTheme {
  STextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: SColors.darkGrey,
    suffixIconColor: SColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: SSizes.fontSizeMd, color: SColors.black),
    hintStyle: const TextStyle().copyWith(fontSize: SSizes.fontSizeSm, color: SColors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: SColors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.grey),
    ),
    focusedBorder:const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.dark),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: SColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: SColors.darkGrey,
    suffixIconColor: SColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: SSizes.fontSizeMd, color: SColors.white),
    hintStyle: const TextStyle().copyWith(fontSize: SSizes.fontSizeSm, color: SColors.white),
    floatingLabelStyle: const TextStyle().copyWith(color: SColors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: SColors.warning),
    ),
  );
}
