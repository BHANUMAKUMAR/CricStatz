import 'package:cricstatz/config/routes.dart';
import 'package:cricstatz/config/palette.dart';
import 'package:cricstatz/widgets/coin_flip_widget.dart';
import 'package:flutter/material.dart';

class TossScreen extends StatefulWidget {
  const TossScreen({super.key});

  @override
  State<TossScreen> createState() => _TossScreenState();
}

enum TossPhase { selection, flipping, result }

class _TossScreenState extends State<TossScreen> with TickerProviderStateMixin {
  String? selectedTeam;
  TossPhase _phase = TossPhase.selection;
  bool _resultHeads = true;
  late GlobalKey<CoinFlipWidgetState> _coinKey;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _coinKey = GlobalKey<CoinFlipWidgetState>();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_fadeController);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _handleFlipCoin() async {
    if (selectedTeam == null) return;

    setState(() => _phase = TossPhase.flipping);

    // Perform the flip and get result
    _resultHeads = await _coinKey.currentState!.flip();

    // Wait a moment then transition to result phase
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() => _phase = TossPhase.result);
      _fadeController.forward();
    }
  }

  void _handleStartMatch() {
    Navigator.pushNamed(context, AppRoutes.scoring);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppPalette.surfaceGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      onPressed: _phase == TossPhase.selection
                          ? () => Navigator.pop(context)
                          : null,
                      icon: const Icon(Icons.arrow_back,
                          color: AppPalette.textPrimary),
                    ),
                    Expanded(
                      child: Text(
                        'MATCH TOSS',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppPalette.textPrimary,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.1,
                            ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  _phase == TossPhase.result
                      ? 'Toss Result'
                      : selectedTeam == null
                          ? 'Who Won the Toss?'
                          : 'Toss For $selectedTeam',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppPalette.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 4),

                // Subtitle
                if (_phase != TossPhase.result)
                  const Text(
                    'Select the team that called it correctly',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: AppPalette.textMuted, fontSize: 20),
                  ),
                const SizedBox(height: 24),

                // Team cards (fade out during flipping)
                AnimatedOpacity(
                  opacity: _phase == TossPhase.flipping ? 0.3 : 1.0,
                  duration: const Duration(milliseconds: 400),
                  child: Opacity(
                    opacity: _phase == TossPhase.result ? 0 : 1,
                    child: Row(
                      children: [
                        Expanded(
                          child: _TeamChoiceCard(
                            label: 'TEAM A',
                            selected: selectedTeam == 'Team A',
                            onTap: _phase == TossPhase.selection
                                ? () =>
                                    setState(() => selectedTeam = 'Team A')
                                : null,
                            badgeLabel: 'A',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _TeamChoiceCard(
                            label: 'TEAM B',
                            selected: selectedTeam == 'Team B',
                            onTap: _phase == TossPhase.selection
                                ? () =>
                                    setState(() => selectedTeam = 'Team B')
                                : null,
                            badgeLabel: 'B',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),

                // Coin animation area
                if (_phase != TossPhase.result)
                  CoinFlipWidget(key: _coinKey)
                else
                  Column(
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            CoinFlipWidget(key: _coinKey),
                            const SizedBox(height: 32),
                            Text(
                              _resultHeads ? 'HEADS' : 'TAILS',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFFACC15),
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                const Spacer(),

                // Button area
                if (_phase == TossPhase.selection)
                  FilledButton(
                    onPressed:
                        selectedTeam == null ? null : _handleFlipCoin,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF0A2A62),
                      disabledBackgroundColor: const Color(0xFF233A64),
                      foregroundColor: AppPalette.textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.autorenew, size: 20),
                        SizedBox(width: 10),
                        Text(
                          'FLIP COIN',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.1),
                        ),
                      ],
                    ),
                  )
                else if (_phase == TossPhase.result)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: FilledButton(
                      onPressed: _handleStartMatch,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF0A2A62),
                        foregroundColor: AppPalette.textPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'START MATCH',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.1),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
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

class _TeamChoiceCard extends StatelessWidget {
  const _TeamChoiceCard({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.badgeLabel,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final String badgeLabel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 18, 12, 20),
        decoration: BoxDecoration(
          color: const Color(0xAA0B1D3A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: selected ? AppPalette.accent : const Color(0xFF1F3352),
              width: selected ? 2 : 1),
        ),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF0B2C66), Color(0xFF243A5C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Container(
                  width: 64,
                  height: 64,
                  color: const Color(0xFF0E2B54),
                  alignment: Alignment.center,
                  child: Text(
                    badgeLabel,
                    style: const TextStyle(
                        color: Color(0xFFFACC15),
                        fontSize: 36,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              label,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppPalette.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
