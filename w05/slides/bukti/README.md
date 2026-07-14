# Bukti — teks expected (default sudah terisi)

Semua slot ada di blok `<script id="bukti-data">` di atas `index.html` (cari komentar `TEKS EXPECTED`).
Field `"output"`/`"tanpa"`/`"dengan"` **sudah berisi teks expected** — gambaran hasil yang seharusnya
muncul saat rehearsal. Deck aman dipresentasikan apa adanya; presenter **boleh menimpa** dengan output
rehearsal asli.

1. **bukti1** (slide 4) — `"output"`: migration bernama + TS types via Supabase MCP, tanpa dashboard. Prompt final, jangan diubah.
2. **bukti2** (slide 8) — `"output"`: query top-5 seed via Supabase MCP read_only (2 tabel). Angka HARUS grounded ke `_shared/seed/seed.sql`.
3. **bukti3** (slide 9) — `"tanpa"` + `"dengan"`: side-by-side jawaban dari ingatan model (pola pgx v4 usang) vs docs Context7 (pgxpool v5 akurat).
4. **bukti4** (slide 10) — `"output"`: laporan Playwright MCP atas `localhost:5173` (accessibility tree).
5. **bukti5** (slide 13) — `"output"`: `/context` breakdown porsi MCP tools.

Teks multi-baris pakai `\n`; potong seperlunya agar muat di mockup terminal.
JANGAN pernah menempel connection string / kredensial ke slot mana pun.

Semua bukti = TEKS (tak ada file PNG, tak ada placeholder kamera). Kalau presenter mengosongkan sebuah
field, slot jadi note teks muted — deck tetap aman.
