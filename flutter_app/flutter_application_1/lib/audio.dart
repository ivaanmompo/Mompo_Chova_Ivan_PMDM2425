import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// El giny serà un giny amb estat
class ExempleAudioPlayer extends StatefulWidget {
  const ExempleAudioPlayer({super.key});

  @override
  _ExempleAudioPlayerState createState() => _ExempleAudioPlayerState();
}

class _ExempleAudioPlayerState extends State<ExempleAudioPlayer> {
  // Creem el player
  final player = AudioPlayer();

  // Inicialització
  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Configura la durada total de l'àudio. Quan carreguem la pista
    // es llançarà aquest event, de manera que sapiguem què dura l'áudio.
    player.onDurationChanged.listen((Duration duration) {
      setState(() {
        totalDuration = duration;
      });
    });

    // Actualitza la posició actual de reproducció:
    // Quan la posició de reproducció canvie, es canviarà la posició actual
    // de l'estat de manera que s'actualitze automàticament l'slider.
    player.onPositionChanged.listen((Duration position) {
      setState(() {
        currentPosition = position;
      });
    });

    // Escolta canvis d'estat de reproducció i actualitza la variable
    // isPlaying: Quan hi ha un canvi d'estat, es dispara aquest callback.
    // Si l'state que es res és "playing", isplaying serà true, i en cas
    // contrari, serà false.
    player.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  @override
  void dispose() {
    player.dispose(); // Allibera els recursos quan el widget es destrueix
    super.dispose();
  }

  void playAudio() async {
    await player.play(UrlSource(
        'https://ia802202.us.archive.org/7/items/acdc-high-voltage/ACDC%20-%20High%20Voltage/High%20Voltage/09%20High%20Voltage.mp3'));
  }

  void pauseAudio() async {
    await player.pause();
  }

  void stopAudio() async {
    await player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exemple d'àudio")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Slider(
              // Component de tipus Slider: https://api.flutter.dev/flutter/material/Slider-class.html
              min: 0,
              max: totalDuration.inSeconds.toDouble(),
              value: currentPosition.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await player.seek(position);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDuration(currentPosition)),
                Text(formatDuration(totalDuration)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: isPlaying ? pauseAudio : playAudio,
                  iconSize: 48,
                ),
                IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: stopAudio,
                  iconSize: 48,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Mètode auxiliar per mostrar la durada
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}