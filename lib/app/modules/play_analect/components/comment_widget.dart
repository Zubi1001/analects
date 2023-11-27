import 'package:analects/app/modules/widgets/widget_imports.dart';

class CommentWidget extends StatelessWidget {
  final double? commentWidth;
  CommentWidget({
    super.key,
    this.commentWidth,
    required this.widget,
  });

  final PlayAnalect widget;
  final showReplies = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Obx(
       () {
        return Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.kSecondaryColor,
                  backgroundImage:
                      CachedNetworkImageProvider(widget.analectData.image),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Khubaib",
                      style: AppTypography.kLight12.copyWith(
                          fontSize: 10.5,
                          color: AppColors.kWhiteColor.withOpacity(.2)),
                    ),
                    SizedBox(
                      width: commentWidth ?? 235.w,
                      child: Text("Magna diam tempus viverra sit pulvinar leo.",
                          style: AppTypography.kBold14.copyWith(
                              fontSize: 13, color: AppColors.kWhiteColor)),
                    ),
                    Row(
                      children: [
                        Text(
                          "1m . ",
                          style: AppTypography.kLight14.copyWith(
                              fontSize: 13,
                              color: AppColors.kWhiteColor.withOpacity(.3)),
                        ),
                        InkWell(
                          onTap: () {
                            showReplies.value = !showReplies.value;
                          },
                          child: Text(
                            "Reply",
                            style: AppTypography.kLight14.copyWith(
                                fontSize: 13,
                                color: AppColors.kWhiteColor.withOpacity(.3)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    SvgPicture.asset(
                      AppAssets.likeFillIcon,
                      width: 13.33.w,
                      height: 11.48.h,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "1",
                      style: AppTypography.kLight12.copyWith(
                          fontSize: 10.5,
                          color: AppColors.kWhiteColor.withOpacity(.3)),
                    ),
                  ],
                ),
              ],
            ),
            if(showReplies.value)
            _buildReplies(),
          ],
        );
      }
    );
  }

  Column _buildReplies() {
    return Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          ListView.separated(
            itemCount: 11,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: 40.h,right: 10.h,top: 10.h,bottom: 10.h),
            itemBuilder: (context, index) {
              return CommentWidget(widget: widget,commentWidth: 195,);
            },
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 20.h),
          ),
        ],
      );
  }
}
