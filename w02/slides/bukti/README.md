# Bukti w02 — isi setelah rehearsal sukses

Deck menampilkan 5 bukti statis dari rehearsal. Bukti TEKS diisi di blok
`<script id="bukti-data">` di atas `index.html` (cari komentar `ISI SETELAH REHEARSAL`).
Bukti GAMBAR ditaruh sebagai file `.png` di folder ini.

Slot kosong / gambar hilang otomatis jadi placeholder "Capture dari rehearsal" —
deck tetap aman dipresentasikan tanpa satu pun bukti terisi.

| Bukti | Slide | Jenis | Yang di-capture | Diisi ke mana |
|---|---|---|---|---|
| **BUKTI-1** | 4 | teks | Pertanyaan tajam Claude saat `/superpowers:brainstorming` (MENOLAK coding, tanya edge case / storage / user). Ambil 3–4 pertanyaan pertama. | `bukti-data` → `bukti1.output` |
| **BUKTI-2** | 10 | teks | Temuan `/code-review` pada diff skeleton w02 (Segmen 5e rehearsal). Boleh "nol temuan" — tetap informatif. | `bukti-data` → `bukti2.output` |
| **BUKTI-3** | 12 | gambar | Screenshot run `/investigate` (debugging sistematis atas bug kecil disengaja di vibescore-api). | `bukti/bukti-3.png` |
| **BUKTI-4** | 13 | gambar | Screenshot before/after verbosity + output `/caveman-stats` pada task yang sama. | `bukti/bukti-4.png` |
| **BUKTI-5** | 16 | teks | Ringkasan execute penuh + output `smoke-api.sh` yang berakhir `SMOKE OK` (go test hijau). | `bukti-data` → `bukti5.output` |

## Catatan pengisian

- **Prompt SUDAH final** (verbatim dari `demo-script.md`) untuk BUKTI-1 (`bukti1.prompt` =
  blok `/superpowers:brainstorming` + "Saya mau membangun skeleton pertama…") dan
  BUKTI-2 (`bukti2.prompt` = `/code-review`). **Jangan diubah** — hanya isi `output`.
- Teks `output` multi-baris: pakai `\n` di dalam string JSON.
- BUKTI-1 slide 4 memakai pola progressive reveal (prompt → pertanyaan "Claude langsung
  nulis kode?" → reveal output). Isi `bukti1.output` dengan pertanyaan-pertanyaan Claude,
  bukan kode.
- Screenshot idealnya rasio landscape lebar; ditampilkan `width:100%` di dalam mockup terminal.
- Setelah mengisi, cek cepat: buka `index.html` (double-click, tanpa internet) →
  slide 4, 10, 12, 13, 16 harus menampilkan bukti, bukan placeholder.
