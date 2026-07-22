# Persiapan Peserta — Sebelum Sesi

> Siapkan ini **sebelum minggu 1**. ±10 menit. Ini yang bikin kamu bisa **ikut mengetik**
> tiap langkah demo di mesinmu sendiri, bukan cuma menonton.

## Yang kamu butuh
- **Claude Code** terpasang (`claude --version`).
- **git** + akun GitHub.
- Editor (Cursor / VS Code).

## 1. Clone repo latihan w02 (PUBLIC)
Project yang kita bangun bareng — leaderboard skor `vibescore`. **Repo ini dipakai w02** (katalog
skill); w03 dan seterusnya pindah ke repo baru, lihat §1a di bawah:
```bash
mkdir ~/venturo && cd ~/venturo
git clone https://github.com/ndollem/vibescore-api.git
git clone https://github.com/ndollem/vibescore-web.git      # baru dipakai mulai minggu 3
```

## 1a. Clone repo latihan w03+ (survey-app, PUBLIC)
Mulai minggu 3, sesi QA & Testing dst. pakai repo baru `survey-app` (Next.js + TypeScript) —
**bukan** `vibescore-api`. `vibescore-api`/`-web` di §1 tetap dipakai w02, tidak dihapus:
```bash
cd ~/venturo
git clone https://github.com/ndollem/survey-app.git
cd survey-app
git checkout s1w3-start
npm install      # Node 20+ (disarankan Node 24, sama seperti pin versions.md)
```
**Prasyarat H-7 khusus w03:**
- `npx vitest --version` & `npx oxlint --version` jalan tanpa error (dari dalam `survey-app`).
- Skill `webapp-testing` terpasang (📦 belum diuji mesin bersih — lihat `versions.md`) + `python3` +
  `python3 -m playwright install chromium`.
- Env grademe (`VIBESCORE_API_URL` / `VIBESCORE_API_KEY`) — sudah ada dari w02, **reuse**, tak perlu
  setup ulang.

> Subagent `test-writer`/`code-reviewer` + quality-gate hook SUDAH DIBUNDEL di `survey-app/assets/` —
> peserta `cp` ke `.claude/` saat sesi jalan, **bukan** bagian prasyarat H-7.

## 2. Mulai dari titik awal minggu
Tiap minggu punya tag mulai `-start` dan kunci jawaban `-end`:

| Minggu | Titik mulai | Kunci jawaban |
|---|---|---|
| Mg 1 | `s1w1-start` | `s1w1-end` |
| Mg 2 | `s1w2-start` | `s1w2-end` |
| Mg 3 | `s1w3-start` | `s1w3-end` |
| Mg 5 | `s2w5-start` | `s2w5-end` |
| Mg 6 | `s2w6-start` | `s2w6-end` |
| Mg 7 | `s2w7-start` | `s2w7-end` |

> **Catatan repo per minggu:** tag `s1w1`/`s1w2` = repo `vibescore-api` (§1). Tag `s1w3` = repo baru
> `survey-app` (§1a) — **bukan** `vibescore-api`. Mg 5–7 menyusul, ikuti pengumuman prasyarat H-7
> tiap sesi.

```bash
cd vibescore-api && git checkout s1w1-start      # contoh: siap minggu 1
```
Tersesat saat mengikuti demo? `git checkout <tag>-end -- <file>` untuk melihat versi jadi,
lalu lanjut — **jangan debug lama; tag adalah jaring pengaman.**

> **Verifikasi otomatis:** tiap minggu menyediakan `setup-check.sh` (mis. `w02/assets/setup-check.sh`,
> dibagikan bareng materi minggu itu) — jalankan H-1/pagi sesi untuk cek versi tool, tag repo, & env
> grademe sekaligus (PASS/FAIL per item), sebelum menelusuri manual satu-satu.

## 3. Pasang `/grademe` + ambil token (WAJIB sebelum w02)
Skoring 7-dimensi vibe coding kita, otomatis terupload ke leaderboard tiap `/grademe`. Di dalam `claude`:
```
/plugin marketplace add venturo-id/venturo-claude
/plugin install grademe@venturo-tools
```
**Ambil token pribadi** (dipakai upload otomatis, bukan cuma tampil di layar): buka halaman `/token`,
salin token, lalu **export permanen** di `~/.zshrc` (bukan cuma `export` di terminal sesi ini — hilang
saat shell baru):
```bash
echo 'export VIBESCORE_API_URL="https://..."' >> ~/.zshrc
echo 'export VIBESCORE_API_KEY="<token-kamu>"' >> ~/.zshrc
source ~/.zshrc
```
Cek dua-duanya terisi sebelum sesi:
```bash
echo $VIBESCORE_API_URL
echo $VIBESCORE_API_KEY
```
Uji: buka `claude` di `vibescore-api`, ketik `/grademe nama-kamu` setelah sesi kerja — keluar
JSON skor + baris upload `201 Created`. Bawa skormu tiap minggu (Challenge Besok Pagi). Token
kadaluarsa/salah → `401` saat upload, lihat `troubleshooting.md` minggu berjalan.

## 4. Prasyarat sesi lanjutan (w05–w07)
> ⚠️ **Draft** — minggu ini belum dibangun; detail berikut mengikuti `curriculum-v4-plan.md` dan bisa
> berubah saat sesi benar-benar dibuild (patuhi pengumuman H-7 resmi tiap minggu di atas draft ini).

- **w05 (Arsenal MCP) — WAJIB H-7:** akun Supabase + 1 project pribadi dibuat + catat `project_ref`-nya
  (dari URL dashboard project). Dipakai `claude mcp add --transport http ... project_ref=<ref-mu>`,
  jadi harus sudah ada **sebelum** sesi — tak bisa dibuat on-the-spot.
- **w06 (Token Economy, Memory & 2nd Brain):** `uv` terpasang (`uv --version`; dipakai
  `uv tool install graphifyy`). Obsidian (app) terpasang + 1 vault kosong siap dipakai (folder
  `decisions/` & `knowledge/` disiapkan saat sesi).
- **w07 (Loop Engineering & Arsenal):** feature flag *agent teams* aktif di Claude Code (cek/aktifkan
  sebelum sesi, butuh restart). Vercel **opsional** — kalau mau ikut bonus deploy pribadi, siapkan akun
  Vercel + `vercel` CLI login duluan.

## Peta materi
Deck slide tiap minggu + silabus lengkap: **[buka landing materi](../index.html)**.

---
*Repo `vibescore-*` read-only untuk peserta — kamu clone & kerja di salinanmu sendiri. Mulai
Mg 5 demo memakai database; kamu ikut alur command-nya, data live pemateri tak dibagikan.*
