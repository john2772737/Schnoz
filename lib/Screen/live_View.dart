import 'package:flutter/material.dart';

class LiveViewContainer extends StatelessWidget {
  final String piIpAddress;
  final double height; // Optional: Force a specific height if needed

  const LiveViewContainer({
    Key? key,
    required this.piIpAddress,
    this.height = double.infinity, // Defaults to filling available space
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The Container provides the "Frame" (Border, Shadow, Background)
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black, // Background color behind video
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white24, // Subtle grey border
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4), // Shadow drops down slightly
          )
        ],
      ),

      // ClipRRect forces the Video to respect the Rounded Corners
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14), // Slightly less than Container to fit inside
        child: Stack(
          fit: StackFit.expand,
          children: [
            // LAYER 1: The Video Stream
            Image.network(
              'http://$piIpAddress:5000/video_feed',
              fit: BoxFit.cover, // Fills the box without stretching
              gaplessPlayback: true, // Prevents flickering when frame updates

              // Error Handling: What if the Pi is offline?
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.videocam_off_outlined, color: Colors.redAccent, size: 48),
                      const SizedBox(height: 12),
                      Text(
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

              // Loading State: What to show while connecting?
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                );
              },
            ),

            // LAYER 2: (Optional) Overlay "REC" indicator or Grid
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: Colors.green, size: 10),
                    const SizedBox(width: 6),
                    Text(
                      "LIVE",
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}