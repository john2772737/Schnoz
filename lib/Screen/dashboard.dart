import 'package:flutter/material.dart';
import 'package:schnoz/Screen/Start_Screen.dart';
import '../constants/app_color.dart';
import '../Screen/live_View.dart';
import '../components/modal.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Row(
        children: [
          // --- LEFT SIDE (1/3 Width) ---
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    // Add 50 pixels of space at the top only
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Image.asset(
                      'assets/images/Schnoz_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      print("Capture");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.captureButtonColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: const Text("CAPTURE"),
                  ),
                  // YOUR BUTTON
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomModal(
                            title: 'Sign Out',
                            message: 'Are you sure you want to Sign Out?',
                            confirmText: "Confirm",
                            cancelText: "Cancel",
                            onConfirm: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const StartScreen()),
                                    (route) => false, // This returns 'false' for all previous routes, deleting them.
                              );
                            },
                          ),
                        ); // <--- THIS WAS MISSING
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                      child: const Text("SIGN OUT"),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- RIGHT SIDE (2/3 Width) ---
          Expanded(flex: 3, child: LiveViewContainer(piIpAddress: 's')),
        ],
      ),
    );
  }
}
