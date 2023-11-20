import 'package:analects/app/modules/widgets/widget_imports.dart';

class Glassmorphism extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  const Glassmorphism({
    Key? key,
    this.borderRadius,
    this.padding,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          borderRadius ?? BorderRadius.vertical(top: Radius.circular(10.r)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          decoration: BoxDecoration(
            color: const Color(0xFF211336).withOpacity(0.4),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF211336),
                Color(0xFF211336),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
