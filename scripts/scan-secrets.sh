#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
# Secret Scanner — pre-commit hook
# Prevents committing hardcoded credentials, API keys, tokens
# ═══════════════════════════════════════════════════════════
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

PATTERNS=(
  # API key patterns
  'sk-[a-zA-Z0-9]{20,}'
  'gsk_[a-zA-Z0-9]{20,}'
  'xai-[a-zA-Z0-9]{20,}'
  'ghp_[a-zA-Z0-9]{36}'
  'github_pat_[a-zA-Z0-9_]{22,}'
  'AKIA[0-9A-Z]{16}'
  # Hardcoded passwords
  'password\s*=\s*['\''"][^'\''"]{4,}['\''"]'
  'secret\s*=\s*['\''"][^'\''"]{4,}['\''"]'
  # Private keys
  'BEGIN (RSA |EC |DSA |OPENSSH )?PRIVATE KEY'
  # MongoDB connection with credentials
  'mongodb(\+srv)?://[^:]+:[^@]+@'
)

EXCLUDE_FILES="\.env\.example|\.test\.|\.spec\.|\.md$|scan-secrets\.sh|node_modules"

FOUND=0

for pattern in "${PATTERNS[@]}"; do
  MATCHES=$(git diff --cached --name-only -z | \
    xargs -0 grep -rlinE "$pattern" 2>/dev/null | \
    grep -vE "$EXCLUDE_FILES" || true)

  if [ -n "$MATCHES" ]; then
    echo -e "${RED}⚠ Potential secret found matching: ${pattern}${NC}"
    echo "$MATCHES" | while IFS= read -r file; do
      echo "   → $file"
    done
    FOUND=1
  fi
done

# Check for .env files being staged
ENV_FILES=$(git diff --cached --name-only | grep -E '^\.env\.' | grep -v '\.example$' || true)
if [ -n "$ENV_FILES" ]; then
  echo -e "${RED}⚠ Environment file staged for commit:${NC}"
  echo "$ENV_FILES" | while IFS= read -r file; do
    echo "   → $file"
  done
  FOUND=1
fi

if [ "$FOUND" -eq 1 ]; then
  echo ""
  echo -e "${RED}✗ Commit blocked: potential secrets detected.${NC}"
  echo "  Remove secrets and use environment variables instead."
  echo "  To override: git commit --no-verify (NOT recommended)"
  exit 1
fi

echo -e "${GREEN}✓ No secrets detected.${NC}"
exit 0
