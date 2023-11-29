import 'package:analects/app/modules/play_analect/components/comment_widget.dart';
import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/models/comment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../../../repo/comment_repo.dart';

class CommentBottomSheet extends StatelessWidget {
  CommentBottomSheet({
    super.key,
    required this.widget,
  });

  final PlayAnalect widget;
  final _commentsRepo = CommentsRepo();
  final commentController = TextEditingController();
  final _user = Get.find<UserController>().currentUser;
  final _db = DatabaseService();
  final sortMode = Rx<SortMode>(SortMode.new_to_old);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Comments",
                        style: AppTypography.kBold14
                            .copyWith(color: AppColors.kWhiteColor, fontSize: 13),
                      ),
                      PullDownButton(
                            itemBuilder: (context) => [
                              PullDownMenuItem(
                                title: "Most liked",
                                onTap: () {
                                  sortMode.value = SortMode.most_liked;
                                },
                              ),
                              PullDownMenuItem(
                                title: "New to old",
                                onTap: () {
                                  sortMode.value = SortMode.new_to_old;
                                },
                              ),
                              PullDownMenuItem(
                                title: "Old to New",
                                onTap: () {
                                  sortMode.value = SortMode.old_to_new;
                                },
                              ),
                            ],
                            position: PullDownMenuPosition.automatic,
                            buttonBuilder: (context, show) => CupertinoButton(
                              onPressed: show,
                              padding: EdgeInsets.zero,
                              color: AppColors.noColor,
                              child: SvgPicture.asset(AppAssets.moreIcon),
                            ),
                          )
                    ],
                  ),
                  Divider(
                    color: AppColors.kWhiteColor.withOpacity(.3),
                  ),
                  Obx(
                    () {
                      return Expanded(
                        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            key: ValueKey(sortMode.value),
                            stream: query,
                            // DatabaseService()
                            //     .commentsCollection(widget.analectData.analectId)
                            //     .limit(50)
                            //     .orderBy('timestamp', descending: true)
                            //     .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                  itemCount: snapshot.data!.docs.length,
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  itemBuilder: (context, index) {
                                    CommentModel comment = CommentModel.fromMap(
                                        snapshot.data!.docs[index].data());
                                    return CommentWidget(
                                        key: ValueKey(sortMode), comment: comment);
                                  },
                                  separatorBuilder: (BuildContext context, int index) =>
                                      SizedBox(height: 20.h),
                                );
                              } else {
                                return const Center(
                                  child: Text("No comments yet"),
                                );
                              }
                            }),
                      );
                    }
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
                            controller: commentController,
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
                      InkWell(
                        onTap: () async {
                          if (commentController.text.isNotEmpty) {
                            CommentModel comment = CommentModel(
                              id: "",
                              commentText: commentController.text,
                              commenterId: _user!.id,
                              commentorName: _user!.name,
                              commentorImage: _user!.profileImage,
                              analectId: widget.analectData.analectId,
                              timestamp: DateTime.now(),
                            );
                            await _commentsRepo.postComment(
                              comment,
                              widget.analectData.analectId,
                            );
                            commentController.clear();
                          }
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      }
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get query {
    switch (sortMode.value) {
      case SortMode.most_liked:
        return _db
            .commentsCollection(widget.analectData.analectId)
            .limit(50)
            .orderBy('totalReactionCount', descending: true)
            .snapshots();

      case SortMode.new_to_old:
        return _db
            .commentsCollection(widget.analectData.analectId)
            .limit(50)
            .orderBy('timestamp', descending: true)
            .snapshots();

      case SortMode.old_to_new:
        return _db
            .commentsCollection(widget.analectData.analectId)
            .limit(50)
            .orderBy("timestamp", descending: false)
            .snapshots();

      default:
        return _db
            .commentsCollection(widget.analectData.analectId)
            .limit(50)
            .orderBy('timestamp', descending: true)
            .snapshots();
    }
  }
}

enum SortMode {most_liked, new_to_old, old_to_new }
