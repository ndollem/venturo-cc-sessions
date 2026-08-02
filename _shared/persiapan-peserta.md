# Persiapan Peserta — Sebelum Sesi

> **Season 2 (w05–w08) dimulai — baca §S2 di bawah lebih dulu.**
> Bagian §1–§3 di halaman ini adalah persiapan **Season 1 (w01–w04)**; tetap disimpan sebagai
> rujukan bagi yang menyusul materi lama, **tapi bukan prasyarat Season 2.**

## §S2 — Persiapan Season 2 (mulai w05 "Arsenal MCP")

**Tidak ada prasyarat H-7 untuk w05.** Setup dikerjakan **saat sesi berlangsung**, paralel dengan
segmen pembuka (§0 dijatah 15 menit — cukup untuk clone + install). Yang perlu kamu pastikan
sebelum datang cuma tiga hal:

| Yang dicek | Perintah | Kenapa |
|---|---|---|
| Claude Code versi seragam | `claude --version` | pin ada di `versions.md` |
| Node + npm | `node --version && npm --version` | repo latihan w05 = Vite + React |
| **Disk kosong ≥ 10 GB** | `df -h /` | `npx` playwright + chrome-devtools + image Docker dipasang saat sesi; di satu dry-run disk penuh menghentikan seluruh kelas |

**Repo latihan w05** (di-clone saat sesi, bukan sebelumnya):
```bash
git clone https://github.com/ndollem/venturo-benefit-survey.git
```

**Satu-satunya yang enak disiapkan lebih dulu — GitHub PAT.** Membuat token barengan 30 orang itu
lambat dan memakan jatah praktek:
github.com → Settings → Developer settings → **Personal access tokens (classic)** → Generate new
token → centang **`public_repo`** + **`read:org`** → copy. Semua repo yang dipakai hari itu publik,
jadi `public_repo` sudah cukup; pilih `repo` penuh **hanya** kalau kamu berniat memakainya untuk
repo kerjamu — sadari itu memberi akses baca-tulis ke seluruh repo privatmu. **Masa berlaku 30 hari,
cabut setelah dipakai.**

> **Yang TIDAK perlu kamu siapkan untuk w05:** akun Supabase, service account Google Cloud, API key
> Context7, Docker. Ketiga segmen yang memakainya (§4 Sheets→Postgres, §5 Context7+Docker, §6
> security) dijalankan **presenter di layar depan** — kamu menonton dan ikut diskusi. Segmen yang
> kamu ketik sendiri (§1–§3.5, §7) cuma butuh GitHub PAT + repo latihan di atas.

---

## Season 1 (w01–w04) — arsip persiapan

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
> peserta `cp` ke `.claude/` sebagai bagian prasyarat H-7 (idempotent — diulang saat sesi tak masalah).

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

## 4. Prasyarat sesi lanjutan (w06–w07)
> ⚠️ **Draft** — minggu ini belum dibangun; detail berikut mengikuti `curriculum-v4-plan.md` dan bisa
> berubah saat sesi benar-benar dibuild (patuhi pengumuman H-7 resmi tiap minggu di atas draft ini).
>
> **w05 sudah dibangun — prasyaratnya ada di §S2 di atas, bukan di sini.** Rencana lama
> ("akun Supabase + `project_ref` per peserta, WAJIB H-7") **dibatalkan**: segmen Supabase kini
> presenter-led, jadi peserta tak perlu menyiapkan apa pun selain GitHub PAT.

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
