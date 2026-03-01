# Development Setup

## Prerequisites
- Flutter SDK
- Android Studio or Android SDK tools
- VS Code with Flutter and Dart extensions

## Local Setup
1. Clone repository
2. Enter app directory: `cd app`
3. Run `flutter pub get`
4. Configure environment variables (Supabase URL/key)
5. Run `flutter run`

## Supabase
Create your own Supabase project for local development and set:
- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`

Never commit production credentials.

## Useful Commands
- `flutter doctor`
- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `flutter run`

## Figma MCP + Codex Workflow
1. Install and connect the Figma MCP server in your coding agent environment.
2. Open your Figma file and right-click a frame.
3. Select `Copy link to selection`.
4. Prompt the coding agent with the frame link and implementation goal.

Example prompt:
`help me implement this Figma design in Flutter. Use existing CricStatz components and Provider architecture where possible.`

Expected agent behavior:
- Pull design context from Figma (layout, typography, spacing, components)
- Generate Flutter code under `app/lib/screens` and `app/lib/widgets`
- Reuse shared styles in `app/lib/config/theme.dart`
- Keep design exports synchronized in `design/screens` and `design/assets`
