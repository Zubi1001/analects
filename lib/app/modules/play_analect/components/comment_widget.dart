import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/models/comment_model.dart';
import 'package:analects/repo/comment_repo.dart';
import 'package:reaction_askany/models/emotions.dart';
import 'package:reaction_askany/models/reaction_box_paramenters.dart';
import 'package:reaction_askany/reaction_askany.dart';

class CommentWidget extends StatelessWidget {
  final double? commentWidth;
  CommentWidget({
    super.key,
    this.commentWidth,
    required this.comment,
  });

  final CommentModel? comment;
  final emotion = Rxn<Emotions>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return ReactionWrapper(
            boxParamenters: ReactionBoxParamenters(
              brightness: Brightness.dark,
              iconSize: 26,
              iconSpacing: 10,
              paddingHorizontal: 30,
              radiusBox: 40,
              quantityPerPage: 6,
            ),
            handlePressed: (Emotions? emotion) async {
              emotion = emotion!;
              await CommentsRepo().reactToComment(
                comment!,
                emotion,
              );
            },
            initialEmotion: emotion.value,
            buttonReaction: const Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Icon(
                Icons.face_outlined,
                size: 20.0,
                color: Colors.grey,
              ),
            ),
            doubleTapLabel: "Like",
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.kSecondaryColor,
                  backgroundImage:
                      CachedNetworkImageProvider(comment!.commentorImage!),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment!.commentorName == ''
                          ? "User"
                          : comment!.commentorName!,
                      style: AppTypography.kLight12.copyWith(
                          fontSize: 10.5,
                          color: AppColors.kWhiteColor.withOpacity(.2)),
                    ),
                    SizedBox(
                      width: commentWidth ?? 235.w,
                      child: Text(comment!.commentText ?? "",
                          style: AppTypography.kBold14.copyWith(
                              fontSize: 13, color: AppColors.kWhiteColor)),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "1m . ",
                          style: AppTypography.kLight14.copyWith(
                              fontSize: 13,
                              color: AppColors.kWhiteColor.withOpacity(.3)),
                        ),
                      ],
                    ),
                  ],
                ),
                // const Spacer(),
                // Column(
                //   children: [
                //     SvgPicture.asset(
                //       AppAssets.likeFillIcon,
                //       width: 13.33.w,
                //       height: 11.48.h,
                //     ),
                //     SizedBox(
                //       height: 5.h,
                //     ),
                //     Text(
                //       "1",
                //       style: AppTypography.kLight12.copyWith(
                //           fontSize: 10.5,
                //           color: AppColors.kWhiteColor.withOpacity(.3)),
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        }),
      ],
    );
  }

//   Column _buildReplies() {
//     return Column(
//         children: [
//           SizedBox(
//             height: 10.h,
//           ),
//           ListView.separated(
//             itemCount: 11,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             padding: EdgeInsets.only(left: 40.h,right: 10.h,top: 10.h,bottom: 10.h),
//             itemBuilder: (context, index) {
//               return CommentWidget(widget: widget,commentWidth: 195,);
//             },
//             separatorBuilder: (BuildContext context, int index) =>
//                 SizedBox(height: 20.h),
//           ),
//         ],
//       );
//   }
}
