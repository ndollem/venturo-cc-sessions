# Bukti w05 — isi setelah rehearsal sukses

Deck menampilkan 5 bukti statis dari rehearsal. Bukti TEKS diisi di blok
`<script id="bukti-data">` di atas `index.html` (cari komentar `ISI SETELAH REHEARSAL`).
Bukti GAMBAR (kalau ada) ditaruh sebagai file `.png` di folder ini.

Slot kosong / gambar hilang otomatis jadi placeholder "Capture dari rehearsal" —
deck tetap aman dipresentasikan tanpa satu pun bukti terisi.

| Bukti | Slide | Jenis | Yang di-capture | Diisi ke mana |
|---|---|---|---|---|
| **BUKTI-1** | 4 | teks | Hasil satu prompt Supabase MCP di hook: migration bernama + TS types + query hasil (tanpa dashboard). | `bukti-data` → `bukti1.output` |
| **BUKTI-2** | 8 | teks | Hasil query top-5 seed via Supabase MCP read_only (tabel participants+scores, top-5 total_score). | `bukti-data` → `bukti2.output` |
| **BUKTI-3** | 9 | teks ×2 | Side-by-side: jawaban TANPA Context7 (dari ingatan model — tandai bagian usang bila ada) vs DENGAN Context7 (pgxpool v5 akurat). | `bukti-data` → `bukti3.tanpa` + `bukti3.dengan` |
| **BUKTI-4** | 10 | teks | Laporan Playwright MCP atas `localhost:5173` (struktur halaman + tabel leaderboard terisi). | `bukti-data` → `bukti4.output` |
| **BUKTI-5** | 13 | teks | Output `/context` yang menunjukkan porsi MCP tools (angka token per server) — plus baris `PERSIST OK` dari `assets/persist-check.sh` kalau mau. | `bukti-data` → `bukti5.output` |

## Catatan pengisian

- **Prompt BUKTI-1 SUDAH final** (verbatim dari `demo-script.md`) — hanya isi `output`.
- Teks `output` multi-baris: pakai `\n` di dalam string JSON.
- BUKTI-3 = pasangan dua kolom di SATU slide (9): `tanpa` kiri, `dengan` kanan — kontrasnya yang mengajar; potong ke bagian API yang relevan (pgxpool.New vs pola usang).
- BUKTI-2/4/5 = ringkasan teks; potong seperlunya agar muat di mockup terminal (poin utama, bukan dump penuh).
- JANGAN pernah menempel connection string / kredensial ke slot mana pun.
- Setelah mengisi, cek cepat: buka `index.html` (double-click, tanpa internet) →
  slide 4, 8, 9, 10, 13 harus menampilkan bukti, bukan placeholder.
