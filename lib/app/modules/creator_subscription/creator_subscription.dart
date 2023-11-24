import 'package:analects/app/modules/creator_subscription/creator_description.dart';
import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/controller/creator_subscription_controller.dart';

import 'package:analects/models/creator_subscription_model.dart';

class CreatorSubscriptionPage extends StatelessWidget {
   const CreatorSubscriptionPage({super.key});

  // final controller = Get.put(CreatorSubscriptionController());

  @override
  Widget build(BuildContext context) {
   
    return GetX<CreatorSubscriptionController>(
      init: CreatorSubscriptionController(),
      builder: (controller) {
         log("event length ${controller.subscriptionList.length.toString()}");
        return Scaffold(
          backgroundColor: AppColors.kPrimaryColor,
          appBar: const CustomAppBar(
            title: "Become a Creator",
            backgroundColor: AppColors.noColor,
            actions: [],
          ),
          body: SafeArea(
            child: Container(
              width: context.width,
              height: context.height,
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  CircleAvatar(
                    radius: 30.w,
                    backgroundColor: AppColors.kBlueColor,
                    child: SvgPicture.asset(
                      AppAssets.subscriptionIcon,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Amet ac ultrices quis vitae varius. A nisl dignissim at adipiscing curabitur molestie.",
                    style: AppTypography.kLight14.copyWith(
                        color: AppColors.kWhiteColor.withOpacity(.3),
                        fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      itemBuilder: (BuildContext context, index) {
                        return CreatorSubscriptionCard(subscriptionData: controller.subscriptionList[index]!,);
                      },
                      separatorBuilder: (BuildContext context, index) {
                        return SizedBox(
                          height: 20.h,
                        );
                      },
                      itemCount: controller.subscriptionList.length),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class CreatorSubscriptionCard extends StatelessWidget {

  final CreatorSubscrptionModel subscriptionData;
  const CreatorSubscriptionCard({
    super.key, required this.subscriptionData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 315.w,
      height: 228.h,
      padding: EdgeInsets.symmetric(
          horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColors.kPrimary1Color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                   subscriptionData.tier == ""?"Free Plan".toUpperCase(): subscriptionData.tier.toUpperCase(),
                    style: AppTypography.kBold16.copyWith(
                        color: AppColors.kWhiteColor,
                        fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 10.w),
                  if(subscriptionData.recommended)Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.w),
                    decoration: BoxDecoration(
                      color: AppColors.kBlueColor.withOpacity(.3),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "Recommended",
                      style: AppTypography.kBold12.copyWith(
                          color: AppColors.kBlueColor),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Advantages:",
                style: AppTypography.kBold14.copyWith(
                    color: AppColors.kWhiteColor,
                    fontSize: 13.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.h,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 35.w,
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.checkIcon,
                              width: 8.33.w,
                              height: 7.h,
                              color: AppColors.kBlueColor,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            subscriptionData.advantages[index],
                            style: AppTypography.kLight14
                                .copyWith(
                                    color:
                                        AppColors.kWhiteColor,
                                    fontSize: 13.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                  itemCount: subscriptionData.advantages.length),
              const Spacer(),
              Center(
                child: CustomButton(
                  text: "Select Plan",
                  onTap: () {
                    Get.to(() => CreatorDescriptionPage(subscriptionName: subscriptionData.tier,));
                  },
                  buttonColor: AppColors.kSecondaryColor,
                  width: 275.w,
                  height: 44.h,
                  buttonBorderRadius: 10.r,
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            child: CircleAvatar(
              radius: 32.w,
              backgroundColor: AppColors.kBlueColor,
              child: Text(
                "\$${subscriptionData.price.toString()}",
                style: AppTypography.kBold20
                    .copyWith(color: AppColors.kWhiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
