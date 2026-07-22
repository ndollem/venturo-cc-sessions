# Troubleshooting w02 — Arsenal Skills #1

> Cari gejala persis (Ctrl+F pesan errornya). Tiap entri rujuk kartu §N di `panduan-peserta.md`.
> Prinsip sesi: nyangkut >3' di satu kartu → ⚡ escape hatch kartu itu, lanjut, kejar di sini pasca-sesi.

---

## Prasyarat & lingkungan

### `claude --version` tidak sama dengan 2.1.206
**Gejala**: versi lain muncul (lebih baru/lama).
**Penyebab**: auto-update CLI jalan sendiri, atau install manual sebelum pin dikunci.
**Fix**: tidak WAJIB downgrade untuk ikut sesi — cuma perilaku kartu bisa sedikit beda dari `Expected result`. Kalau versi jauh lebih lama (< 2.1.x): `npm install -g @anthropic-ai/claude-code@2.1.206` (atau installer resmi versi itu). Lapor #stuck bila ada yang mentok gara-gara gap versi, bukan blocker individual.

### `npx skills find "..."` timeout / stuck lama
**Gejala**: terminal diam >15 detik, tidak ada output, atau `ETIMEDOUT`/`network error`.
**Penyebab**: proxy kantor/wifi venue nge-block registry npm, atau `npx` pertama kali unduh package (`skills` CLI belum ter-cache).
**Fix**: `npm config get proxy` cek proxy aktif; kalau venue punya proxy resmi set `npm config set proxy http://...`. Kalau tidak ada waktu → §1 **⚡ escape hatch**: lihat screenshot expected result di slide, lanjut ke §2. Kejar `npx skills find "pdf"` nanti di rumah.

### `/plugin marketplace add <repo>` gagal
**Gejala**: `Error: could not reach marketplace` / `404` / `authentication required`.
**Penyebab**: (a) jaringan venue block GitHub raw content, (b) repo marketplace private/butuh auth GitHub yang belum login, (c) typo nama repo (`owner/repo` persis, case-sensitive).
**Fix**:
1. Cek `gh auth status` (atau `git config --get user.name` minimal git ter-config) — kalau belum login GitHub: `gh auth login`.
2. Cek ejaan repo persis dari `panduan-peserta.md`/`versions.md` — jangan ketik dari ingatan.
3. Tetap gagal → skip install kartu itu, screenshot expected di slide (per kartu), lanjut. Install ulang pasca-sesi dari jaringan lain.

### Install `caveman` / `ponytail` / `ui-ux-pro-max` gagal
**Gejala**: `/plugin install <nama>@<marketplace>` error (`plugin not found`, `marketplace not added`, timeout).
**Penyebab**: langkah `marketplace add` di §6/§7/§8 belum sukses (lihat entri di atas), atau urutan kebalik (install sebelum marketplace ke-add).
**Fix**: pastikan urutan 2 command persis (marketplace add → install), copy-paste dari `panduan-peserta.md`, jangan ketik manual. Cek versi ter-pasang cocok `_shared/versions.md` (caveman v1.9.1, ponytail v4.8.4, ui-ux-pro-max 2.6.2) — beda jauh berarti install lama nyangkut, jalankan `/plugin uninstall <nama>` lalu install ulang. Gagal terus → catat, lanjut kartu berikut (§6/§7/§8 kartu independen, tak saling blok).

---

## §2 — brainstorming skip gate (Claude langsung koding)

**Gejala**: setelah prompt `/superpowers:brainstorming ...`, Claude langsung menulis/mengedit file kode — tidak bertanya dulu.
**Penyebab**: skill terpicu tapi model "terburu-buru" karena prompt awal terlalu mirip instruksi implementasi langsung (mis. menyebut nama fungsi/file spesifik), atau skill belum ke-load (superpowers belum ter-install — cek `/plugin list`).
**Fix** — prompt korektif, ketik persis:
```
stop — jangan implement dulu, ajukan pertanyaan satu per satu sampai aku approve
```
Masih ngawur setelah itu → kemungkinan `superpowers` belum aktif. Cek `/plugin list` ada `superpowers@claude-plugins-official`; kalau tidak ada, install ulang (§2 langkah 3), lalu ulang prompt. Tetap gagal → §2 **⚡ escape hatch**: skip ke §3, plan bisa jalan dari spec seadanya.

## §3 — `executing-plans` macet / error di tengah task

**Gejala**: eksekusi berhenti dengan error compile/test, atau Claude bingung di satu task dan looping saran yang sama.
**Penyebab**: task plan terlalu besar untuk satu checkpoint, atau lingkungan Go belum lengkap (toolchain hilang) — ini WAJAR bila laptop tak punya Go (lihat catatan panduan-peserta §3: yang dinilai artefak plan+kode, bukan `go test` hijau).
**Fix — reset ke titik aman**:
```bash
git checkout s1w2-start -- .
```
Ini mengembalikan working tree ke skeleton awal tanpa menghapus riwayat commit. Plan file di `docs/superpowers/plans/…md` tetap ada (tidak ke-reset, itu file baru yang Claude tulis) — bisa dipakai ulang. Lanjut ke §4 dengan diff seadanya, atau kejar eksekusi pasca-sesi.

## §6 — `/caveman-stats` kosong / tidak ada angka

**Gejala**: `/caveman-stats` keluar tapi field "tokens saved" kosong, 0%, atau perintah tidak dikenali.
**Penyebab**: baru 1 giliran respons sejak caveman aktif — statistik butuh minimal 1 task selesai untuk dihitung; atau plugin belum benar-benar aktif (install sukses tapi belum di-reload sesi).
**Fix**: jalankan 1 task singkat lagi (mis. "jelaskan 1 file di internal/") lalu ulangi `/caveman-stats`. Command tidak dikenali sama sekali → cek `/plugin list` ada `caveman@caveman`; kalau tak ada, install gagal diam-diam — ulangi §6 langkah 3.

---

## grademe — status code & masalah env

### `401` saat `/grademe <nama>`
**Gejala**: skor tampil di layar tapi baris upload bilang `401` / "unauthorized" / token ditolak.
**Penyebab**: `VIBESCORE_API_KEY` kosong, salah, atau kadaluarsa (token di-rotate di halaman `/token` tapi env lama masih dipakai shell).
**Fix**:
```bash
echo $VIBESCORE_API_URL
echo $VIBESCORE_API_KEY
```
Kalau salah satu kosong/kelihatan aneh:
1. Buka halaman `/token`, ambil token terbaru (kalau ragu, klik rotate → token lama otomatis mati).
2. Cek export ada **permanen** di `~/.zshrc` (bukan cuma `export` di terminal sesi ini — hilang saat shell baru/reboot):
   ```bash
   grep VIBESCORE ~/.zshrc
   ```
3. Kalau tak ada baris itu, tambahkan:
   ```bash
   echo 'export VIBESCORE_API_URL="https://..."' >> ~/.zshrc
   echo 'export VIBESCORE_API_KEY="..."' >> ~/.zshrc
   source ~/.zshrc
   ```
4. Buka `claude` (atau tab terminal) yang baru — env lama di sesi `claude` yang sudah jalan tidak otomatis ke-refresh, harus sesi baru.
Skor tetap tak terkirim → itu **bukan blocker sesi**: screenshot skor, lapor #stuck, asisten beresin pasca-sesi.

### `409` saat `/grademe <nama>`
**Gejala**: respons `409 Conflict` (bukan error merah — informasi).
**Penyebab**: sesi kerja ini (`session_id`) sudah pernah di-upload sebelumnya — server dedup, skor tidak digandakan.
**Fix**: tidak ada fix — ini perilaku BENAR (proteksi duplikat). Kalau sengaja mau lihat ulang, jalankan `/grademe` di sesi `claude` baru (session_id baru → upload baru).

### Timeout saat upload `/grademe`
**Gejala**: perintah menggantung lama, tak ada respons status code.
**Penyebab**: jaringan venue lambat/putus ke `VIBESCORE_API_URL`, atau backend sedang cold-start.
**Fix**: tunggu ~10 detik lagi (biasanya retry otomatis). Masih gantung → Ctrl+C, skor tetap ada di output JSON lokal — screenshot, lapor #stuck. Ini bukan kesalahan peserta.

### Env hilang setelah reboot / buka terminal baru
**Gejala**: `echo $VIBESCORE_API_URL` kosong padahal kemarin sudah di-export dan berhasil.
**Penyebab (temuan sesi 21b)**: `export VAR=...` yang diketik langsung di terminal hanya hidup selama sesi shell itu — hilang total setelah terminal ditutup/laptop reboot. Harus ditulis ke file init shell (`~/.zshrc`) supaya permanen.
**Fix**: sama seperti langkah 401 di atas — tambahkan 2 baris `export` ke `~/.zshrc`, lalu `source ~/.zshrc` (atau buka tab terminal baru).

### `/plugin` tidak tersedia / command tak dikenal di editor
**Gejala**: mengetik `/plugin marketplace add ...` di dalam Claude Code yang jalan sebagai **VS Code extension** — command tidak jalan atau tak ada efek.
**Penyebab (temuan sesi 21b)**: `/plugin` slash command tidak tersedia di Claude Code dalam bentuk VS Code extension.
**Fix**: jalankan dari **shell biasa** (Terminal.app / iTerm, bukan panel extension), pakai bentuk CLI:
```bash
claude plugin marketplace add <owner>/<repo>
claude plugin install <nama>@<marketplace>
```
Atau buka sesi `claude` dari terminal biasa (bukan dari dalam VS Code) untuk pakai `/plugin` seperti biasa.

---

## Eskalasi
Semua fix di atas gagal → jangan habiskan >3 menit per orang. Catat nama + gejala di kanal **#stuck**, lanjut ke kartu berikutnya. Asisten roaming/fasilitator follow-up pasca-sesi; tidak memblok `/grademe` penutup (skor tetap valid meski 1-2 kartu terlewat).
