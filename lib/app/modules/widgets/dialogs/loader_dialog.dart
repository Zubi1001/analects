import 'package:analects/app/modules/widgets/widget_imports.dart';



class LoadingConfig {
  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = AppColors.kPrimary1Color.withOpacity(.02)
      ..maskColor = Colors.transparent
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  static void showLoading() {
     EasyLoading.show(maskType: EasyLoadingMaskType.clear, dismissOnTap: false);
  }

  static void hideLoading() {
     EasyLoading.dismiss();
  }
}
