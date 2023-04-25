import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: CircularPercentIndicator(
                animation: true,
                animationDuration: 900,
                radius: 70.0,
                lineWidth: 8.0,
                percent: 1.0,
                center: const Text(
                  "Loading...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                progressColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
