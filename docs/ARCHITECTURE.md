# Architecture Overview

## Goal
CricStatz helps players record match events ball-by-ball and view team/player stats over time.

## High-Level Stack
- Flutter app (Android first)
- Provider for state management
- Supabase for backend (auth + Postgres + realtime)
- Optional local cache for offline resilience

## Core Domains
- Teams
- Players
- Matches
- Innings
- Ball events
- Aggregated statistics

## Data Flow (Target)
1. User action in UI
2. Provider updates local app state
3. Service writes/reads from Supabase
4. UI reacts to state updates

## Key App Flows
- Team creation
- Match setup (overs, teams, toss, innings order)
- Live scoring (runs, wickets, extras, over progression)
- Post-match summaries and leaderboards
