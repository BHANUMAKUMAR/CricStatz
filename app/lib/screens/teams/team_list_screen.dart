import 'package:cricstatz/config/routes.dart';
import 'package:cricstatz/config/palette.dart';
import 'package:cricstatz/providers/team_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamListScreen extends StatelessWidget {
  const TeamListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TeamProvider teamProvider = context.watch<TeamProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Teams')),
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppPalette.surfaceGradient),
        child: teamProvider.teams.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.groups_2_outlined, size: 48, color: AppPalette.textMuted),
                      const SizedBox(height: 12),
                      Text(
                        'No teams yet',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppPalette.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Create your first team to start match setup.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppPalette.textMuted),
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => Navigator.pushNamed(context, AppRoutes.createTeam),
                        child: const Text('Create Team'),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: teamProvider.teams.length,
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
                itemBuilder: (BuildContext context, int index) {
                  final team = teamProvider.teams[index];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppPalette.cardOverlay,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppPalette.cardStroke),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppPalette.bgSecondary,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Center(
                            child: Text(
                              team.shortCode,
                              style: const TextStyle(
                                color: AppPalette.textPrimary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            team.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppPalette.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: AppPalette.textSubtle),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.createTeam),
        backgroundColor: AppPalette.accent,
        foregroundColor: AppPalette.bgSecondary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
