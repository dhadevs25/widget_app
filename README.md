widget_app
This repository is used to practice and explore Flutter UI development.

# Commit Message Convention


Commits must follow: `<type>(optional scope): <short summary>`
Example: `feat(login): add button`

Allowed types:
- feat: new feature
- fix: bug fix
- docs: documentation
- style: formatting/style only
- refactor: code refactor
- test: add or update tests
- chore: maintenance tasks

Commits not matching this format will be rejected.
See: https://www.conventionalcommits.org/en/v1.0.0/

## Commit Hook
A git commit-msg hook is installed in `.git/hooks/commit-msg` to enforce this rule. If your commit message does not match the required format, the commit will be rejected with an error message.