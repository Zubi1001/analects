import '../../widgets/widget_imports.dart';


// ignore: must_be_immutable
class HorizontalScrollView extends StatelessWidget {
  bool topLabelCheck;

  HorizontalScrollView({super.key, required this.topLabelCheck});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return HorizontalScrollViewItem(labelButtonCheck: topLabelCheck,);
        },
      ),
    );
  }
}
