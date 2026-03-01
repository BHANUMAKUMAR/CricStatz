import 'package:cricstatz/providers/scoring_provider.dart';
import 'package:cricstatz/widgets/scoreboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScoringScreen extends StatelessWidget {
  const ScoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScoringProvider scoringProvider = context.watch<ScoringProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Live Scoring')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ScoreboardWidget(scoreboard: scoringProvider.scoreboard),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final int run in <int>[0, 1, 2, 3, 4, 6])
                  ElevatedButton(
                    onPressed: () => scoringProvider.addDelivery(runs: run),
                    child: Text('+$run'),
                  ),
                ElevatedButton(
                  onPressed: () => scoringProvider.addDelivery(runs: 0, wicket: true),
                  child: const Text('Wicket'),
                ),
                OutlinedButton(
                  onPressed: scoringProvider.reset,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
