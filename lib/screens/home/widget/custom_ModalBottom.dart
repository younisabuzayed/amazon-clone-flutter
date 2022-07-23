import 'package:amazon_clone/screens/search/search_screen.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class CustomModalBottom extends StatefulWidget {
  // final SpeechToText speechToText;
  // final VoidCallback startListening;
  // final VoidCallback stopListening;
  // final bool isListening;
  // final String result;
  // final bool speechEnabled;
  CustomModalBottom({
    Key? key,
    // required this.startListening,
    // required this.stopListening,
    // required this.isListening,
    // required this.speechEnabled,
    // required this.result, required this.speechToText,
  }) : super(key: key);

  @override
  State<CustomModalBottom> createState() => _CustomModalBottomState();
}

class _CustomModalBottomState extends State<CustomModalBottom> {
  SpeechToText _speechToText = SpeechToText();
  bool isListening = false;
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
        // print(status);
        if (status == "done") {
          _stopListening();
          if (_lastWords.isNotEmpty) {
            _navigateToSearchScreen(_lastWords);
          }
        }
      },
    );
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      isListening = true;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      isListening = false;
    });
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  void _navigateToSearchScreen(String query) {
    Navigator.of(context).pushNamed(
      Search.routeName,
      arguments: query,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    print(_lastWords);
    return Container(
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
              child: ElevatedButton(
                onPressed: _speechToText.isNotListening
                    ? _startListening
                    : _stopListening,
                child: Icon(
                    _speechToText.isListening ? Icons.mic : Icons.mic_none),
              ))
        ],
      ),
    );
  }
}
