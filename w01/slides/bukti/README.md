# Bukti — teks expected (default sudah terisi)

Semua slot ada di blok `<script id="bukti-data">` di atas `index.html` (cari komentar `TEKS EXPECTED`).
Field `"output"`/`"score"` **sudah berisi teks expected** — gambaran hasil yang seharusnya muncul saat
rehearsal. Deck aman dipresentasikan apa adanya; presenter **boleh menimpa** dengan output rehearsal asli.

1. **bukti1 / bukti2 / bukti3** — `"output"`: teks mentah hasil run (multi-baris pakai `\n`). Prompt final, jangan diubah.
2. **bukti3** — `"output"`: JSON `/grademe` (field `total_score` + `breakdown` 7 dimensi + `misses` + `next_session_advice`) sebagai TEKS.
3. **bukti4** — `"score"`: angka skor instruktur saja (mis. `"78"`).

Semua bukti = TEKS (tak ada file PNG, tak ada placeholder kamera). Kalau presenter mengosongkan sebuah
field, slot jadi note teks muted — deck tetap aman.
