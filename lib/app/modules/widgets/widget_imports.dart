export 'dart:developer' hide Flow;
export 'dart:io' hide HeaderValue;
export 'dart:ui' show ImageFilter;
export 'dart:async';
export 'package:flutter/material.dart';

///Packages
export 'package:flutter_svg/flutter_svg.dart';
export 'package:get/get.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:flutter/services.dart';
export "package:firebase_core/firebase_core.dart";
export 'package:email_validator/email_validator.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:lottie/lottie.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:image_picker/image_picker.dart';
export 'package:audio_session/audio_session.dart';
export 'package:flutter_sound/flutter_sound.dart';
export 'package:permission_handler/permission_handler.dart';
export 'package:flutter_easyloading/flutter_easyloading.dart';


///Project Component & widgets
export 'package:analects/app/data/contents/app_assets.dart';
export 'package:analects/app/data/contents/app_colors.dart';
export 'package:analects/app/data/contents/app_typography.dart';
export 'package:analects/app/modules/auth/components/cutsom_text_filed.dart';
export 'package:analects/app/modules/widgets/button/custom_text_button.dart';
export 'package:analects/app/modules/widgets/button/login_signin_button.dart';
export 'package:analects/app/modules/home/components/catagories_scroll_view.dart';
export 'package:analects/app/modules/home/components/horizontal_scroll_view.dart';
export 'package:analects/app/onboarding_page/components/on_boarding_header_widget.dart';
export 'package:analects/app/modules/home/components/newest_analects_scroll_view_item.dart';
export 'package:analects/app/modules/home/components/play_and_pause_button.dart';
export 'package:analects/app/modules/home/components/horizontal_scroll_item.dart';
export 'package:analects/app/modules/creator_profile/components/up_down_text.dart';
export 'package:analects/app/modules/widgets/app_bar/custom_app_bar.dart';
export '../widgets/dropdown/custom_dropdown.dart';


export 'package:analects/app/modules/widgets/container/glassmorphism.dart';
export 'package:analects/app/modules/widgets/dialogs/error_dialog.dart';
export 'package:analects/app/modules/widgets/dialogs/loader_dialog.dart';

///Pages
export 'package:analects/firebase_options.dart';
export 'package:analects/services/auth_service.dart';
export 'package:analects/services/firebase_storage_service.dart';
export 'package:analects/services/image_picker_service.dart';
export 'package:analects/services/auth_wrapper.dart';
export 'package:analects/controller/user_controller.dart';
export 'package:analects/models/user_model.dart';
export 'package:analects/controller/auth_controller.dart';
export 'package:analects/services/database_service.dart';
export 'package:analects/app/modules/auth/login_page.dart';
export 'package:analects/app/modules/auth/sign_up_page.dart';
export 'package:analects/app/onboarding_page/onboarding_page.dart';
export 'package:analects/app/modules/home/landing_page.dart';
export 'package:analects/app/modules/discover/discover_page.dart';
export 'package:analects/app/modules/subscription/subscription_page.dart';
export 'package:analects/app/modules/discover/discover_detail_page.dart';
export 'package:analects/app/modules/creator_profile/creator_profile_page.dart';
export 'package:analects/controller/create_analects_controller.dart';
export 'package:analects/app/modules/analect_detail/analect_detail.dart';
export 'package:analects/app/modules/play_analect/play_analect.dart';
