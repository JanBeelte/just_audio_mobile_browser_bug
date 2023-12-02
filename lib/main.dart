import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MainScreen(),
      home: const AudioExample(title: 'Audio Example'),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Audio Example Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AudioExample(title: 'Audio Example')),
                  );
                },
                child: const Text('Audio Example'))
          ],
        ),
      ),
    );
  }
}

class AudioExample extends StatefulWidget {
  const AudioExample({super.key, required this.title});

  final String title;

  @override
  State<AudioExample> createState() => _AudioExampleState();
}

class _AudioExampleState extends State<AudioExample> {
  final audioPlayer = AudioPlayer();
  bool audioLoaded = false;

  @override
  void initState() {
    super.initState();
    loadAudio();
  }

  Future<void> loadAudio() async {
    if (audioLoaded) return;
    final duration = await audioPlayer.setUrl(
        "https://firebasestorage.googleapis.com/v0/b/facilify-405411.appspot.com/o/shared_audio%2Fdeep-meditation-bell-hit-root-chakra-1-174455.mp3?alt=media&token=23a92a43-7367-4a18-bbb3-6654cd56a233");
    // final duration = await audioPlayer
    //     .setAsset("assets/deep-meditation-bell-hit-root-chakra-1-174455.mp3");
    if (duration == null) return;
    setState(() => audioLoaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () async {
                  if (!audioPlayer.playing) {
                    await loadAudio();
                    await audioPlayer.seek(Duration.zero);
                    audioPlayer.play();
                  } else {
                    audioPlayer.stop();
                  }
                },
                child: const Text('Play Audio!'))
          ],
        ),
      ),
    );
  }
}
