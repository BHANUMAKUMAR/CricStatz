import 'package:cricstatz/config/palette.dart';
import 'package:flutter/material.dart';

class PlayerStatsScreen extends StatelessWidget {
  const PlayerStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<_PlayingXiData> playingXi = <_PlayingXiData>[
      _PlayingXiData(
        name: 'Rohit\nSharma',
        role: 'Top-order Batter',
        badge: 'C',
        score: '47 (31)',
        metric: 'S/R: 151.6',
      ),
      _PlayingXiData(
        name: 'KL Rahul',
        role: 'Wicketkeeper Batter',
        badge: 'WK',
        score: '66 (107)',
        metric: 'S/R: 61.7',
      ),
      _PlayingXiData(
        name: 'Virat Kohli',
        role: 'Middle-order Batter',
        badge: 'VC',
        score: '54 (63)',
        metric: 'S/R: 85.7',
      ),
      _PlayingXiData(
        name: 'Mohammed\nShami',
        role: 'Right-arm Fast',
        score: '1/47 (7.0)',
        metric: 'ECON: 6.71',
      ),
      _PlayingXiData(
        name: 'Jasprit\nBumrah',
        role: 'Right-arm Fast',
        score: '2/43 (9.0)',
        metric: 'ECON: 4.78',
      ),
    ];

    const List<_BenchData> bench = <_BenchData>[
      _BenchData(name: 'Ishan Kishan', role: 'Wicketkeeper Batter'),
      _BenchData(name: 'Ravichandran Ashwin', role: 'Bowling All-rounder'),
      _BenchData(name: 'Prasidh Krishna', role: 'Right-arm Fast'),
    ];

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppPalette.surfaceGradient),
        child: SafeArea(
          child: Column(
            children: [
              _PlayersHeader(onBack: () => Navigator.pop(context)),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  children: [
                    const _TeamSelector(),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Text(
                          'Playing XI',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppPalette.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF263349),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            '11 PLAYERS',
                            style: TextStyle(color: AppPalette.textMuted, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    for (final player in playingXi) ...[
                      _PlayingXiRow(data: player),
                      const Divider(color: AppPalette.cardStroke, height: 1),
                    ],
                    const SizedBox(height: 18),
                    Text(
                      'Bench Players',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppPalette.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 12),
                    for (final sub in bench) ...[
                      _BenchCard(data: sub),
                      const SizedBox(height: 8),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayersHeader extends StatelessWidget {
  const _PlayersHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    Widget tab(String label, bool active) {
      return Padding(
        padding: const EdgeInsets.only(right: 24),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: active ? AppPalette.navActive : AppPalette.textMuted,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            if (active)
              Container(
                width: 72,
                height: 2,
                color: AppPalette.navActive,
              ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back, color: AppPalette.textPrimary),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'IND vs AUS',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppPalette.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const Text(
                      "Final - ICC Men's WC 2023",
                      style: TextStyle(color: AppPalette.textMuted),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined, color: AppPalette.textPrimary),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppPalette.cardStroke)),
          ),
          child: Row(
            children: [
              tab('INFO', false),
              tab('LIVE', false),
              tab('SCORECARD', false),
              tab('PLAYERS', true),
            ],
          ),
        ),
      ],
    );
  }
}

class _TeamSelector extends StatelessWidget {
  const _TeamSelector();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2C43),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('INDIA', style: TextStyle(color: AppPalette.textMuted, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppPalette.bgSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('AUSTRALIA', style: TextStyle(color: AppPalette.textPrimary, fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayingXiData {
  const _PlayingXiData({
    required this.name,
    required this.role,
    required this.score,
    required this.metric,
    this.badge,
  });

  final String name;
  final String role;
  final String score;
  final String metric;
  final String? badge;
}

class _PlayingXiRow extends StatelessWidget {
  const _PlayingXiRow({required this.data});

  final _PlayingXiData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFF2B3A52),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Center(
                  child: Text(
                    data.name.characters.first,
                    style: const TextStyle(color: AppPalette.textPrimary, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              if (data.badge != null)
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: data.badge == 'C' ? const Color(0xFFFACC15) : const Color(0xFF475569),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      data.badge!,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppPalette.bgPrimary),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppPalette.textPrimary,
                        fontWeight: FontWeight.w700,
                        height: 1.05,
                      ),
                ),
                Text(
                  data.role,
                  style: const TextStyle(color: AppPalette.textMuted),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data.score,
                style: const TextStyle(color: AppPalette.accent, fontSize: 28, fontWeight: FontWeight.w700),
              ),
              Text(
                data.metric,
                style: const TextStyle(color: AppPalette.textMuted, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BenchData {
  const _BenchData({required this.name, required this.role});

  final String name;
  final String role;
}

class _BenchCard extends StatelessWidget {
  const _BenchCard({required this.data});

  final _BenchData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF243247),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF324154)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF34465E),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Center(
              child: Text(
                data.name.characters.first,
                style: const TextStyle(color: AppPalette.textPrimary, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: const TextStyle(color: AppPalette.textPrimary, fontSize: 22, fontWeight: FontWeight.w700),
              ),
              Text(data.role, style: const TextStyle(color: AppPalette.textMuted)),
            ],
          ),
        ],
      ),
    );
  }
}
