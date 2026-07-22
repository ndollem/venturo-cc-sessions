#!/usr/bin/env bash
# setup-check.sh — cek prasyarat peserta w02 (jalankan H-1 / pagi sesi).
# Pakai: bash setup-check.sh [path-repo-vibescore-api] [--checkout]
#   path-repo default: ./vibescore-api
#   --checkout: DESTRUKTIF — git checkout s1w2-start + git clean -fdx di repo itu.
# Exit 0 = semua PASS. Exit 1 = ada FAIL (WARN tidak menggagalkan exit code).
set -u

REPO="${1:-./vibescore-api}"
DO_CHECKOUT="${2:-}"
FAIL=0
PIN_VERSION="2.1.206"
EXPECT_TAG="s1w2-start"

pass() { echo "  [PASS] $1"; }
warn() { echo "  [WARN] $1"; }
fail() { echo "  [FAIL] $1"; FAIL=1; }

echo "=== setup-check.sh — w02 prasyarat ==="
echo

# 1. claude --version
echo "1) Claude Code version"
if command -v claude >/dev/null 2>&1; then
  VER_LINE="$(claude --version 2>/dev/null || true)"
  if [ -z "$VER_LINE" ]; then
    fail "claude --version tidak menghasilkan output"
  elif echo "$VER_LINE" | grep -q "$PIN_VERSION"; then
    pass "claude --version = $VER_LINE"
  else
    warn "claude --version = $VER_LINE (pin sesi: $PIN_VERSION) — bukan blocker keras, tapi expected result kartu bisa sedikit beda"
  fi
else
  fail "command 'claude' tidak ditemukan di PATH"
fi
echo

# 2. node + npx (untuk kartu §1 npx skills)
echo "2) node & npx"
if command -v node >/dev/null 2>&1; then
  pass "node ada: $(node --version)"
else
  fail "node tidak ditemukan (dibutuhkan untuk kartu §1 'npx skills')"
fi
if command -v npx >/dev/null 2>&1; then
  pass "npx ada: $(npx --version 2>/dev/null || echo '?')"
else
  fail "npx tidak ditemukan (dibutuhkan untuk kartu §1 'npx skills')"
fi
echo

# 3. env grademe
echo "3) Env grademe (VIBESCORE_API_URL / VIBESCORE_API_KEY)"
if [ -n "${VIBESCORE_API_URL:-}" ]; then
  pass "VIBESCORE_API_URL terisi"
else
  fail "VIBESCORE_API_URL kosong — /grademe tidak akan auto-upload. Cek export permanen di ~/.zshrc, lalu 'source ~/.zshrc'"
fi
if [ -n "${VIBESCORE_API_KEY:-}" ]; then
  pass "VIBESCORE_API_KEY terisi"
else
  fail "VIBESCORE_API_KEY kosong — ambil token dari halaman /token, export permanen di ~/.zshrc"
fi
echo

# 4. repo latihan
echo "4) Repo latihan: $REPO"
if [ ! -d "$REPO" ]; then
  fail "folder '$REPO' tidak ditemukan"
elif [ ! -d "$REPO/.git" ]; then
  fail "'$REPO' bukan git repo (.git tidak ada)"
else
  pass "'$REPO' adalah git repo"

  TAG_FOUND="$(git -C "$REPO" tag -l "$EXPECT_TAG" 2>/dev/null || true)"
  if [ -n "$TAG_FOUND" ]; then
    pass "tag '$EXPECT_TAG' ada"
  else
    fail "tag '$EXPECT_TAG' tidak ditemukan — repo mungkin belum sinkron / clone lama. Coba 'git -C $REPO fetch --tags'"
  fi

  if git -C "$REPO" diff --quiet 2>/dev/null && git -C "$REPO" diff --cached --quiet 2>/dev/null; then
    pass "working tree bersih"
  else
    warn "working tree kotor — saran: 'git -C $REPO stash' sebelum sesi (atau pakai --checkout di bawah)"
  fi

  if [ "$DO_CHECKOUT" = "--checkout" ]; then
    echo
    echo "  >>> --checkout diminta: MENGHAPUS perubahan lokal & file untracked di '$REPO' <<<"
    if git -C "$REPO" checkout "$EXPECT_TAG" 2>&1 | sed 's/^/  /'; then
      git -C "$REPO" clean -fdx 2>&1 | sed 's/^/  /'
      pass "checkout ke '$EXPECT_TAG' + clean selesai"
    else
      fail "checkout ke '$EXPECT_TAG' gagal"
    fi
  fi
fi
echo

echo "=== Ringkasan ==="
if [ "$FAIL" -eq 0 ]; then
  echo "Semua item wajib PASS. Siap sesi w02."
else
  echo "Ada item FAIL di atas — perbaiki sebelum sesi (lihat troubleshooting.md)."
fi
exit "$FAIL"
