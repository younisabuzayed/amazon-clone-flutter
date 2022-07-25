import 'package:amazon_clone/screens/search/search_screen.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class CustomModalBottom extends StatefulWidget {
  VoidCallback onSccussMove;
  CustomModalBottom({
    Key? key,
    required this.onSccussMove,
  }) : super(key: key);

  @override
  State<CustomModalBottom> createState() => _CustomModalBottomState();
}

class _CustomModalBottomState extends State<CustomModalBottom> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String statusListening = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      onStatus: (status) {
        setState(() {
          statusListening = status;
          print(status);
        });
      },
    );
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) async {
    _lastWords = result.recognizedWords;
    if (_speechToText.isNotListening) {
      _stopListening();
      widget.onSccussMove();
      if (_lastWords.isNotEmpty) {
        Navigator.pushNamed(
          context,
          Search.routeName,
          arguments: _lastWords,
        );
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    print(_speechToText.isListening);
    return SizedBox(
      height: mediaQuery.height * 0.3,
      child: Column(
        children: [
          Text(
            _speechToText.isListening
                ? _lastWords
                : _speechEnabled
                    ? 'Tap the microphone to start listening...'
                    : 'Speech not available',
          ),
          AvatarGlow(
              animate: _speechToText.isListening,
              endRadius: 75.0,
              duration: const Duration(milliseconds: 2000),
              repeatPauseDuration: const Duration(milliseconds: 100),
              glowColor: Colors.blue,
              repeat: true,
              child: FloatingActionButton(
                onPressed: () => _startListening(),
                child: Icon(
                    _speechToText.isListening ? Icons.mic : Icons.mic_none),
              ))
        ],
      ),
    );
  }
}
