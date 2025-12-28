import 'dart:ui'; // Required for FontFeature
import 'package:flutter/material.dart';

class LiveViewContainer extends StatelessWidget {
  final String piIpAddress;
  final double height;

  const LiveViewContainer({
    super.key,
    required this.piIpAddress,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: ClipRRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'http://$piIpAddress:5000/video_feed',
              fit: BoxFit.cover,
              gaplessPlayback: true,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.videocam_off_outlined, color: Colors.redAccent, size: 48),
                      const SizedBox(height: 12),
                      const Text(
                        "Signal Lost",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      Text(
                        "Check Connection to $piIpAddress",
                        style: TextStyle(color: Colors.white30, fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                );
              },
            ),

            Positioned(
              top: 15,
              right: 15,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    DateTime now = DateTime.now();

                    String timeString = "${now.hour}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
                    String dateString = "${now.month}/${now.day}/${now.year}";

                    return Text(
                      "$dateString  |  $timeString",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}