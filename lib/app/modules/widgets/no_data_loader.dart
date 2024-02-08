import 'package:analects/app/modules/widgets/widget_imports.dart';

class NoDataLoader extends StatelessWidget {
  const NoDataLoader({
    Key? key,
    this.isCenter = true,
    this.size = 100,
  }) : super(key: key);
  final bool isCenter;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCenter ? Alignment.center : Alignment.topCenter,
      child: SizedBox(
        height: 100.h,
        child: LottieBuilder.asset(
          "assets/animations/no_data.json",
          repeat: true,
          width: size.w,
        ),
      ),
    );
  }
}