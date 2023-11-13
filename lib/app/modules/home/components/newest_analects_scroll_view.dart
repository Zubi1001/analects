import '../../widgets/widget_imports.dart';

class AnalectsListView extends StatelessWidget {
  const AnalectsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260.h,
      //create a vertical list view
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const AnalectsListViewItem();
        },
      ),
    );
  }
}
