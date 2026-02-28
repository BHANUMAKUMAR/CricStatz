# Database Schema (Supabase Draft)

This is an initial schema draft and can evolve.

## teams
- `id` (uuid, pk)
- `name` (text)
- `short_code` (text)
- `created_at` (timestamp)

## players
- `id` (uuid, pk)
- `team_id` (uuid, fk -> teams.id)
- `name` (text)
- `role` (text) - batter, bowler, all-rounder, wicketkeeper
- `created_at` (timestamp)

## matches
- `id` (uuid, pk)
- `team_a_id` (uuid, fk -> teams.id)
- `team_b_id` (uuid, fk -> teams.id)
- `overs_limit` (int)
- `toss_winner_team_id` (uuid)
- `toss_decision` (text) - bat or bowl
- `status` (text) - scheduled, live, completed
- `created_at` (timestamp)

## innings
- `id` (uuid, pk)
- `match_id` (uuid, fk -> matches.id)
- `batting_team_id` (uuid, fk -> teams.id)
- `bowling_team_id` (uuid, fk -> teams.id)
- `innings_number` (int)
- `runs` (int)
- `wickets` (int)
- `overs` (numeric)

## ball_events
- `id` (uuid, pk)
- `match_id` (uuid, fk -> matches.id)
- `innings_id` (uuid, fk -> innings.id)
- `over_number` (int)
- `ball_number` (int)
- `striker_id` (uuid, fk -> players.id)
- `non_striker_id` (uuid, fk -> players.id)
- `bowler_id` (uuid, fk -> players.id)
- `runs_batter` (int)
- `runs_extras` (int)
- `extra_type` (text) - wide, no_ball, bye, leg_bye
- `is_wicket` (bool)
- `wicket_type` (text)
- `created_at` (timestamp)

## Notes
- Add row-level security policies once auth is finalized.
- Keep match updates transactional to avoid scoring inconsistencies.
