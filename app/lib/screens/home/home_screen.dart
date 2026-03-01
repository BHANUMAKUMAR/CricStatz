import 'package:cricstatz/config/routes.dart';
import 'package:cricstatz/config/assets.dart';
import 'package:cricstatz/config/palette.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.createMatch),
          backgroundColor: AppPalette.accent,
          foregroundColor: AppPalette.bgSecondary,
          child: const Icon(Icons.add, size: 30),
        ),
        bottomNavigationBar: const _BottomNavBar(),
        body: DecoratedBox(
          decoration: const BoxDecoration(gradient: AppPalette.surfaceGradient),
          child: SafeArea(
            child: Column(
              children: [
                const _Header(),
                TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: AppPalette.navActive,
                  labelColor: AppPalette.navActive,
                  unselectedLabelColor: AppPalette.textMuted,
                  onTap: (int index) {
                    if (index == 1) {
                      Navigator.pushNamed(context, AppRoutes.matches);
                    } else if (index == 2) {
                      Navigator.pushNamed(context, AppRoutes.matchStats);
                    } else if (index == 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('My Matches screen is coming soon.')),
                      );
                    }
                  },
                  tabs: [
                    Tab(text: 'Live'),
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Results'),
                    Tab(text: "My Match's"),
                  ],
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: const [
                      _LiveMatchSection(),
                      SizedBox(height: 18),
                      _UpcomingMatchesSection(),
                      SizedBox(height: 18),
                      _RecentResultsSection(),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 40),
          Expanded(
            child: Text(
              'CRICSTATZ',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFFE11D2E),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppPalette.bgSecondary.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.notifications_none, color: AppPalette.textPrimary),
          ),
        ],
      ),
    );
  }
}

class _LiveMatchSection extends StatelessWidget {
  const _LiveMatchSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Live Match',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppPalette.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const Spacer(),
            const Icon(Icons.circle, color: AppPalette.live, size: 8),
            const SizedBox(width: 6),
            Text(
              'LIVE',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppPalette.live,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0x660A1F43),
            border: Border.all(color: const Color(0x800A1F43)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0x990A1F43),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "ICC MEN'S WORLD\nCUP",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: const Color(0xFFE2E8F0),
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700,
                            height: 1.4,
                          ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Final • Narendra Modi\nStadium',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppPalette.textMuted,
                          height: 1.4,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _TeamBadge(flag: 'IND', assetPath: AppAssets.flagInd),
                  _ScoreCenter(),
                  _TeamBadge(flag: 'AUS', assetPath: AppAssets.flagAus, faded: true),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0x0DFFFFFF)),
                ),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFFCBD5E1)),
                        children: const [
                          TextSpan(text: 'India needs '),
                          TextSpan(text: '42 runs', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                          TextSpan(text: ' in '),
                          TextSpan(text: '60 balls', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: 0.85,
                        minHeight: 6,
                        backgroundColor: const Color(0xFF334155),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppPalette.progress),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.matchStats),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F5F9),
                    foregroundColor: AppPalette.bgSecondary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('View Full Scorecard', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, size: 7, color: AppPalette.textPrimary),
              SizedBox(width: 4),
              Icon(Icons.circle_outlined, size: 7, color: AppPalette.textMuted),
              SizedBox(width: 4),
              Icon(Icons.circle_outlined, size: 7, color: AppPalette.textMuted),
            ],
          ),
        ),
      ],
    );
  }
}

class _TeamBadge extends StatelessWidget {
  const _TeamBadge({required this.flag, required this.assetPath, this.faded = false});

  final String flag;
  final String assetPath;
  final bool faded;

  @override
  Widget build(BuildContext context) {
    final double opacity = faded ? 0.55 : 1;
    return Opacity(
      opacity: opacity,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF334155),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFF475569), width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                assetPath,
                width: 52,
                height: 52,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Center(
                    child: Text(
                      flag == 'IND' ? 'IN' : 'AU',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppPalette.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            flag,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppPalette.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}

class _ScoreCenter extends StatelessWidget {
  const _ScoreCenter();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppPalette.textPrimary),
            children: [
              const TextSpan(text: '342/5 ', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28)),
              TextSpan(
                text: '(40.0)',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppPalette.textSubtle),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'VS',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppPalette.textPrimary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
          ),
        ),
      ],
    );
  }
}

class _UpcomingMatchesSection extends StatelessWidget {
  const _UpcomingMatchesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Upcoming Matches',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppPalette.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.matches),
              child: const Text('View All'),
            ),
          ],
        ),
        SizedBox(
          height: 118,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _UpcomingCard(
                time: 'TOMORROW, 14:00',
                teamA: 'ENG',
                teamB: 'RSA',
                subtitle: 'ODI Series • Lords, London',
              ),
              SizedBox(width: 12),
              _UpcomingCard(
                time: '24 MAY, 19:30',
                teamA: 'NZL',
                teamB: 'PAK',
                subtitle: 'T20 International • Auckland',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UpcomingCard extends StatelessWidget {
  const _UpcomingCard({
    required this.time,
    required this.teamA,
    required this.teamB,
    required this.subtitle,
  });

  final String time;
  final String teamA;
  final String teamB;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppPalette.cardOverlay,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppPalette.cardStroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppPalette.textMuted,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(teamA, style: const TextStyle(color: AppPalette.textPrimary, fontWeight: FontWeight.w600)),
              const Spacer(),
              const Text('vs', style: TextStyle(color: AppPalette.textMuted)),
              const Spacer(),
              Text(teamB, style: const TextStyle(color: AppPalette.textPrimary, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: AppPalette.textSubtle, fontSize: 11)),
        ],
      ),
    );
  }
}

class _RecentResultsSection extends StatelessWidget {
  const _RecentResultsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Results',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppPalette.textPrimary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12),
        const _ResultCard(
          lineOne: 'SL 210/10 (48.2)',
          lineTwo: 'BAN 211/4 (44.5)',
          when: 'Yesterday',
          outcome: 'Bangladesh won by 6 wkts',
        ),
        const SizedBox(height: 12),
        const _ResultCard(
          lineOne: 'WI 189/2 (18.4)',
          lineTwo: 'AFG 188/8 (20.0)',
          when: '22 May',
          outcome: 'West Indies won by 8 wkts',
        ),
      ],
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.lineOne, required this.lineTwo, required this.when, required this.outcome});

  final String lineOne;
  final String lineTwo;
  final String when;
  final String outcome;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppPalette.cardOverlay.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppPalette.cardStroke),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(lineOne, style: const TextStyle(color: AppPalette.textPrimary, fontWeight: FontWeight.w700)),
              const Spacer(),
              Text(when, style: const TextStyle(color: AppPalette.textSubtle, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(lineTwo, style: const TextStyle(color: AppPalette.success, fontWeight: FontWeight.w700)),
              const Spacer(),
              Text(outcome, style: const TextStyle(color: AppPalette.textSubtle, fontSize: 11)),
            ],
          ),
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
