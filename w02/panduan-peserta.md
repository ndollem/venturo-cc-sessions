# w02 — Arsenal Skills #1: 8 Skill yang Dipakai Tiap Hari

> **Durasi:** 110–120 menit · **Format:** praktek di laptop masing-masing. Layar depan = slide panduan (bukan terminal pemateri). Kamu yang mengetik.
> **Baca dokumen ini di laptop sambil sesi jalan.** Tiap kartu punya blok `Expected result` — cocokkan layarmu dengan blok itu.

## Prasyarat H-7 (cek sebelum sesi — jangan install massal saat sesi)

- [ ] `claude --version` → **2.1.206** (semua peserta versi sama)
- [ ] `node --version` & `npx --version` jalan (buat kartu #1 `npx skills`)
- [ ] Marketplace resmi ter-add: `/plugin marketplace list` memuat `claude-plugins-official`
- [ ] grademe terpasang + token: `echo $VIBESCORE_API_URL` dan `echo $VIBESCORE_API_KEY` **dua-duanya tidak kosong** (token dari halaman /token, sudah di-export di `~/.zshrc`)
- [ ] Repo latihan ter-clone & checkout tag start:
  ```bash
  git clone https://github.com/ndollem/vibescore-api.git
  cd vibescore-api
  git checkout s1w2-start        # skeleton: cuma docs + CLAUDE.md, belum ada kode Go
  ```

> Ada yang belum centang? → **`troubleshooting.md`** (menyusul) atau kanal **#stuck**. Jangan blok sesi.

**Aturan main hari ini:** tiap kartu ada timebox. Nyangkut > 3 menit di satu kartu → pakai **⚡ Escape hatch**, lanjut ke kartu berikut, kejar sisanya pasca-sesi. Skill catalog = luas dulu, dalam belakangan.

---

## §0 — Pembuka: Ekosistem Skill 4 Lapis (10')

**Skill = instruksi jadi FILE** (`SKILL.md`): frontmatter `description` = trigger (dibaca Claude untuk memutuskan kapan skill jalan), body = prosedur. Kamu ketik instruksi yang sama ≥3× di prompt? Itu kandidat skill — dan kemungkinan besar **sudah ada** yang menuliskannya.

Ekosistemnya 4 lapis — dari yang paling dekat ke yang paling spesifik:

| Lapis | Isi | Pesan |
|---|---|---|
| **1. Built-in CLI** | `/code-review` `/verify` `/simplify` `/security-review` | Sudah di laptopmu. Gratis. Kebanyakan orang tak tahu. |
| **2. Resmi Anthropic** | marketplace `claude-plugins-official`, `frontend-design`, `skill-creator` | Kurasi resmi — mulai dari sini kalau ragu. |
| **3. Komunitas battle-tested** | `superpowers`, `caveman`, `ponytail`, `ui-ux-pro-max` | Dipakai puluhan ribu orang. Saring: stars + maintenance + benchmark. |
| **4. Internal Venturo** | `/grademe` (nanti: `venturo-arsenal` mg 7) | Yang spesifik kebutuhan kita, kita tulis sendiri. |

### Audit-before-install (WAJIB — 3 langkah, 30 detik)

Skill = instruksi yang **dieksekusi agent-mu dengan akses ke repo-mu**. Install tanpa baca = kasih orang asing kunci kantor.

1. **Buka `SKILL.md`-nya** sebelum install (link repo / `~/.claude/plugins/.../SKILL.md` sesudah install).
2. **Baca `description` (frontmatter)** — trigger-nya masuk akal? Dan scan body: ada perintah `rm`, `curl` ke domain asing, akses kredensial?
3. **Cek sinyal sehat**: stars, commit terakhir, ada benchmark/gotchas section. Ragu → jangan install, tanya di #stuck.

> **Teaser Arsenal:** ke-8 skill ini + MCP (w05) + hooks (w07) akhirnya dibungkus jadi **Venturo Arsenal** — di w07 semua ini terpasang seragam di tiap laptop dengan **1 perintah**. Hari ini kita kenalan satu-satu dulu.

---

## §1 — `find-skills` / `npx skills` — "pasti ada skill untuk ini" (8')

**1. Apa & kenapa butuh**
- Sebelum menulis prompt panjang berulang atau bikin skill sendiri: cek dulu ekosistem terbuka — biasanya sudah ada.
- `npx skills` = package manager skill (mirip `npm search`), discovery itu murah.

**2. Kapan pakai / kapan JANGAN**
- Pakai: awal tiap kebutuhan baru ("butuh sesuatu untuk X"). JANGAN: langsung `/plugin install` nama yang kamu tebak tanpa cari + baca dulu.

**3. Install** — tidak perlu (built pakai `npx`).

**4. Praktek** — di terminal biasa (bukan sesi `claude`):
```bash
npx skills find "code review"
```
Coba juga satu kata kunci milikmu: `npx skills find "pdf"` atau `npx skills find "testing"`.

**5. Expected result**
```
$ npx skills find "code review"
Found N skills matching "code review":
  <owner>/<skill-name>   <deskripsi singkat>
  ...
```
Anchor yang HARUS muncul: baris `Found` + minimal 1 kandidat `owner/skill-name`. (Daftar persisnya bervariasi — poinnya: discovery ada & murah.)

**6. ⚡ Escape hatch** — `npx` timeout/jaringan → lihat screenshot hasil di slide, lanjut ke §2. Kejar di troubleshooting.

> 🌉 **Transfer:** Kebutuhan apa di project kerjamu yang belum pernah kamu cek dulu apakah sudah ada skill-nya?

---

## §2 — `superpowers:brainstorming` — requirement kabur → spec (15')

**1. Apa & kenapa butuh**
- Fitur baru, requirement masih kabur → langsung "build X" = asumsi tak teruji jadi kerja mubazir.
- Skill ini memaksa alur senior engineer: **tanya dulu, baru desain** — dan menolak nulis kode sampai desain di-approve.

**2. Kapan pakai / kapan JANGAN**
- Pakai: setiap kerja kreatif (fitur/komponen baru). JANGAN dipakai untuk perubahan trivial 1 baris yang sudah jelas.

**3. Install** — bagian dari `superpowers` (satu paket dipakai §2–§3):
```
/plugin install superpowers@claude-plugins-official
```
(pin: superpowers **6.1.1** — `_shared/versions.md`)

**4. Praktek** — di sesi `claude` dalam folder `vibescore-api`:
```
/superpowers:brainstorming tambah endpoint GET /healthz untuk liveness check di vibescore-api
```
Jawab pertanyaan Claude **satu per satu** (referensi jawaban ada di `docs/01-prd.md` §3 & §5). Setelah 2–3 putaran, saat Claude sodorkan desain → ketik **approve**.

**5. Expected result** — Claude **TIDAK** langsung nulis kode. Yang muncul:
```
I'm exploring the project context first...
[Claude baca docs/01-prd.md, CLAUDE.md]

Question 1 of a few: <satu pertanyaan tajam>
  (a) ...
  (b) ...
```
Anchor: (1) **satu pertanyaan per pesan** (bukan borongan), (2) Claude menolak coding sebelum approve (HARD-GATE), (3) setelah approve → file spec ditulis ke `docs/superpowers/specs/YYYY-MM-DD-healthz-design.md`.

**6. ⚡ Escape hatch** — Claude malah nulis kode / lompat gate → ketik `stop — jangan implement dulu, ajukan pertanyaan satu per satu sampai aku approve`. Masih ngawur → skip ke §3 (plan bisa jalan dari spec seadanya), kejar di troubleshooting.

> 🌉 **Transfer:** Requirement kabur apa di project kerjamu yang selama ini langsung kamu "build" tanpa nanya dulu?

---

## §3 — `superpowers:writing-plans` + `executing-plans` — task > 3 langkah (18')

**1. Apa & kenapa butuh**
- Task multi-langkah + takut Claude ngawur → butuh plan tertulis: task kecil ber-checkbox + langkah verifikasi tiap task.
- `executing-plans` menjalankan plan itu **per-task dengan checkpoint** — kamu review di antara task, bukan sekali telan.

**2. Kapan pakai / kapan JANGAN**
- Pakai: setiap task > 3 langkah / lintas file. JANGAN untuk edit sepele satu file (overhead plan tak sepadan).

**3. Install** — sudah (bagian `superpowers` dari §2).

**4. Praktek** — lanjut dari spec §2:
```
/superpowers:writing-plans buat plan implementasi dari spec /healthz tadi
```
Setelah plan tersimpan, Claude tawarkan mode eksekusi → pilih **Inline Execution**, lalu:
```
/superpowers:executing-plans jalankan plan /healthz, checkpoint tiap task
```

**5. Expected result**
```
I'm using the writing-plans skill to create the implementation plan.
...
Plan complete and saved to docs/superpowers/plans/YYYY-MM-DD-healthz.md
```
Buka file plan → tiap task berformat checkbox `- [ ]` dengan langkah + kode. Lalu saat execute:
```
I'm using the executing-plans skill to implement this plan.
```
Anchor: (1) plan file di `docs/superpowers/plans/…md` dengan task `- [ ]`, (2) file kode dibuat/di-edit nyata (mis. `cmd/api/main.go`, `internal/server/server.go`), (3) Claude berhenti di checkpoint minta approval antar-task.

> Tak punya Go toolchain di w02? Tak apa — yang dinilai di sini **artefak plan + file kode yang ditulis**, bukan `go test` hijau (itu w03). Punya Go? Bonus: minta Claude jalankan `go test ./...` di task terakhir.

**6. ⚡ Escape hatch** — execute macet/error → `git checkout s1w2-start -- .` untuk reset, ATAU salin plan yang sudah jadi & lanjut. Diff dari kartu ini dipakai lagi di §4/§6/§7 — kalau execute gagal, pakai diff kecil apa pun yang ada.

> 🌉 **Transfer:** Task >3 langkah di backlog kerjamu yang biasanya kamu embat sekaligus tanpa plan tertulis — yang mana?

---

## §4 — `/code-review` (built-in) — sebelum minta review manusia (10')

**1. Apa & kenapa butuh**
- Output AI naik drastis → review manual jadi bottleneck. `/code-review` = tim agent yang berburu bug korektness + simplifikasi di diff-mu.
- Pola sehat: `smoke test` → `/code-review` → **baru** minta review manusia (jangan buang waktu reviewer untuk temuan yang mesin sudah tangkap).

**2. Kapan pakai / kapan JANGAN**
- Pakai: sebelum PR / sebelum panggil reviewer. JANGAN jadikan pengganti test — ini review, bukan bukti jalan (itu `/verify`).

**3. Install** — tidak perlu (built-in CLI).

**4. Praktek** — di sesi `claude`, dengan diff `/healthz` dari §3 belum di-commit:
```
/code-review
```

**5. Expected result** — temuan ter-rank per severity, atau bersih:
```
Reviewing current diff...

Findings (ranked):
1. [correctness] internal/server/server.go:NN — <ringkasan defect>
2. [simplification] ...
```
Anchor: daftar temuan dengan **kategori** (`correctness`/`simplification`/dll) + **file:line**. Diff bersih → laporan eksplisit "no findings" (juga hasil valid).

**6. ⚡ Escape hatch** — tak ada diff untuk direview → `/code-review` akan bilang tak ada perubahan. Pakai diff apa pun dari §3, atau lanjut ke §5.

> 🌉 **Transfer:** PR terakhirmu — kalau di-`/code-review` dulu sebelum reviewer manusia, kira-kira apa yang bakal ketangkep?

---

## §5 — `superpowers:systematic-debugging` — bug misterius, stop shotgun-fix (14')

**1. Apa & kenapa butuh**
- Bug misterius → tebak-tebakan fix mahal & bikin bug baru. Iron Law skill ini: **NO FIX WITHOUT ROOT CAUSE FIRST**.
- Memaksa 4 fase: root cause → pattern → 1 hipotesis → 1 fix + verifikasi.

**2. Kapan pakai / kapan JANGAN**
- Pakai: bug/test gagal/perilaku aneh apa pun. JANGAN lompat ke "coba ganti X" sebelum baca error & reproduksi.

**3. Install** — sudah (bagian `superpowers`).

**4. Praktek** — paste snippet buggy ini + minta debug sistematis. Fungsi ini **mestinya** urutkan leaderboard skor tertinggi di atas, tapi hasilnya kebalik:
````
/superpowers:systematic-debugging debug ini — test merah, leaderboard harusnya DESC (skor tertinggi paling atas) tapi keluar ASC:

```go
func sortLeaderboard(e []Entry) {
    sort.Slice(e, func(i, j int) bool {
        return e[i].Score < e[j].Score   // test: e[0].Score harus yang TERTINGGI
    })
}
```
````

**5. Expected result** — Claude jalankan proses, **bukan** langsung tembak fix:
```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST

Phase 1 — Root Cause: comparator mengembalikan e[i] < e[j] → sort ascending.
Expected leaderboard descending.
Hypothesis: baris comparator pakai `<`, seharusnya `>`.
Root cause: operator `<` pada perbandingan Score.
Fix: `return e[i].Score > e[j].Score`
```
Anchor: (1) Claude sebut **root cause di baris comparator** sebelum fix, (2) fix = ubah `<` → `>` (satu baris), bukan menambal di tempat lain. Punya Go → tulis test `e[0]` skor tertinggi, lihat MERAH → fix → HIJAU.

**6. ⚡ Escape hatch** — Claude tetap shotgun (langsung nulis fix tanpa Phase 1) → ketik `stop guessing — kerjakan Phase 1 root cause dulu`. Lanjut §6 kalau macet.

> 🌉 **Transfer:** Bug misterius terakhir yang kamu tebak-tebak fix-nya — gimana kalau dijalankan Phase 1 root cause dulu?

---

## §6 — `caveman` — output verbose boros token (12')

**1. Apa & kenapa butuh**
- Output Claude bertele-tele = bayar token untuk basa-basi. `caveman` pangkas **omongan** (prosa output), substansi teknis tetap utuh.
- `/caveman-stats` kasih angka hemat; `caveman-compress` bisa rampingkan `CLAUDE.md`.

**2. Kapan pakai / kapan JANGAN**
- Pakai: sesi kerja panjang, banyak output. JANGAN untuk dokumen yang memang harus prosa penuh (rilis notes, materi ke non-teknis).

**3. Install**
```
/plugin marketplace add JuliusBrussee/caveman
/plugin install caveman@caveman
```
(pin: caveman **v1.9.1**)

**4. Praktek** — minta task yang biasanya bikin Claude cerewet, lalu cek statistik:
```
Jelaskan struktur folder vibescore-api dan tanggung jawab tiap package.
/caveman-stats
```

**5. Expected result** — gaya jawaban jadi telegrafis (fragmen, tanpa basa-basi), lalu:
```
caveman stats
  tokens saved: ~XX%
  ...
```
Anchor: (1) output jelas lebih ringkas/fragmen setelah caveman aktif, (2) `/caveman-stats` cetak **persentase token hemat** (angka bervariasi, sekitar dua digit persen).

**6. ⚡ Escape hatch** — `/caveman-stats` belum ada angka (baru aktif) → jalankan 1 task lagi lalu ulang. Install gagal → skip ke §7, kejar di troubleshooting.

> 🌉 **Transfer:** Sesi kerja mana di project kamu yang paling sering bikin Claude cerewet & boros token?

---

## §7 — `ponytail` — kode AI over-engineered, YAGNI ladder (12')

**1. Apa & kenapa butuh**
- Kode hasil vibe coding sering over-engineered (abstraksi 1 pemakai, factory buat 1 produk). `ponytail` = tangga YAGNI: perlu ada? → stdlib cukup? → native cukup? → baru kode minimal.
- Menandai simplifikasi sengaja dengan komentar `ponytail:` (menyebut ceiling + kapan upgrade).

**2. Kapan pakai / kapan JANGAN**
- Pakai: sebelum menerima kode baru dari AI, atau saat diff terasa gemuk. JANGAN sampai memangkas validasi input/keamanan/error-handling (itu bukan over-engineering).

**3. Install**
```
/plugin marketplace add DietrichGebert/ponytail
/plugin install ponytail@ponytail
```
(pin: ponytail **v4.8.4**)

**4. Praktek** — minta tambahan kecil ke `/healthz` dari §3 dengan ponytail aktif:
```
Tambahkan field "uptime" ke response /healthz. Terapkan ponytail.
```

**5. Expected result** — diff ramping + reasoning tangga:
```
[kode minimal — pakai time sejak start, tanpa lib/abstraksi baru]
// ponytail: skipped — <apa yang tak dibuat>, add when <kondisi>
→ skipped: <X>, add when <Y>.
```
Anchor: (1) solusi pakai stdlib/native (bukan dependency/abstraksi baru), (2) ada penanda `ponytail:` yang menyebut apa yang di-skip + kapan ditambah.

**6. ⚡ Escape hatch** — ponytail malah nambah kompleksitas → ketik `pakai YAGNI ladder: opsi paling sederhana yang jalan`. Lanjut §8.

> 🌉 **Transfer:** Kode hasil AI mana di project kamu yang kalau di-`ponytail` bisa dirampingin?

---

## §8 — `impeccable` / `ui-ux-pro-max` — UI "generik AI" → polish (8', intro)

**1. Apa & kenapa butuh**
- UI hasil vibe coding sering "generik AI" (default template, hierarki datar). Skill design intelligence mendorong pilihan intensional: tipografi, spacing, motion.
- vibescore-be ini backend (tanpa UI) → hari ini **intro + install saja**; pemakaian nyata di **w07** (design pass 1 halaman project kerjamu) & bonus battle w08.

**2. Kapan pakai / kapan JANGAN**
- Pakai: audit/polish 1 komponen UI. JANGAN untuk task backend/logika (tak ada permukaan visual).

**3. Install**
```
/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill
/plugin install ui-ux-pro-max@ui-ux-pro-max-skill
```
(pin: ui-ux-pro-max **2.6.2**) · `impeccable` **⚠️ belum di-pin** (verifikasi H-7 sebelum uji mesin bersih) — hari ini cukup catat namanya.

**4. Praktek** — verifikasi terpasang saja (tanpa target UI di repo ini):
```
/plugin list
```
Punya komponen UI di project kerja? Simpan untuk challenge w07: `polish 1 komponen kecil, tunjukkan before/after`.

**5. Expected result**
```
Installed plugins:
  ...
  ui-ux-pro-max@ui-ux-pro-max-skill  2.6.2
```
Anchor: `ui-ux-pro-max` muncul di daftar plugin terpasang. (Contoh audit visual before/after → didemokan di w07.)

**6. ⚡ Escape hatch** — install marketplace gagal → catat untuk troubleshooting, tak memblok grademe. Lanjut ke penutup.

> 🌉 **Transfer:** Komponen UI mana di project kamu yang paling "generik AI" dan siap dipolish di w07?

---

## §9 — Penutup: `/grademe` → Leaderboard (10')

Sesi ditutup dengan menilai praktekmu barusan dan mengunggahnya ke leaderboard.

**Praktek:**
```
/grademe <nama-kamu>
```

**Expected result** — JSON skor (shape kontrak, field persis) + narasi Bahasa Indonesia + baris upload:
```json
{
  "participant": "<nama-kamu>",
  "session_date": "2026-07-17T...",
  "total_score": 0,
  "breakdown": {
    "planning": 0, "context": 0, "decomposition": 0,
    "delegation": 0, "verification": 0, "token_efficiency": 0,
    "documentation": 0
  },
  "misses": ["..."],
  "next_session_advice": "..."
}
```
```
Skor terkirim ke leaderboard.  → 201 Created
participant: <nama>  id: <id>
```
Anchor: (1) `total_score` = jumlah `breakdown`, (2) status **`201 Created`** (env `VIBESCORE_API_URL` + `VIBESCORE_API_KEY` lengkap → upload otomatis).

Status lain (apa adanya, bukan error di sisimu):
- `409` → sesi ini sudah pernah di-upload (dedup) — skor tak digandakan.
- `401` → `VIBESCORE_API_KEY` salah/absen — skor TIDAK terkirim (perbaiki token, cek prasyarat H-7).

**⚡ Escape hatch** — upload gagal (401/timeout) → skor tetap tampil di layar; screenshot + lapor #stuck, asisten bereskan pasca-sesi.

---

### 🌅 Challenge Besok Pagi

Di **project kerja nyata** besok, pakai **≥ 2 skill baru** dari hari ini (mis. `brainstorming` untuk fitur baru + `/code-review` sebelum PR, atau `caveman` sepanjang sesi + `systematic-debugging` saat ketemu bug).

**Format lapor** (kirim ke kanal tim, singkat):
```
Skill dipakai : <skill A>, <skill B>
Task          : <1 kalimat>
Nempel?       : <skill mana yang kamu terusin & kenapa>
```

> Semua skill hari ini + MCP (w05) + hooks (w07) → dibungkus jadi **Venturo Arsenal**, terpasang 1 perintah di w07. Hari ini kamu sudah pegang arsenalnya satu-satu.
