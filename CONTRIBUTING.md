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


## 🔐 Security Audit

We use [`bundler-audit`](https://github.com/rubysec/bundler-audit) to check for known vulnerabilities in gem dependencies.

### Run manually

```bash
bundle audit check --update
```

This will update the advisory database and report any insecure gems or sources.

### Run regularly
This check should be run:

- Before each release
- After updating any dependencies
- Periodically during maintenance

GitHub Actions runs this check automatically on each push.
