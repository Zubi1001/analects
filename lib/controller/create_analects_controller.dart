
import 'package:analects/app/modules/widgets/widget_imports.dart';


class CreateAnalectsController extends GetxController {
  final isRecording = false.obs;
  final isRecordingPaused = false.obs;
  final timeLimitExceed = false.obs;
  final startTime = 0.obs;
  final elapsedTime = 0.obs;
  final Codec _codec = Codec.aacMP4;
  final String _mPath = 'tau_file.mp4';

  final FlutterSoundPlayer? _player = FlutterSoundPlayer();
  final FlutterSoundRecorder? _recorder = FlutterSoundRecorder();
  final _isRecorderInitialized = false.obs;
  final _isPlayerInitialized = false.obs;

  @override
  void onInit() async {
    _player!.openPlayer().then((value) {
      _isPlayerInitialized.value = true;
    });

    openRecorder().then((value) {
      _isRecorderInitialized.value = true;
    });
    super.onInit();

    log("recorder initialized");
  }

  ///Open Recorder
  Future<void> openRecorder() async {
    var status = await Permission.microphone.isDenied;
    if (status) {
      await Permission.microphone.request();
    }
    await _recorder?.openRecorder();

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  ///START RECORDING
  Future<void> startRecording() async {
    if (!_isRecorderInitialized.value) return;
    _recorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      // audioSource: AudioSource.microphone,
    )
        .then((value) {
      update();
    });
    Future.delayed(const Duration(minutes: 1), () async {
      await pauseRecording();
      isRecordingPaused.value = false;
      print(elapsedTime.value);
      // _player!.stopPlayer();
      _recorder!.stopRecorder();
      timeLimitExceed.value = true;
      isRecording.value = false;
      update();
    });
  }

  ///STOP RECORDING
  Future<void> pauseRecording() async {
    if (!_isRecorderInitialized.value) return;
    await _recorder!.pauseRecorder();
    // await _recorder!.stopRecorder();
  }

   Future<void> resumeRecording() async {
    if (!_isRecorderInitialized.value) return;
    await _recorder!.resumeRecorder();
  }

  // @override
  // void onClose() {
  //   _player!.closePlayer();
  //   _player = null;
  //   _recorder!.closeRecorder();
  //   _recorder = null;
  //   super.onClose();
  // }

  ///Display Recording Time
  String get displayTime {
    Duration duration = Duration(milliseconds: elapsedTime.value);
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  ///Start Function
  void start() async {
    if (!isRecording.value && !timeLimitExceed.value) {
      startTime.value =
          DateTime.now().second - elapsedTime.value;
      isRecording.value = true;
      update();
      await startRecording();
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (isRecording.value) {
          elapsedTime.value =
              DateTime.now().millisecondsSinceEpoch - startTime.value;
          update();
        }
      });
    } else{
      log("Time Limit Exceed");
    }
  }

  ///Pause Function
  void pause() async {
    if (isRecording.value) {
      isRecording.value = false;
      await pauseRecording();
      update();
    }
  }

  void resume() async {
    if (!isRecording.value) {
      isRecording.value = true;
      await resumeRecording();
      update();
    }
  }

  ///Reset Function
  void reset() {
    elapsedTime.value = 0;
    _player!.stopPlayer();
    _recorder!.stopRecorder();
    isRecording.value = false;
    update();
  }

  ///For player
  void play() {
    _player!
        .startPlayer(
            fromURI: _mPath,
            whenFinished: () {
              log("finished playing");
            })
        .then((value) {
      update();
    });
  }

  void stopPlayer() {
    _player!.stopPlayer().then((value) {
      update();
    });
  }
}
