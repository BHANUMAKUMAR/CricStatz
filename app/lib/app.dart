import 'package:cricstatz/config/routes.dart';
import 'package:cricstatz/config/theme.dart';
import 'package:cricstatz/providers/match_provider.dart';
import 'package:cricstatz/providers/scoring_provider.dart';
import 'package:cricstatz/providers/team_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CricStatzApp extends StatelessWidget {
  const CricStatzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TeamProvider()),
        ChangeNotifierProvider(create: (_) => MatchProvider()),
        ChangeNotifierProvider(create: (_) => ScoringProvider()),
      ],
      child: MaterialApp(
        title: 'CricStatz',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.home,
        routes: AppRoutes.routeTable,
      ),
    );
  }
}
