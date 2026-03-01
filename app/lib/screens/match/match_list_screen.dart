import 'package:cricstatz/config/routes.dart';
import 'package:cricstatz/config/assets.dart';
import 'package:cricstatz/config/palette.dart';
import 'package:flutter/material.dart';

class MatchListScreen extends StatelessWidget {
  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<_FixtureCardData> fixtures = <_FixtureCardData>[
      _FixtureCardData(
        date: 'TOMORROW, 14:00',
        format: 'T20',
        teamA: 'INDIA',
        teamB: 'AUSTRALIA',
        teamAFlag: AppAssets.flagInd,
        teamBFlag: AppAssets.flagAus,
        venue: 'Narendra Modi Stadium, Ahmedabad',
        primaryLabel: 'Start Match',
      ),
      _FixtureCardData(
        date: 'SAT, 24 JUNE • 09:30',
        format: 'ODI',
        teamA: 'ENGLAND',
        teamB: 'SOUTH\nAFRICA',
        teamAFlag: AppAssets.flagEng,
        teamBFlag: AppAssets.flagRsa,
        venue: "Lord's Cricket Ground, London",
        primaryLabel: 'Set Reminder',
      ),
      _FixtureCardData(
        date: 'SUN, 25 JUNE • 11:00',
        format: 'TEST',
        formatColor: Color(0xFFDC2626),
        teamA: 'NEW\nZEALAND',
        teamB: 'PAKISTAN',
        teamAFlag: AppAssets.flagNzl,
        teamBFlag: AppAssets.flagPak,
        venue: 'Hagley Oval, Christchurch',
        primaryLabel: 'Set Reminder',
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
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                  children: [
                    Row(
                      children: [
                        Text(
                          'International Fixtures',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppPalette.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0x1A00C2FF),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'T20 WORLD CUP',
                            style: TextStyle(
                              color: AppPalette.accent,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    for (final fixture in fixtures) ...[
                      _FixtureCard(
                        data: fixture,
                        onPrimaryTap: () {
                          if (fixture.primaryLabel == 'Start Match') {
                            Navigator.pushNamed(context, AppRoutes.toss);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Reminder feature will be connected soon.')),
                            );
                          }
                        },
                        onDetailsTap: () => Navigator.pushNamed(context, AppRoutes.createMatch),
                      ),
                      const SizedBox(height: 14),
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

class _FixtureCardData {
  const _FixtureCardData({
    required this.date,
    required this.format,
    required this.teamA,
    required this.teamB,
    required this.teamAFlag,
    required this.teamBFlag,
    required this.venue,
    required this.primaryLabel,
    this.formatColor = AppPalette.bgSecondary,
  });

  final String date;
  final String format;
  final Color formatColor;
  final String teamA;
  final String teamB;
  final String teamAFlag;
  final String teamBFlag;
  final String venue;
  final String primaryLabel;
}

class _FixtureCard extends StatelessWidget {
  const _FixtureCard({
    required this.data,
    required this.onPrimaryTap,
    required this.onDetailsTap,
  });

  final _FixtureCardData data;
  final VoidCallback onPrimaryTap;
  final VoidCallback onDetailsTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C2431),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D3748)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF2D3748))),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 13, color: AppPalette.textMuted),
                const SizedBox(width: 8),
                Text(
                  data.date,
                  style: const TextStyle(
                    color: AppPalette.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: data.formatColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    data.format,
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Expanded(child: _TeamColumn(name: data.teamA, flagAsset: data.teamAFlag)),
                const Opacity(
                  opacity: 0.5,
                  child: Text('VS', style: TextStyle(color: AppPalette.textMuted, fontSize: 30, fontWeight: FontWeight.w700)),
                ),
                Expanded(child: _TeamColumn(name: data.teamB, flagAsset: data.teamBFlag)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: AppPalette.textMuted),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        data.venue,
                        style: const TextStyle(color: AppPalette.textMuted, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: onPrimaryTap,
                        style: FilledButton.styleFrom(
                          backgroundColor: data.primaryLabel == 'Start Match' ? AppPalette.accent : const Color(0x3300C2FF),
                          foregroundColor: data.primaryLabel == 'Start Match' ? AppPalette.bgSecondary : AppPalette.accent,
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(data.primaryLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: onDetailsTap,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppPalette.textPrimary,
                        side: const BorderSide(color: Color(0xFF2D3748)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Details', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamColumn extends StatelessWidget {
  const _TeamColumn({required this.name, required this.flagAsset});

  final String name;
  final String flagAsset;

  @override
  Widget build(BuildContext context) {
    final List<String> lines = name.split('\n');
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF334155),
            borderRadius: BorderRadius.circular(999),
          ),
          child: ClipOval(
            child: Image.asset(
              flagAsset,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return Center(
                  child: Text(
                    lines.first.substring(0, lines.first.length.clamp(0, 2)).toUpperCase(),
                    style: const TextStyle(color: AppPalette.textPrimary, fontWeight: FontWeight.w700),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppPalette.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            height: 1.35,
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
                    letterSpacing: 0.5,
                  ),
            ),
          ),
          Row(
            children: [
              _HeaderAction(icon: Icons.calendar_month_outlined),
              const SizedBox(width: 8),
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
          tab('Upcoming', true, () {}),
          tab('Results', false, () => Navigator.pushNamed(context, AppRoutes.matchStats)),
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
