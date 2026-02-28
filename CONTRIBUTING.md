# Contributing to CricStatz

Thanks for your interest in contributing.

## Who Can Contribute
- Developers: Flutter app features, bug fixes, performance improvements
- Designers: Figma flows, UI proposals, exported assets
- Documentation contributors: setup guides, architecture docs, examples

## Ground Rules
- Keep pull requests focused and small
- Do not commit secrets, API keys, or credentials
- Follow existing folder structure and naming conventions
- Be respectful in discussions and reviews

## Workflow (Fork and PR)
1. Fork the repository
2. Clone your fork
3. Create a branch from `main`
4. Make your changes
5. Test locally
6. Commit with clear messages
7. Push to your fork
8. Open a pull request to this repo's `main`

## Branch Naming
Use one of:
- `feature/<short-name>`
- `fix/<short-name>`
- `docs/<short-name>`
- `design/<short-name>`

## Commit Message Convention
Use prefixes:
- `feat:` new feature
- `fix:` bug fix
- `docs:` documentation update
- `design:` design or asset changes
- `refactor:` code cleanup without behavior change
- `chore:` tooling or housekeeping

Examples:
- `feat: add create team form validation`
- `fix: handle no striker in scoring state`
- `docs: improve local setup steps`

## PR Checklist
- [ ] Changes are limited to the issue scope
- [ ] Code follows project structure
- [ ] UI changes include screenshots or short video
- [ ] Tests added/updated if needed
- [ ] README/docs updated if behavior changed

## Designer Contribution Flow
1. Duplicate the Figma file to your draft
2. Share proposal screenshots in a Design Proposal issue
3. If approved, export assets (SVG/PNG)
4. Add exports under `design/assets/` or `design/screens/`
5. Open PR with before/after references

## Developer Setup
Use the project setup documentation in `README.md` and `docs/SETUP.md`.

## Reporting Bugs
Use the Bug Report template and include:
- Device/OS
- Flutter version
- Steps to reproduce
- Expected vs actual behavior
- Logs/screenshots
