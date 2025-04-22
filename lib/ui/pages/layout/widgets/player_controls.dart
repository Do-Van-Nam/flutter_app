// lib/ui/widgets/player_controls.dart

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import 'package:flutter_app/routes/app_pages.dart';

class PlayerControls extends StatefulWidget {
  const PlayerControls({Key? key}) : super(key: key);

  @override
  _PlayerControlsState createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isShuffled = false;

  @override
  void initState() {
    super.initState();

    // 1. Load a playlist (replace URLs with your own)
    _player.setAudioSource(
      ConcatenatingAudioSource(children: [
       AudioSource.uri(Uri.parse('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3')),
        AudioSource.uri(Uri.parse('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3'))
      ]),
    );

    // 2. Listen to playing state
    _player.playingStream.listen((playing) {
      setState(() => _isPlaying = playing);
    });

    // 3. Listen to position changes
    _player.positionStream.listen((pos) {
      setState(() => _position = pos);
    });

    // 4. Listen to duration changes
    _player.durationStream.listen((dur) {
      setState(() => _duration = dur ?? Duration.zero);
    });

    // 5. Listen to shuffle mode changes
    _player.shuffleModeEnabledStream.listen((enabled) {
      setState(() => _isShuffled = enabled);
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatTime(Duration d) {
    final twoDigits = (int n) => n.toString().padLeft(2, '0');
    final m = twoDigits(d.inMinutes.remainder(60));
    final s = twoDigits(d.inSeconds.remainder(60));
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Progress bar thay cho border
    // LinearProgressIndicator(
    //   value: _duration.inMilliseconds == 0 ? 0 : _position.inMilliseconds / _duration.inMilliseconds,
    //   backgroundColor: const Color(0xFFEEEEEE),
    //   valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE53935)),
    //   minHeight: 3,
    // ),
        
        SliderTheme(
  data: SliderTheme.of(context).copyWith(
    trackHeight: 4, // độ dày như LinearProgress
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0), // ẩn thumb
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 0), // ẩn hiệu ứng khi nhấn
    activeTrackColor: Colors.red, // màu đã phát
    inactiveTrackColor: Colors.grey[300], // màu chưa phát
  ),
  child: Slider(
    min: 0,
    max: _duration.inMilliseconds.toDouble(),
    value: _position.inMilliseconds.clamp(0, _duration.inMilliseconds).toDouble(),
    onChanged: (value) => _player.seek(Duration(milliseconds: value.toInt())),
  ),
),

        Container(
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white,
            border: const Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2)),
            ],
          ),
          child: Row(
            children: [
              // Song info (placeholder)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        'assets/images/Rectangle 6166-1.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Như Chưa Bao Giờ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        SizedBox(height: 4),
                        Text('Hồ Quang Hiếu • 10 Tr lượt xem', style: TextStyle(color: Color(0xFF757575), fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
        
              // Like & More
              IconButton(icon: const Icon(Icons.favorite, color: Color(0xFFE53935)), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_horiz, color: Color(0xFF757575)), onPressed: (){}),
        
              const Spacer(),
        
              // Shuffle
              IconButton(
                icon: Icon(_isShuffled ? Icons.shuffle_on : Icons.shuffle, color: const Color(0xFF757575)),
                onPressed: () => _player.setShuffleModeEnabled(!_isShuffled),
              ),
        
              // Previous
              IconButton(
                icon: const Icon(Icons.skip_previous, color: Color(0xFF212121), size: 28),
                onPressed: _player.hasPrevious ? () => _player.seekToPrevious() : null,
              ),
        
              // Play / Pause
              GestureDetector(
                onTap: () => _isPlaying ? _player.pause() : _player.play(),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53935),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: const Color(0xFFE53935).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 28),
                ),
              ),
        
              // Next
              IconButton(
                icon: const Icon(Icons.skip_next, color: Color(0xFF212121), size: 28),
                onPressed: _player.hasNext ? () => _player.seekToNext() : null,
              ),
        
              // Repeat
              IconButton(
                icon: Icon(
                  _player.loopMode == LoopMode.one ? Icons.repeat_one : Icons.repeat,
                  color: const Color(0xFF757575),
                ),
                onPressed: () {
                  final nextMode = LoopMode.values[(_player.loopMode.index + 1) % LoopMode.values.length];
                  _player.setLoopMode(nextMode);
                },
              ),
        
              const Spacer(),
        
              // Time display
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '${_formatTime(_position)} / ${_formatTime(_duration)}',
                  style: const TextStyle(color: Color(0xFF757575), fontSize: 12),
                ),
              ),
        
              // Volume slider
              
        SizedBox(
  width: 100,
  child: SliderTheme(
    data: SliderTheme.of(context).copyWith(
      trackHeight: 4,
      thumbColor: Colors.red,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
      activeTrackColor: Colors.red,
      inactiveTrackColor: Colors.grey[300],
    ),
    child: Slider(
      min: 0,
      max: 1,
      value: _player.volume.clamp(0.0, 1.0),
      onChanged: (value) => _player.setVolume(value),
    ),
  ),
),
              // Volume toggle
              IconButton(
                icon: Icon(
                  _player.volume > 0 ? Icons.volume_up : Icons.volume_off,
                  color: const Color(0xFF757575),
                ),
                onPressed: () => _player.setVolume(_player.volume > 0 ? 0 : 1),
              ),
        
              // Expand to full player
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_up, color: Color(0xFF757575)),
                onPressed: () => Get.toNamed(Routes.PLAYING),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
