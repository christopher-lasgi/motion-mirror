#!/usr/bin/env bash
# Checks that keep the skill valid and brand-neutral. Run before opening a pull request.
set -euo pipefail
cd "$(dirname "$0")/.."
SKILL=skills/motion-mirror/SKILL.md
fail=0

# 1. The skill follows the Agent Skills specification.
head -1 "$SKILL" | grep -qx -- '---' || { echo "$SKILL: missing front matter"; fail=1; }
grep -q '^name: motion-mirror$' "$SKILL" || { echo "$SKILL: name must be motion-mirror"; fail=1; }
desc=$(sed -n 's/^description: //p' "$SKILL" | head -1)
[ -n "$desc" ] || { echo "$SKILL: missing description"; fail=1; }
[ "${#desc}" -le 1024 ] || { echo "$SKILL: description is ${#desc} characters, the limit is 1024"; fail=1; }
[ "$(wc -l < "$SKILL")" -le 500 ] || { echo "$SKILL: more than 500 lines"; fail=1; }

# 2. Every reference linked from SKILL.md exists.
for ref in $(grep -o '](references/[^)#]*' "$SKILL" | sed 's/^](//' | sort -u); do
  [ -f "skills/motion-mirror/$ref" ] || { echo "$SKILL: broken link $ref"; fail=1; }
done

# 3. The evals are valid JSON.
python3 -c "import json;json.load(open('evals/evals.json'))" || { echo "evals/evals.json: invalid JSON"; fail=1; }

# 4. Neutrality. The reference's name, private links, session links and local paths appear nowhere.
if grep -rniE 'coolify|claude\.ai/code|session_[0-9a-z]{8}|/root/|/home/' \
  --include='*.md' --include='*.yml' --include='*.json' --include='*.sh' --exclude=check.sh --exclude-dir=.git . ; then
  echo "Neutrality check failed: remove the lines above"; fail=1
fi
# The skill, the rules and the templates carry no brand at all; only the READMEs may present a showcase.
if grep -rniE 'orbit|boostecom|easyconnector' \
  --include='*.md' --include='*.yml' --include='*.json' --exclude='README*.md' --exclude-dir=.git . ; then
  echo "Brand names are allowed only in README files: remove the lines above"; fail=1
fi

[ "$fail" -eq 0 ] && echo "All checks passed"
exit "$fail"
