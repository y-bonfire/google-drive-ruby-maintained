## 🧠 AI-assisted Maintenance

To help ensure sustainability, I actively use AI tools (such as GitHub Copilot or ChatGPT) to review code, analyze issues, and streamline maintenance tasks.

This allows for more efficient handling of updates, tests, and documentation, especially when time or contributors are limited.


## 🧪 Development flow

This repository uses a simple `develop` → `main` workflow, even for solo maintenance.

- All development is done on the `develop` branch.
- Pull requests are created to merge changes into `main`.
- GitHub Actions CI is triggered for each pull request.
- This helps ensure traceability and safer updates, even when working solo.


## Manual unit tests Overview
Tests can be run in the terminal at hand with various authentication methods. As I will explain later, CI with GithubAction is limited to using a service account.

`bundle exec rake test`


## 🧪 CI / GitHub Actions Overview

This project uses [GitHub Actions](https://docs.github.com/en/actions) to run tests automatically.

- Workflow file: `.github/workflows/test.yml`
- Runs on: `ubuntu-latest`
- Ruby versions tested: 3.3
- Trigger: Push to `main`, PR creation
- Test command: `bundle exec rake test_ci`

CI testing is done using a service account method. I tried other authentication methods, but the test with GithubAction did not work because browser authentication from the execution terminal was required. Therefore, it is necessary to prepare a spreadsheet in advance and share it with the service account. Also, it is better to create a Google Account for development and perform the test with that to reduce risk.

### GithubAction Environment Variables
https://docs.github.com/ja/actions/reference/workflows-and-actions/contexts#secrets-context

GOOGLE_CREDENTIALS_BASE64 create command
```
base64 -w 0 service_account.json > encoded.txt
```

- `GOOGLE_CREDENTIALS_BASE64` – Provided via GitHub Secrets
- `GOOGLE_DRIVE_TEST_SPREADSHEET_ID` – Provided via GitHub Secrets


### Note
⚠️It is necessary to be careful not to leak credentials, and to avoid accidentally committing

Secrets are not exposed to PRs from forked repositories for security reasons.


The security issue is explained in detail here
[Security](SECURITY.md)
