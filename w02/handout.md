# Cheat Sheet w02 — 8 Skill yang Dipakai Tiap Hari

> Simpan di meja. Semua entri sudah dibaca isinya & battle-tested (audit-before-install, lihat blok di bawah).
> Aturan emas sebelum install skill apa pun: **BACA ISINYA** — skill = instruksi yang dieksekusi agent dengan akses ke repo kalian.

## Konsep 60 detik

- **Skill** = instruksi jadi FILE (`SKILL.md`): frontmatter `description` = trigger (dibaca Claude buat memutuskan kapan skill jalan), body = prosedur.
- Kalian menulis instruksi yang sama di prompt ≥3×? Itu kandidat skill — dan kemungkinan besar SUDAH ada yang menuliskannya.
- 4 lapis ekosistem: **built-in CLI** (gratis, di laptopmu) → **resmi Anthropic** (kurasi) → **komunitas battle-tested** (superpowers/caveman/ponytail/ui-ux-pro-max) → **internal Venturo** (`/grademe`, nanti `venturo-arsenal` mg 7).

## 8 kartu hari ini

| # | Skill | Kondisi kerja | Command inti | JANGAN pakai kalau... |
|---|---|---|---|---|
| 1 | `find-skills` / `npx skills` | "pasti ada skill utk ini" | `npx skills find "code review"` | kamu langsung `/plugin install` nama tebakan tanpa cari+baca dulu |
| 2 | `superpowers:brainstorming` | fitur baru, requirement kabur | `/superpowers:brainstorming <task>` | perubahan trivial 1 baris yang sudah jelas |
| 3 | `superpowers:writing-plans` + `executing-plans` | task >3 langkah, takut ngawur | `/superpowers:writing-plans ...` → `/superpowers:executing-plans ...` | edit sepele satu file (overhead plan tak sepadan) |
| 4 | `/code-review` (built-in) | sebelum minta review manusia | `/code-review` | jadi pengganti test — ini review, bukan bukti jalan (`/verify`) |
| 5 | `superpowers:systematic-debugging` | bug misterius, tebak-tebakan mahal | `/superpowers:systematic-debugging debug ini — ...` | kamu lompat ke "coba ganti X" sebelum baca error & reproduksi |
| 6 | `caveman` | output verbose, boros token | task apa pun → `/caveman-stats` | dokumen yang memang harus prosa penuh (rilis notes, materi non-teknis) |
| 7 | `ponytail` | kode AI over-engineered | `... Terapkan ponytail.` | sampai memangkas validasi input/keamanan/error-handling |
| 8 | `impeccable` / `ui-ux-pro-max` | UI "generik AI" (intro hari ini, dipakai penuh w07) | `/plugin list` (verifikasi terpasang) | task backend/logika tanpa permukaan visual |

Install command persis (pin: `_shared/versions.md`):
```
/plugin install superpowers@claude-plugins-official                          # #2, #3, #5 (satu paket)
/plugin marketplace add JuliusBrussee/caveman
/plugin install caveman@caveman                                               # v1.9.1  — #6
/plugin marketplace add DietrichGebert/ponytail
/plugin install ponytail@ponytail                                             # v4.8.4  — #7
/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill
/plugin install ui-ux-pro-max@ui-ux-pro-max-skill                             # 2.6.2   — #8
```
`#1` (`npx skills`) dan `#4` (`/code-review`) — tidak perlu install.

## Katalog cadangan (kalau waktu longgar / dicek besok)

| Tool | Fungsi | Install |
|---|---|---|
| `document-generate` | Bikin dokumen (spec/report) terstruktur dari konteks kerja | cek via `npx skills find "document"` atau marketplace resmi |
| `security-review` | Audit keamanan diff — built-in, sebelum merge kode sensitif (detail penuh mg 10) | `/security-review` (built-in, tanpa install) |
| `skill-creator` | Panduan resmi Anthropic bikin skill sendiri — pakai SETELAH yakin ekosistem tak punya | marketplace resmi Anthropic |
| gstack suite (`/ship` `/investigate` `/qa` `/review` `/health`) | Ritual workflow harian: ship 1 komando, debugging root-cause, dst | per README `garrytan/gstack` (`docs/skills.md`) |

## Audit-before-install (WAJIB — 4 langkah, 30 detik)

Skill = instruksi yang **dieksekusi agent-mu dengan akses ke repo-mu**. Install tanpa baca = kasih orang asing kunci kantor.

1. **Buka `SKILL.md`-nya** sebelum install (link repo, atau `~/.claude/plugins/.../SKILL.md` sesudah install).
2. **Baca `description` (frontmatter)** — trigger-nya masuk akal? Scan body: ada perintah `rm`, `curl` ke domain asing, akses kredensial?
3. **Cek sinyal sehat**: stars, commit terakhir, ada benchmark/gotchas section. Ragu → jangan install, tanya di #stuck.
4. **Waspadai link/instruksi eksternal** — scan & baca hanya memotret paket *saat ini*; link bisa ditukar jadi jahat *setelah* lolos (bait-and-switch, kasus `brand-landingpage` → ±26.000 agent). Pin versi + re-audit tiap update.

## Scanner mandiri (opsional, dianjurkan)

Baca mata telanjang bagus, tapi **scanner menangkap yang terlewat**. Riset SkillSpector: **26% skill rentan, 5% berniat jahat**.

| Alat | Kapan | Command |
|---|---|---|
| **SkillSpector** (NVIDIA) | sebelum install — 68 pola (injection, exfiltrasi, supply-chain) | `skillspector scan ./skill/` |
| **skill-scanner / mcp-scanner** (Cisco AI Defense) | sebelum install — static+bytecode+dataflow, hidden instructions; MCP server | `skill-scanner scan ./skill --use-behavioral` |
| **claudit-sec** (Harmonic) | audit yang SUDAH terpasang — MCP/plugin/hooks/skills (read-only) | `./claude_audit.sh` |
| `/security-review` (built-in) | audit diff/kode sensitif, tanpa install | `/security-review` |

## Alur superpowers (dipakai sesi ini & besok pagi di project kalian)

```
/superpowers:brainstorming   → wawancara sampai spec matang (jawab dari konteks project-mu)
superpowers:writing-plans    → plan = task kecil + langkah verifikasi per task
superpowers:executing-plans  → eksekusi per-batch dengan checkpoint approval
```
Pola sehat penutup: `smoke test` → `/code-review` pada diff → **baru** minta review manusia.

## caveman vs ponytail — beda sasaran, saling melengkapi

| | caveman | ponytail |
|---|---|---|
| Memangkas | OMONGAN (prosa output) | KODE (over-engineering) |
| Sasaran | gaya bicara Claude | gaya kode yang ditulis Claude |
| Bonus | `/caveman-stats`, `caveman-compress` utk CLAUDE.md | penanda `ponytail:` (ceiling + kapan upgrade) di tiap simplifikasi |

## Kalau nanti menulis skill sendiri — 4 prinsip authoring

*(bekal untuk suatu hari; bukan tugas minggu ini — `skill-creator` resmi Anthropic memandu detailnya)*

- **description = trigger** — ditulis untuk MESIN, bukan manusia. Ini yang dibaca Claude untuk memutuskan kapan skill dipakai; deskripsi kabur = skill tak pernah jalan.
- **Gotchas section = konten paling bernilai** — tambah satu baris tiap Claude tersandung. Bagian ini yang paling menghemat waktu, bukan happy-path-nya.
- **progressive disclosure** — skill = FOLDER: `SKILL.md` jadi hub (ringkas), file pendukung (spoke) memuat detail kerja; dimuat hanya saat perlu → context tetap ramping.
- **don't railroad** — beri Claude INFO, bukan skrip kaku langkah-per-langkah. Biarkan dia beradaptasi ke situasi; skrip rigid patah di kasus nyata.

## Challenge Besok Pagi → detail & format lapor di `exercise.md`
