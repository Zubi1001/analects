import 'package:analects/app/modules/create_analects/create_analects.dart';
import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/controller/creator_profile_controller.dart';
import 'package:analects/models/analect_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_down_button/pull_down_button.dart';

class CreatorProfilePage extends StatefulWidget {
  final String? creatorId;
  const CreatorProfilePage({super.key, required this.creatorId});

  @override
  State<CreatorProfilePage> createState() => _CreatorProfilePageState();
}

class _CreatorProfilePageState extends State<CreatorProfilePage> {
  final controller = Get.put(CreatorProfileController());
  final user = Get.find<UserController>().currentUser;
  List<AnalectModel?> get analectList => controller.analectList;

  @override
  void initState() {
    onInit();
    controller.update();
    super.initState();
  }

  Future<void> onInit() async {
    LoadingConfig.showLoading();
    await controller.creatorsAnalects(creatorUid: widget.creatorId);
    await controller.checkSubscribed(creatorId: widget.creatorId);
    await controller.checkFollower(creatorId: widget.creatorId);
    LoadingConfig.hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        floatingActionButton: user!.creator && user!.id == widget.creatorId
            ? const CreateAnalectFloatingButton()
            : null,
        appBar: CustomAppBar(
          title: "",
          backgroundColor: AppColors.noColor,
          actions: [
            PullDownButton(
              itemBuilder: (context) => [
                PullDownMenuItem(
                    title: "Create Analects",
                    onTap: () {
                      if (user!.creator) Get.to(() => const CreateAnalects());
                    }),
              ],
              position: PullDownMenuPosition.automatic,
              buttonBuilder: (context, show) => CupertinoButton(
                onPressed: show,
                padding: EdgeInsets.zero,
                color: AppColors.noColor,
                child: SvgPicture.asset(AppAssets.moreIcon),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            width: context.width,
            height: context.height,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: StreamBuilder<DocumentSnapshot<UserModel?>>(
              stream: DatabaseService()
                  .userCollection
                  .doc(widget.creatorId ?? user!.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserModel? creatorData = snapshot.data!.data();
                  onInit();
                  return Obx(
                    () {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                width: 120.w,
                                height: 120.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.kSecondaryColor,
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          creatorData!.profileImage),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(creatorData.name,
                                style: AppTypography.kBold24
                                    .copyWith(color: AppColors.kWhiteColor)),
                            SizedBox(height: 15.h),
                            Text(creatorData.creatorBio,
                                style: AppTypography.kLight14.copyWith(
                                    color:
                                        AppColors.kWhiteColor.withOpacity(.3),
                                    fontSize: 13),
                                textAlign: TextAlign.center),
                            SizedBox(height: 15.h),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  UpDownText(
                                      title: creatorData.followers.toString(),
                                      subtitle: "Followers"),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    child: const VerticalDivider(
                                        color: AppColors.kSecondaryColor),
                                  ),
                                  UpDownText(
                                      title: creatorData.following.toString(),
                                      subtitle: "Following"),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    child: const VerticalDivider(
                                      color: AppColors.kSecondaryColor,
                                    ),
                                  ),
                                  UpDownText(
                                      title: creatorData.analects.toString(),
                                      subtitle: "Analects"),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            if (user!.id != creatorData.id) ...[
                              Row(
                                children: [
                                  CustomButton(
                                    text: controller.followed
                                        ? "Following"
                                        : "Follow",
                                    onTap: () async {
                                      controller.setFollow(
                                          creatorId: creatorData.id);
                                      controller.update();
                                    },
                                    width: 150.w,
                                    buttonColor: AppColors.kWhiteColor,
                                    textColor: AppColors.kSecondaryColor,
                                    height: 55.h,
                                  ),
                                  const Spacer(),
                                  CustomButton(
                                    text: controller.subscribed
                                        ? "Subscribed"
                                        : "Subscribe",
                                    onTap: () {
                                      if (!controller.subscribed) {
                                        Get.to(() => SubscriptionPage(
                                              creatorData: creatorData,
                                            ));
                                      }
                                    },
                                    width: 150.w,
                                    height: 55.h,
                                  ),
                                ],
                              ),
                              SizedBox(height: 25.h),
                              _buildPlayList(),
                            ] else ...[
                              Container(
                                height: 50.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.kPrimary1Color),
                                child: TabBar(
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.kSecondaryColor,
                                  ),
                                  padding: EdgeInsets.zero,
                                  indicatorColor: Colors.transparent,
                                  dividerColor: Colors.transparent,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  labelColor: Colors.white,
                                  unselectedLabelColor:
                                      AppColors.kWhiteColor.withOpacity(0.5),
                                  tabs: const [
                                    Tab(
                                      text: 'Analects',
                                    ),
                                    Tab(
                                      text: 'Analytics',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height,
                                child: TabBarView(
                                  children: [
                                    _buildPlayList(),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Total Listens",
                                                style: AppTypography.kBold16
                                                    .copyWith(
                                                        color: AppColors
                                                            .kWhiteColor)),
                                            Text(
                                                creatorData.noOfListener
                                                    .toString(),
                                                style: AppTypography.kBold16
                                                    .copyWith(
                                                        color: AppColors
                                                            .kWhiteColor)),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Total Views",
                                                style: AppTypography.kBold16
                                                    .copyWith(
                                                        color: AppColors
                                                            .kWhiteColor)),
                                            Text(
                                                creatorData.totalViewCount
                                                    .toString(),
                                                style: AppTypography.kBold16
                                                    .copyWith(
                                                        color: AppColors
                                                            .kWhiteColor)),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Total Followers",
                                                style: AppTypography.kBold16
                                                    .copyWith(
                                                        color: AppColors
                                                            .kWhiteColor)),
                                            Text(
                                                creatorData.followersCount
                                                    .toString(),
                                                style: AppTypography.kBold16
                                                    .copyWith(
                                                        color: AppColors
                                                            .kWhiteColor)),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Total Subscribers",
                                                style: AppTypography.kBold16
                                                    .copyWith(
                                                        color: AppColors
                                                            .kWhiteColor)),
                                            Text(
                                                creatorData.noOfSubscribersCount
                                                    .toString(),
                                                style: AppTypography.kBold16
                                                    .copyWith(
                                                        color: AppColors
                                                            .kWhiteColor)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Column _buildPlayList() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Playlist",
              style:
                  AppTypography.kBold16.copyWith(color: AppColors.kWhiteColor),
            ),
            SvgPicture.asset(AppAssets.searchIcon),
          ],
        ),
        SizedBox(height: 25.h),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: analectList.length,
          itemBuilder: (context, index) {
            return AnalectsListViewItem(
              analectData: analectList[index],
            );
          },
        ),
      ],
    );
  }
}
