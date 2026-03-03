---
name: fix-issue
description: Fix a GitHub issue
disable-model-invocation: true
allowed-tools: Bash(gh issue list:*), Bash(gh issue view:*)
---

Fix GitHub issue.
If arguments are not specified, list all issues using `gh issue list` and select the issue you want to fix.

You can read the issue description by `gh issue view <issue_number>`.
Use the information in the issue description to fix the issue.

