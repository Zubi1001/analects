import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class CreateAnalectsController extends GetxController {
  final isRecording = false.obs;
  final isPlaying = false.obs;
  final isPlayingPaused = false.obs;
  final isPlayingFinished = false.obs;
  final isRecordingPaused = false.obs;
  final timeLimitExceed = false.obs;
  final startTime = 0.obs;
  final elapsedTime = 0.obs;
  final Codec _codec = Codec.aacMP4;
  String? recordingPath;

  final playerStartTime = 0.obs;
  final playerElapsedTime = 0.obs;

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
    Directory tempDir = await getTemporaryDirectory();
    String filePath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
    _recorder!.startRecorder(toFile: filePath, codec: _codec).then((value) {
      recordingPath = filePath;
      update();
    });
  }

  ///Pause RECORDING
  Future<void> pauseRecording() async {
    if (!_isRecorderInitialized.value) return;
    await _recorder!.pauseRecorder();
    isRecordingPaused.value = true;
    update();
    // await _recorder!.stopRecorder();
  }

  Future<void> stopRecording() async {
    if (!_isRecorderInitialized.value) return;
    await _recorder!.stopRecorder();
    isRecording.value = false;
    timeLimitExceed.value = true;
    update();
  }

  Future<void> resumeRecording() async {
    if (!_isRecorderInitialized.value) return;
    await _recorder!.resumeRecorder();
    isRecordingPaused.value = false;
    update();
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
          DateTime.now().millisecondsSinceEpoch - elapsedTime.value;
      isRecording.value = true;
      update();
      await startRecording();

      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (isRecording.value) {
          elapsedTime.value =
              DateTime.now().millisecondsSinceEpoch - startTime.value;
          update();

          if (elapsedTime.value >= const Duration(minutes: 1).inMilliseconds) {
            timer.cancel();
            stopRecording();
          }
        }
      });
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
    startTime.value = 0;
    _player!.stopPlayer();
    _recorder!.stopRecorder();
    isRecording.value = false;
    isRecordingPaused.value = false;
    timeLimitExceed.value = false;
    update();
  }

  ///For player
  void playPlayer({String? audioUrl}) {
    if (!_isPlayerInitialized.value) return;
    playerStartTime.value = 0;
    playerElapsedTime.value = 0;
    Timer? playerTimer;
    playerStartTime.value =
        DateTime.now().millisecondsSinceEpoch - playerElapsedTime.value;
    isPlaying.value = true;
    _player!
        .startPlayer(
            fromURI: audioUrl ?? recordingPath,
            codec: _codec,
            whenFinished: () {
              isPlaying.value = false;
              isPlayingFinished.value = true;
              playerTimer!.cancel();
              log("finished playing");
            })
        .then((value) {
      playerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (isPlaying.value) {
          playerElapsedTime.value =
              DateTime.now().millisecondsSinceEpoch - playerStartTime.value;
          update();
        }
      });
      update();
    });
  }

  String get playerdisplayTime {
    Duration duration = Duration(milliseconds: playerElapsedTime.value);
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  void stopPlayer() {
    if (!_isPlayerInitialized.value) return;
    _player!.stopPlayer();
    isPlaying.value = false;
    update();
  }

  void pausePlayer() {
    if (!_isPlayerInitialized.value) return;
    _player!.pausePlayer();
    isPlaying.value = false;
    isPlayingPaused.value = true;
    update();
  }

  void resumePlayer() {
    if (!_isPlayerInitialized.value) return;
    _player!.resumePlayer();
    isPlayingPaused.value = false;
    isPlaying.value = true;
    update();
  }

  void resetPlayer() {
    if (!_isPlayerInitialized.value) return;
    playerElapsedTime.value = 0;
    _player!.stopPlayer();
    isPlaying.value = false;
    isPlayingPaused.value = false;
    isPlayingFinished.value = false;
    update();
  }

  increment10Sec() {
    if (_isPlayerInitialized.value) return;
    _player!.seekToPlayer(
      Duration(seconds: 10),
    );
    update();
  }

  decrement10Sec() {
    if (_isPlayerInitialized.value) return;
    _player!.seekToPlayer(
      Duration(seconds: -10),
    );
    update();
  }


  ///Using Just Audio Package
  final audioPlayer = AudioPlayer();
   
  ///Get Audio Duration
   Future<String> getAudioDuration(String audioUrl) async {
     Duration? duration = await audioPlayer.setUrl(audioUrl);
    //
    String minutes = (duration!.inMinutes).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds).toString().padLeft(2, '0');
       log("$minutes:$seconds");
    return '$minutes:$seconds';
  }

  ///Play Audio with stream using just audio 
  playAudio(String audioUrl) async {
    await audioPlayer.setUrl(audioUrl);
    await audioPlayer.play();
    audioPlayer.playerStateStream.listen((event) {
      log("player state: $event");
    });
   audioPlayer.durationStream.listen((duration) async {
    // Convert duration to human-readable format
      formatDuration(duration!);

    // Synthesize audio for the duration
    // final tts = Tts();
    // final synthesizedAudio = await tts.speak(formattedDuration);

    // Play the synthesized audio
    // final audioPlayer1 = AudioPlayer();
    // await audioPlayer1.setUrl(audioUrl);
    // await audioPlayer1.play();
  });
  }

  
String formatDuration(Duration duration) {
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds % 60;
  return '$minutes:$seconds';
}
}
