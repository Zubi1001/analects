import 'package:analects/app/modules/widgets/widget_imports.dart';



class SubscriptionPage extends StatelessWidget {
  final UserModel creatorData;
  const SubscriptionPage({super.key, required this.creatorData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar:    CustomAppBar(
        title: "",
        backgroundColor: AppColors.noColor,
        actions: [
          GestureDetector(
            onTap: () {
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: SvgPicture.asset(AppAssets.moreIcon),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: 110.w,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 40.w,
                        child: Container(
                          width: 70.w,
                          height: 70.w,
                          decoration:  BoxDecoration(
                              color: AppColors.kSecondaryColor,
                              shape: BoxShape.circle,
                              image: DecorationImage(image: CachedNetworkImageProvider(creatorData.profileImage), fit: BoxFit.cover)),
                    
                        ),
                      ),
                      Positioned(
                        child: CircleAvatar(
                          radius: 35.w,
                          backgroundColor: AppColors.kBlueColor,
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.subscriptionIcon,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                "Subscribe to ${creatorData.name}",
                style: AppTypography.kBold16.copyWith(color: AppColors.kWhiteColor),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Support your favorite people on podcast for bonus content and extra perks.",
                style: AppTypography.kLight12.copyWith(
                  color: AppColors.kWhiteColor.withOpacity(.3),
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "This creator is offering the following:",
                  style: AppTypography.kBold14.copyWith(color: AppColors.kWhiteColor, fontSize: 13),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 280.h,
                child: ListView.separated(
                  itemBuilder: (BuildContext context, index) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 35.w,
                          height: 35.w,
                          // color:AppColors.kWhiteColor,
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.checkIcon,
                              // width: 15.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          offerList[index],
                          style: AppTypography.kMedium14.copyWith(color: AppColors.kWhiteColor, fontSize: 13),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, index) {
                    return SizedBox(
                      height: 15.h,
                    );
                  },
                  itemCount: offerList.length,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "By clicking below to make this purchase, you agree to the",
                      style:
                          AppTypography.kLight14.copyWith(color: AppColors.kWhiteColor.withOpacity(.3), fontSize: 13),
                    ),
                    TextSpan(
                      text: " Subscription Terms",
                      style: AppTypography.kMedium14.copyWith(color: AppColors.kWhiteColor, fontSize: 13),
                    ),
                    TextSpan(
                      text: ".",
                      style:
                          AppTypography.kLight14.copyWith(color: AppColors.kWhiteColor.withOpacity(.3), fontSize: 13),
                    ),
                    TextSpan(
                      text: " Cancel anytime. Auto-renews monthly",
                      style:
                          AppTypography.kLight14.copyWith(color: AppColors.kWhiteColor.withOpacity(.3), fontSize: 13),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomButton(
                text: "Subscribe • \$5.79/month",
                width: context.width,
                height: 60.h,
                onTap: () {},
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Gift a subscription",
                style: AppTypography.kBold16.copyWith(
                  color: AppColors.kWhiteColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List offerList = [
  "Subscriber badge",
  "Exclusive content",
  "Downloadable content",
  "Broadcast channel",
];


