# Bukti w03 — isi setelah rehearsal sukses

Deck menampilkan 5 bukti statis dari rehearsal. Bukti TEKS diisi di blok
`<script id="bukti-data">` di atas `index.html` (cari komentar `ISI SETELAH REHEARSAL`).
Bukti GAMBAR (kalau ada) ditaruh sebagai file `.png` di folder ini.

Slot kosong / gambar hilang otomatis jadi placeholder "Capture dari rehearsal" —
deck tetap aman dipresentasikan tanpa satu pun bukti terisi.

| Bukti | Slide | Jenis | Yang di-capture | Diisi ke mana |
|---|---|---|---|---|
| **BUKTI-1** | 4 | teks | Output `/context` saat task riset dikerjakan di MAIN session (tanpa subagent) — angka context hampir penuh. | `bukti-data` → `bukti1.output` |
| **BUKTI-2** | 5 | teks | Output `/context` saat task IDENTIK didelegasikan ke Explore subagent — angka context ramping. Pasangan before/after BUKTI-1. | `bukti-data` → `bukti2.output` |
| **BUKTI-3** | 12 | teks | Ringkasan `api-contract-reader` atas `openapi.yaml` (3 endpoint + ScoreSubmission/Breakdown 7 dimensi/LeaderboardEntry + aturan sort). | `bukti-data` → `bukti3.output` |
| **BUKTI-4** | 14 | teks | Dua ringkasan subagent paralel: temuan `code-reviewer` + hasil `test-writer` (test hijau). | `bukti-data` → `bukti4.output` |
| **BUKTI-5** | 15 | teks | Output `node e2e-check.ts` yang berakhir `E2E OK` (submit + leaderboard + jalur error). | `bukti-data` → `bukti5.output` |

## Catatan pengisian

- **Prompt SUDAH final** (verbatim dari `demo-script.md`) untuk slot yang menampilkan command yang diketik (mis. `/context`). Jangan diubah — hanya isi `output`.
- Teks `output` multi-baris: pakai `\n` di dalam string JSON.
- BUKTI-1 & BUKTI-2 = pasangan side-by-side (slide 4 & 5): tunjukkan angka context penuh vs ramping. Isi angka `/context` yang persis dari rehearsal — dampak visualnya justru pada kontras dua angka.
- BUKTI-3/4/5 = ringkasan teks; potong seperlunya agar muat di mockup terminal (poin utama, bukan dump penuh).
- Kalau lebih suka screenshot untuk BUKTI-3/4/5, ganti slot jadi gambar (lihat pola `imageSlot` di engine) dan taruh `.png` di folder ini.
- Setelah mengisi, cek cepat: buka `index.html` (double-click, tanpa internet) →
  slide 4, 5, 12, 14, 15 harus menampilkan bukti, bukan placeholder.
