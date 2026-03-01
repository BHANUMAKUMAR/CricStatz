import 'package:cricstatz/models/scoreboard.dart';
import 'package:flutter/material.dart';

class ScoreboardWidget extends StatelessWidget {
  const ScoreboardWidget({super.key, required this.scoreboard});

  final Scoreboard scoreboard;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Current Score', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(scoreboard.display, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
