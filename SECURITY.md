## ⚠️ GitHub Actions and Secrets Policy

This project uses GitHub Actions for continuous integration (CI), including workflows that rely on secrets (e.g., OAuth tokens, API credentials).

To protect these secrets, we apply the following policy:

### ⛔ Secrets are not exposed to pull requests from forks

- GitHub automatically blocks secrets from being passed to workflows triggered by `pull_request` events from forked repositories.
- Therefore, if you submit a pull request from a fork, some CI jobs may appear as "Pending" or "Approval required."
- **These jobs will not run until a repository maintainer approves them manually.**

### 🛡 Approval policy

- Maintainers will review the contents of a PR carefully before approving any job that references secrets.
- If a PR includes potentially dangerous behavior (e.g., printing secrets, uploading files), it will be rejected.

### ✅ Contributor checklist

If you're contributing from a fork:

- Do **not** attempt to access secrets in your tests.
- If you see a pending job that references secrets, this is expected—no action is needed on your part.
- Avoid using `pull_request_target` unless absolutely necessary and safe.

### 📚 For maintainers

- Never approve a secrets-referencing workflow for a forked PR without reviewing the code line-by-line.
- Use `if: github.event_name != 'pull_request'` to prevent secrets from being used unintentionally.
- Consider separating secret-dependent jobs into a dedicated workflow triggered only by `push` or `schedule` events.

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
