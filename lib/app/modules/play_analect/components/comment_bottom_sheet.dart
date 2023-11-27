import 'package:analects/app/modules/play_analect/components/comment_widget.dart';
import 'package:analects/app/modules/widgets/widget_imports.dart';

class CommentBottomSheet extends StatelessWidget {
  const CommentBottomSheet({
    super.key,
    required this.widget,
  });

  final PlayAnalect widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      constraints: BoxConstraints(
        maxHeight: context.height * .9,
        minHeight: context.height * .9,
      ),
      decoration: BoxDecoration(
          color: AppColors.kPrimary1Color.withOpacity(.95),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.r),
            topRight: Radius.circular(40.r),
          )),
      child: Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Center(child: SvgPicture.asset(AppAssets.doubleArrowDownIcon)),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Comments",
                style: AppTypography.kBold14
                    .copyWith(color: AppColors.kWhiteColor, fontSize: 13),
              ),
              Divider(
                color: AppColors.kWhiteColor.withOpacity(.3),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 11,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  itemBuilder: (context, index) {
                    return CommentWidget(widget: widget);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 20.h),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 64.h,
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: TextFormField(
                        style: AppTypography.kLight14.copyWith(
                            fontSize: 13, color: AppColors.kWhiteColor),
                        decoration: InputDecoration(
                          hintText: "Type something...",
                          hintStyle: AppTypography.kLight16.copyWith(
                              color: AppColors.kWhiteColor.withOpacity(.3)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      color: AppColors.kSecondaryColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.sendIcon,
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
