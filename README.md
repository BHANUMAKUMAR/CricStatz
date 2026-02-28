# CricStatz

CricStatz is an open-source Flutter app to record and track cricket matches played in grounds, local leagues, and practice sessions.

The goal is simple: make scorekeeping fun, reliable, and shareable so everyone can see match and player stats.

## Vision
- Create teams and players
- Configure matches (10 over, 20 over, custom)
- Track live scoring ball by ball
- Show player and team stats over time

## Tech Direction
- Flutter (mobile app)
- Provider (state management)
- Supabase (backend + database)

## Repository Structure
```
CricStatz/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   ├── design_proposal.md
│   │   └── feature_request.md
│   └── PULL_REQUEST_TEMPLATE.md
├── design/
│   ├── assets/
│   ├── screens/
│   ├── README.md
│   └── color-palette.md
├── docs/
│   ├── ARCHITECTURE.md
│   ├── DATABASE_SCHEMA.md
│   └── SETUP.md
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── LICENSE
├── SECURITY.md
└── README.md
```

## Figma and Design Workflow
- Primary design source: Figma
- Store approved exports in `design/screens/` and `design/assets/`
- Open a Design Proposal issue before large UI changes

Add your Figma links in `design/README.md`.
## Figma
- Main file link: `https://www.figma.com/design/BeeHZXJXOwpc3qIHxFiQUJ/CRICSTATZ?node-id=139-4519&m=dev&t=3gxyNna0RgE3Pdtq-1`
- Prototype link: `https://www.figma.com/proto/BeeHZXJXOwpc3qIHxFiQUJ/CRICSTATZ?node-id=139-4519&t=3gxyNna0RgE3Pdtq-1`

## Quick Start
1. Install Flutter: `https://docs.flutter.dev/get-started/install`
2. Clone repository:
```bash
git clone https://github.com/<your-username>/CricStatz.git
cd CricStatz
```
3. Verify Flutter setup:
```bash
flutter doctor
```

Flutter app scaffolding will be added in the next implementation step.

## Contribution Rules
- Read `CONTRIBUTING.md` before opening a PR
- Use issue templates for bug, feature, and design proposals
- Keep PRs focused and reviewable
- Never commit secrets or production keys

## Community Standards
- Code of conduct: `CODE_OF_CONDUCT.md`
- Security reporting: `SECURITY.md`

## License
This project is licensed under GNU GPL v3. See `LICENSE`.

