import 'package:analects/app/modules/widgets/dialogs/custom_toast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../models/analect_model.dart';
import '../widgets/widget_imports.dart';

class PlayAnalect extends StatefulWidget {
  final AnalectModel analectData;

  PlayAnalect({super.key, required this.analectData});

  @override
  State<PlayAnalect> createState() => _PlayAnalectState();
}

class _PlayAnalectState extends State<PlayAnalect> {
  late AudioPlayer player;

  final isPlaying = false.obs;
  final _playerProgressPosition = Rxn<Duration>();
  Duration? get playerPosition => _playerProgressPosition.value;


  final volume = RxDouble(1.0);

  final audioDuration = "00:00".obs;

  @override
  void initState() {
    onInit();
    super.initState();
  }

  Future<void> onInit() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    player = AudioPlayer();
    Duration? duration = await player.setUrl(widget.analectData.audioUrl);
    audioDuration.value = formatDuration(duration!);

    // audioDuration.value = await getAudioDuration(widget.analectData.audioUrl);

    player.setUrl(widget.analectData.audioUrl);
    player.play();
    player.playerStateStream.listen((playerState) {
      isPlaying.value = playerState.playing;
      setState(() {

      });
      log("khubaib");
      log(isPlaying.value.toString());
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
        // isPlaying.value = false;
      } else if (!isPlaying.value) {
        // isPlaying.value = false;
      } else if (processingState != ProcessingState.completed) {
        // isPlaying.value = true;
      }
      else if (processingState == ProcessingState.completed){
        player.seek(Duration.zero);
        player.stop();
        // isPlaying.value = false;
      }
      else {
        player.seek(Duration.zero);
        player.pause();
        // isPlaying.value = false;
      }
    });
    player.positionStream.listen((Duration position) {
      _playerProgressPosition.value = position;
    });
  }

  void seek(Duration position) {
    player.seek(position);
  }


  String formatDuration(Duration duration) {
    final minutes = (duration.inMinutes).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          backgroundColor: AppColors.kPrimaryColor,
          appBar: CustomAppBar(
            title: "",
            backgroundColor: AppColors.noColor,
            actions: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: SvgPicture.asset(AppAssets.moreIcon),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 260.h,
                  width: 260.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 100.w,
                          backgroundColor: AppColors.kSecondaryColor,
                          backgroundImage: CachedNetworkImageProvider(
                              widget.analectData.image),
                        ),
                      ),
                      Transform.scale(
                        scaleX: -1.0,
                        child: SleekCircularSlider(
                          appearance: CircularSliderAppearance(
                            customColors: CustomSliderColors(
                              trackColor: AppColors.kPrimary1Color,
                              progressBarColor: AppColors.kSecondaryColor,
                            ),
                            size: 245.w,
                            startAngle: 360,
                            angleRange: 180,
                            customWidths: CustomSliderWidths(
                              progressBarWidth: 15.w,
                              trackWidth: 15.w,
                            ),
                            infoProperties: InfoProperties(
                              mainLabelStyle: AppTypography.kBold16.copyWith(
                                color: AppColors.noColor,
                              ),
                            ),
                          ),
                          min: 0.0,
                          max: 1.0,
                          initialValue: volume.value,
                          onChange: (value) {
                            player.setVolume(value);
                          },
                        ),
                      ),
                      Positioned(
                        top: 80.h,
                        left: 0,
                        child: InkWell(
                          onTap: () {
                            if (volume.value > 0.1) {
                              volume.value -= 0.1;
                              player.setVolume(volume.value);
                            }
                          },
                          child: SvgPicture.asset(
                            AppAssets.mutedIcon,
                            width: 30.w,
                            height: 30.w,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80.h,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            if (volume.value < 1.0) {
                              volume.value += 0.1;
                              player.setVolume(volume.value);
                            }
                          },
                          child: SvgPicture.asset(
                            AppAssets.volumeLoudIcon,
                            width: 30.w,
                            height: 30.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Lottie.asset(
                      AppAssets.audioAnimation,
                      animate: isPlaying.value,
                      repeat: isPlaying.value ? true : false,
                      frameRate: FrameRate.max,
                    ),
                    Positioned(
                      top: 40.h,
                      child: Column(
                        children: [
                          Text(
                            widget.analectData.analectName,
                            style: AppTypography.kBold16.copyWith(color: AppColors.kWhiteColor),
                          ),
                          Text(
                            widget.analectData.category,
                            style: AppTypography.kLight14
                                .copyWith(fontSize: 13, color: AppColors.kWhiteColor.withOpacity(.3)),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 60.h,
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: formatDuration(playerPosition ?? Duration.zero),
                            // playerController.playerdisplayTime,
                            style: AppTypography.kBold16.copyWith(color: AppColors.kWhiteColor),
                          ),
                          TextSpan(
                            text: " / ${audioDuration.value}",
                            style: AppTypography.kBold14
                                .copyWith(fontSize: 13, color: AppColors.kWhiteColor.withOpacity(.3)),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          if(player.position > Duration.zero){
                            final currentPosition = player.position;
                            final newPosition = currentPosition - const Duration(seconds: 10);
                            seek(newPosition);
                            showToast("- 10 second");
                          }
                        },
                        child: SvgPicture.asset(AppAssets.tenSecondBackIcon)),
                    SizedBox(
                      width: 20.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        log(isPlaying.value.toString());
                        isPlaying.value ? player.pause() : player.play();
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            isPlaying.value ? AppColors.kWhiteColor.withOpacity(.3) : AppColors.kSecondaryColor,
                        radius: 40.h,
                        child: Center(
                          child: SvgPicture.asset(
                            isPlaying.value ? AppAssets.stopAudioIcon : AppAssets.pauseButton,
                            width: 24.w,
                            height: 32.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    InkWell(
                        onTap: () async {
                          // Duration? duration = await player.setUrl(widget.analectData.audioUrl);
                          // if(duration! >  const Duration(seconds: 10)){
                            final currentPosition = player.position;
                            final newPosition = currentPosition + const Duration(seconds: 10);
                            seek(newPosition);
                            showToast("+ 10 second");
                          // }

                        },
                        child: SvgPicture.asset(AppAssets.tenSecondForwardIcon)),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Column(
                  children: [
                    Text(
                      "Comments",
                      style: AppTypography.kLight14.copyWith(
                        color: AppColors.kWhiteColor.withOpacity(.3),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SvgPicture.asset(AppAssets.doubleArrowUpIcon),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
