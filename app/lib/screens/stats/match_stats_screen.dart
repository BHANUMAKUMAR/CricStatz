import 'package:cricstatz/config/assets.dart';
import 'package:cricstatz/config/palette.dart';
import 'package:cricstatz/config/routes.dart';
import 'package:flutter/material.dart';

class MatchStatsScreen extends StatelessWidget {
  const MatchStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<_ResultCardData> dateOne = <_ResultCardData>[
      _ResultCardData(
        format: 'ODI MATCH',
        rightLabel: 'Final Score',
        teamA: 'IND',
        teamB: 'AUS',
        teamAFlag: AppAssets.flagInd,
        teamBFlag: AppAssets.flagAus,
        scoreA: '352/7',
        scoreB: '254',
        winnerText: 'India won by 98 runs',
      ),
    ];

    const List<_ResultCardData> dateTwo = <_ResultCardData>[
      _ResultCardData(
        format: 'T20 INTERNATIONAL',
        rightLabel: 'Final Score',
        teamA: 'ENG',
        teamB: 'RSA',
        teamAFlag: AppAssets.flagEng,
        teamBFlag: AppAssets.flagRsa,
        scoreA: '188/4',
        scoreB: '192/3',
        winnerText: 'RSA won by 7 wickets',
        highlightTeamB: true,
      ),
      _ResultCardData(
        format: 'TEST MATCH',
        rightLabel: 'Day 5 - Stumps',
        teamA: 'NZL',
        teamB: 'PAK',
        teamAFlag: AppAssets.flagNzl,
        teamBFlag: AppAssets.flagPak,
        scoreA: '245 & 312',
        scoreB: '298 & 150/2',
        winnerText: 'Match Drawn',
      ),
    ];

    return Scaffold(
      bottomNavigationBar: const _BottomNavBar(),
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppPalette.surfaceGradient),
        child: SafeArea(
          child: Column(
            children: [
              const _TopHeader(),
              const _TopTabs(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                  children: [
                    Text(
                      'SEPTEMBER 24, 2023',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppPalette.textMuted,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                    ),
                    const SizedBox(height: 10),
                    for (final result in dateOne) ...[
                      _ResultCard(data: result),
                      const SizedBox(height: 16),
                    ],
                    Text(
                      'SEPTEMBER 22, 2023',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppPalette.textMuted,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                    ),
                    const SizedBox(height: 10),
                    for (final result in dateTwo) ...[
                      _ResultCard(data: result),
                      const SizedBox(height: 16),
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

class _ResultCardData {
  const _ResultCardData({
    required this.format,
    required this.rightLabel,
    required this.teamA,
    required this.teamB,
    required this.teamAFlag,
    required this.teamBFlag,
    required this.scoreA,
    required this.scoreB,
    required this.winnerText,
    this.highlightTeamB = false,
  });

  final String format;
  final String rightLabel;
  final String teamA;
  final String teamB;
  final String teamAFlag;
  final String teamBFlag;
  final String scoreA;
  final String scoreB;
  final String winnerText;
  final bool highlightTeamB;
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.data});

  final _ResultCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1E3F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppPalette.cardStroke),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A2E66),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    data.format,
                    style: const TextStyle(color: AppPalette.textPrimary, fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                ),
                const Spacer(),
                Text(
                  data.rightLabel,
                  style: const TextStyle(color: AppPalette.textMuted, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _TeamResultColumn(name: data.teamA, score: data.scoreA, flagAsset: data.teamAFlag, highlight: !data.highlightTeamB)),
                const Opacity(
                  opacity: 0.5,
                  child: Text('VS', style: TextStyle(color: AppPalette.textMuted, fontWeight: FontWeight.w700, fontSize: 28)),
                ),
                Expanded(child: _TeamResultColumn(name: data.teamB, score: data.scoreB, flagAsset: data.teamBFlag, highlight: data.highlightTeamB)),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(color: AppPalette.cardStroke, height: 1),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Text(
                    data.winnerText,
                    style: TextStyle(
                      color: data.winnerText == 'Match Drawn' ? AppPalette.textMuted : AppPalette.success,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: AppPalette.bgSecondary,
                    foregroundColor: AppPalette.textPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('View Scorecard', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamResultColumn extends StatelessWidget {
  const _TeamResultColumn({
    required this.name,
    required this.score,
    required this.flagAsset,
    required this.highlight,
  });

  final String name;
  final String score;
  final String flagAsset;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFF0B5E78),
            borderRadius: BorderRadius.circular(999),
          ),
          child: ClipOval(
            child: Image.asset(
              flagAsset,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return Center(
                  child: Text(
                    name.substring(0, name.length.clamp(0, 2)),
                    style: const TextStyle(color: AppPalette.textPrimary, fontWeight: FontWeight.w700),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(color: AppPalette.textPrimary, fontSize: 34, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          score,
          style: TextStyle(
            color: highlight ? AppPalette.accent : AppPalette.textPrimary,
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'CRICSTATZ',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFFE11D2E),
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          Row(
            children: const [
              _HeaderAction(icon: Icons.calendar_month_outlined),
              SizedBox(width: 8),
              _HeaderAction(icon: Icons.tune),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF1D2A43),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 18, color: AppPalette.textPrimary),
    );
  }
}

class _TopTabs extends StatelessWidget {
  const _TopTabs();

  @override
  Widget build(BuildContext context) {
    Widget tab(String label, bool active, VoidCallback onTap) {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: active ? AppPalette.navActive : AppPalette.textMuted,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              if (active)
                Container(
                  width: 64,
                  height: 2,
                  color: AppPalette.navActive,
                ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1E293B))),
      ),
      child: Row(
        children: [
          tab('Live', false, () => Navigator.pushNamed(context, AppRoutes.home)),
          tab('Upcoming', false, () => Navigator.pushNamed(context, AppRoutes.matches)),
          tab('Results', true, () {}),
          tab("My Matche’s", false, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('My Matches screen is coming soon.')),
            );
          }),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppPalette.bgPrimary,
      selectedItemColor: AppPalette.navActive,
      unselectedItemColor: AppPalette.navInactive,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
      currentIndex: 0,
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, AppRoutes.home);
            break;
          case 1:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Feed screen is coming soon.')),
            );
            break;
          case 2:
            Navigator.pushNamed(context, AppRoutes.teams);
            break;
          case 3:
            Navigator.pushNamed(context, AppRoutes.scoring);
            break;
          case 4:
            Navigator.pushNamed(context, AppRoutes.playerStats);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.rss_feed), label: 'Feed'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chats'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}
