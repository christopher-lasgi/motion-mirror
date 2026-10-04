#!/usr/bin/env bash
# Checks that keep the skill valid and brand-neutral. Run before opening a pull request.
set -euo pipefail
cd "$(dirname "$0")/.."
fail=0

# 1. The skill has its front matter.
head -1 SKILL.md | grep -qx -- '---' || { echo "SKILL.md: missing front matter"; fail=1; }
grep -q '^name: motion-mirror$' SKILL.md || { echo "SKILL.md: name must be motion-mirror"; fail=1; }
grep -q '^description:' SKILL.md || { echo "SKILL.md: missing description"; fail=1; }

# 2. Every reference linked from SKILL.md exists.
for ref in $(grep -o '](references/[^)#]*' SKILL.md | sed 's/^](//' | sort -u); do
  [ -f "$ref" ] || { echo "SKILL.md: broken link $ref"; fail=1; }
done

# 3. Neutrality: no brand, private link, session link or local path.
if grep -rniE 'orbit|boostecom|easyconnector|coolify|claude\.ai/code|session_[0-9a-z]{8}|/root/|/home/' \
  --include='*.md' --include='*.yml' --exclude-dir=.git . ; then
  echo "Neutrality check failed: remove the lines above"; fail=1
fi

[ "$fail" -eq 0 ] && echo "All checks passed"
exit "$fail"
