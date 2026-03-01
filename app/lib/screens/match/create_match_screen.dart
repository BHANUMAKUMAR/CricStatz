import 'package:cricstatz/config/routes.dart';
import 'package:cricstatz/config/palette.dart';
import 'package:flutter/material.dart';

class CreateMatchScreen extends StatefulWidget {
  const CreateMatchScreen({super.key});

  @override
  State<CreateMatchScreen> createState() => _CreateMatchScreenState();
}

class _CreateMatchScreenState extends State<CreateMatchScreen> {
  bool boundaryTracking = true;
  bool extraBallPenalty = true;
  bool freeHitRule = false;
  int extraBallRuns = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppPalette.surfaceGradient),
        child: SafeArea(
          child: Column(
            children: [
              _TopBar(onBack: () => Navigator.pop(context)),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                  children: [
                    const _Stepper(),
                    const SizedBox(height: 28),
                    Text(
                      'Scoring Setup',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppPalette.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Configure the match rules and penalty parameters.',
                      style: TextStyle(
                        color: AppPalette.textMuted,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xAA071A35),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0x332E4D76)),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: AppPalette.accent),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'These scoring parameters and gameplay rules will be applied automatically to both innings of the match.',
                              style: TextStyle(color: AppPalette.textPrimary, fontSize: 24, height: 1.35),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'GAMEPLAY RULES',
                      style: TextStyle(
                        color: AppPalette.accent,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _RuleTile(
                      title: 'Boundary Tracking',
                      subtitle: 'Track 4s and 6s individually',
                      value: boundaryTracking,
                      onChanged: (bool value) => setState(() => boundaryTracking = value),
                    ),
                    const SizedBox(height: 12),
                    _RuleTile(
                      title: 'Extra Ball Penalty',
                      subtitle: 'Runs awarded for Wides and No-balls',
                      value: extraBallPenalty,
                      onChanged: (bool value) => setState(() => extraBallPenalty = value),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Row(
                          children: [
                            const Text('Runs:', style: TextStyle(color: AppPalette.textMuted, fontSize: 13)),
                            const SizedBox(width: 10),
                            DropdownButtonHideUnderline(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xAA0C1E3D),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFF2A3A52)),
                                ),
                                child: DropdownButton<int>(
                                  value: extraBallRuns,
                                  dropdownColor: const Color(0xFF102244),
                                  style: const TextStyle(color: AppPalette.textPrimary, fontSize: 16),
                                  iconEnabledColor: AppPalette.textMuted,
                                  items: List<DropdownMenuItem<int>>.generate(
                                    5,
                                    (int index) => DropdownMenuItem<int>(
                                      value: index + 1,
                                      child: Text('${index + 1} Run${index == 0 ? '' : 's'}'),
                                    ),
                                  ),
                                  onChanged: (int? value) {
                                    if (value == null) {
                                      return;
                                    }
                                    setState(() => extraBallRuns = value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _RuleTile(
                      title: 'Free Hit Rule',
                      subtitle: 'No-ball followed by a free hit',
                      value: freeHitRule,
                      onChanged: (bool value) => setState(() => freeHitRule = value),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.toss),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppPalette.accent,
                      foregroundColor: AppPalette.bgSecondary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'CREATE MATCH  >',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 0.4),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'All match details can be edited before the first ball.',
                  style: TextStyle(color: AppPalette.textSubtle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: AppPalette.bgSecondary,
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, color: AppPalette.textPrimary),
          ),
          Expanded(
            child: Text(
              'Match Creation',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppPalette.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help_outline, color: AppPalette.textMuted),
          ),
        ],
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper();

  @override
  Widget build(BuildContext context) {
    Widget dot(String label, bool active) {
      return Column(
        children: [
          Icon(
            Icons.circle,
            size: active ? 16 : 12,
            color: active ? AppPalette.accent : AppPalette.navActive,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppPalette.accent,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: Center(child: dot('INFO', false))),
        const Expanded(child: Divider(color: AppPalette.accent, thickness: 2, indent: 8, endIndent: 8)),
        Expanded(child: Center(child: dot('SQUADS', false))),
        const Expanded(child: Divider(color: AppPalette.accent, thickness: 2, indent: 8, endIndent: 8)),
        Expanded(child: Center(child: dot('SCORING', true))),
      ],
    );
  }
}

class _RuleTile extends StatelessWidget {
  const _RuleTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.child,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xAA111F39),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2A3A52)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppPalette.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(color: AppPalette.textMuted, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Switch(
                value: value,
                onChanged: onChanged,
                activeThumbColor: AppPalette.textPrimary,
                activeTrackColor: AppPalette.accent,
                inactiveThumbColor: const Color(0xFFE5E7EB),
                inactiveTrackColor: const Color(0xFF334155),
              ),
            ],
          ),
          if (child case final Widget childWidget) childWidget,
        ],
      ),
    );
  }
}
