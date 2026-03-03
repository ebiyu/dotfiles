---
name: jj-desc
description: Set desctiption for jj
disable-model-invocation: true
allowed-tools: Bash(jj diff:*), Bash(jj log:*), Bash(jj desc -m:*)
---

必ず以下に指定している通りのコマンドを使用してください。

1. `jj diff` で差分を確認。
2. `jj log -r ..` でコミット履歴を確認し、過去のdescriptionを参考にdescriptionを設定してください。
3. `jj desc -m <description>` でdescriptionを設定。
