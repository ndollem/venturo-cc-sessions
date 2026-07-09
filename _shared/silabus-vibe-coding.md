# Silabus Vibe Coding — Venturo "Claude Code Unleashed"

**Peta keterampilan yang tumbuh, minggu demi minggu.** Dokumen ini menjawab empat pertanyaan untuk tiap minggu: *apa topiknya*, *kenapa penting*, *apa yang bisa kamu lakukan setelahnya*, dan *bagaimana cara memakainya* (command siap tempel).

|  | |
|---|---|
| **Ini adalah** | benang merah 12 minggu — peta keterampilan + command inti |
| **Ini bukan** | jadwal delivery (lihat `README.md` charter) · cheat sheet per sesi (lihat `w{NN}/handout.md`) |
| **Cara baca** | Bagian 0 sekali di awal (fondasi, berlaku selamanya) → lalu satu kartu per minggu |
| **Bahasa** | Indonesia; prompt & istilah teknis boleh English |

### Legend

| Tanda | Arti |
|---|---|
| 🟢 | Materi siap — paket sesi sudah dibangun & diuji |
| 📝 | Materi final menyusul — isi sudah dikunci di master plan, detail diperkaya saat paket dibangun |
| ⚔️ | Battle — konsolidasi, tidak ada primitive baru |
| ★ | Elemen baru minggu itu |
| ⚠️ | Fitur bergerak cepat / belum GA — **wajib verifikasi H-7** sebelum dipakai di kelas |
| → | Dimensi rubrik `/grademe` yang dikuatkan elemen tersebut |

> **Fact-check.** Semua command & konfigurasi di dokumen ini diverifikasi ke `code.claude.com/docs` dan CLI aktual (Claude Code 2.1.205) pada **2026-07-09**. Versi yang di-pin untuk kelas ada di `_shared/versions.md`. Fitur bertanda ⚠️ bisa berubah sebelum sesinya tiba.

---

## Bagian 0 — Fondasi Tetap

*Dibaca sekali di Minggu 1. Dipakai selamanya.*

### 0.1 Apa itu "vibe coding yang benar" ala Venturo

Vibe coding **bukan** "ketik prompt, terima nasib". Vibe coding yang benar = kamu mengarahkan Claude seperti mengarahkan senior engineer: **rencana dulu, konteks jelas, tugas dipecah, eksekusi terdelegasi, lalu diverifikasi**.

Kualitas hasil ditentukan **cara pakaimu**, bukan kehebatan model. Seluruh kurikulum ini melatih satu hal: memindahkan kalian dari *penonton output* jadi *pengendali proses*.

### 0.2 Loop Inti — Plan → Context → Task → Execute → Verify

Tulang punggung tiap sesi, dan **persis dimensi rubrik `/grademe`**. Hafalkan.

| Langkah | Artinya | Dimensi /grademe | Bobot |
|---|---|---|---|
| **Plan** | Rencanakan sebelum mengetik kode. Plan mode, approve rencana. | Planning First | 20 |
| **Context** | Beri Claude konteks tepat (CLAUDE.md, scope), buang yang tak perlu. | Context Quality | 20 |
| **Task** | Pecah kerja jadi potongan kecil yang bisa diverifikasi. | Task Decomposition | 15 |
| **Execute** | Delegasikan ke layer/tool yang tepat (skill, subagent, MCP). | Delegasi & Tooling | 15 |
| **Verify** | Buktikan jalan end-to-end sebelum bilang "selesai". | Verifikasi | 15 |
| *+ selalu* | Hemat token (context bersih, model routing). | Efisiensi Token | 10 |
| *+ selalu* | Tinggalkan jejak (PRD, decision, README). | Dokumentasi | 5 |

> **Retry karena Claude salah paham = pemborosan token terbesar.** Plan dulu ⇒ hemat paling besar.

### 0.3 Tujuh Extension Primitives

Claude Code diperluas lewat 7 primitive. Silabus memperkenalkannya **satu per minggu** — di w9 gambarannya utuh.

| # | Primitive | Definisi singkat | Diperkenalkan |
|---|---|---|---|
| 1 | **CLAUDE.md** | Markdown konteks always-on tiap session | w1 |
| 2 | **Skills** | Instruksi terpaket, dimuat saat task cocok (slash / auto) | w2 |
| 3 | **Subagents** | Instance Claude terisolasi, context & tool sendiri | w3 |
| 4 | **MCP** | Protokol koneksi ke tools & data eksternal | w5 |
| 5 | **Hooks** | Command otomatis di titik lifecycle Claude | w6 |
| 6 | **Plugins** | Bundel skills+hooks+subagents+MCP jadi 1 unit installable | w7 |
| 7 | **Agent Teams** | Session paralel dengan lead, komunikasi 2 arah (⚠️ experimental) | w9 |

**Mental model** (ulang tiap sesi):

```
Harness (Claude Code)
└── Main Agent
    ├── CLAUDE.md    ← konteks always-on
    ├── Skills       ← konteks on-demand (context window sama)
    ├── Subagents    ← worker terisolasi, komunikasi 1 arah
    └── Agent Teams  ← proses terpisah, komunikasi 2 arah

Hooks   → kontrol deterministik di semua layer
Plugins → layer distribusi/packaging
MCP     → tool surface ke dunia luar
```

**Mantra pemilihan layer** — kapan pakai apa:

| Kebutuhan | Layer |
|---|---|
| Aturan yang berlaku di tiap task | **CLAUDE.md** |
| Workflow berulang | **Skill** |
| Task berat / riset banyak file | **Subagent** |
| Aturan yang **tidak boleh** dilanggar | **Hook** |
| Sistem eksternal (DB, browser, API) | **MCP** |
| Dibagikan ke tim | **Plugin** |
| Worker perlu koordinasi mid-task | **Agent Teams** |

### 0.4 Kompas Penilaian Diri — rubrik `/grademe`

`/grademe` = skill internal Venturo yang menilai transkrip sesimu pada 7 dimensi di §0.2. Dipakai sejak w1 sebagai baseline, lalu jadi alat pertandingan di battle.

Output JSON (kontrak leaderboard): `total_score` + `breakdown` per dimensi + `misses[]` + `next_session_advice`.
**v0.1** (w1) = scoring lokal · **v0.2** (w6) = flag `--upload` ke leaderboard yang kita bangun sendiri.

Tiap elemen minggu ditandai `→ Dimensi` supaya kamu tahu latihan mana menaikkan skor mana.

### 0.5 Tiga catatan arah kurikulum

Tiga keputusan yang menjelaskan *kenapa materi ini disusun begini* — supaya kalian tidak bingung membaca tips dari luar.

| # | Keputusan | Artinya buat kamu |
|---|---|---|
| **D1** | **Plan mode tetap alat utama** | Auto mode (⚠️ research preview) memang membuat Claude jalan panjang tanpa banyak prompt izin. Tapi plan mode adalah **alat belajar**: ia memaksa kamu membaca rencana sebelum kode ditulis. Untuk task berisiko, plan mode tetap jawaban yang benar. Dimensi "Planning First" tidak ke mana-mana. |
| **D2** | **Fitur otonomi = teaser** | `/goal`, `/loop`, `/schedule`, auto mode, background agents, nested subagents diperkenalkan sebagai **konsep + cara pakai**, bukan tuntutan. Kami tunjukkan kapan berguna dan kapan berbahaya — bukan menyuruh kalian pakai. |
| **D3** | **Model-agnostik** | Materi ini **tidak menyebut nama model tertentu** sebagai aturan. Prinsipnya: *"pakai model terkuat yang tersedia + thinking untuk reasoning; model cepat/murah untuk grunt work."* Nama & versi model spesifik yang dipakai kelas ada di `_shared/versions.md` — bukan di sini, karena berubah tiap kuartal. |

---
## Bagian 1 — Progresi Mingguan

Tiap minggu punya kartu dengan struktur sama: **Konteks → Outcome → Elemen → Cara pakai → Live build → Toolkit → Challenge.** Kotak 🎒 Toolkit membesar tiap minggu — itulah bukti "bertambah".

---

### Minggu 1 — CLAUDE.md, Plan Mode & Built-ins &nbsp;&nbsp; 🟢
**Primitive #1: CLAUDE.md** · *"Kamu baru pakai 20% dari Claude Code."*

❓ **Konteks**
Claude tidak tahu konvensi tim kalian. Tanpa konteks tertulis, ia menebak — dan tebakan yang salah baru ketahuan setelah kode jadi. Di sisi lain, kebanyakan orang langsung menyuruh Claude mengetik kode, padahal kesalahan termahal terjadi di menit pertama: salah paham soal *apa* yang harus dibangun.

🎯 **Outcome** — setelah minggu ini kamu bisa:
- ☐ Menulis `CLAUDE.md` sehat (≤50 baris) untuk project kerjamu
- ☐ Menjalankan task lewat plan mode: baca rencana → approve → eksekusi
- ☐ Mengaudit context window dan tahu kapan `/compact` vs `/clear`
- ☐ Membaca skor `/grademe` pertamamu sebagai baseline

🔧 **Elemen**

| Elemen | Kapan pakai | Anti-pattern | → Dimensi |
|---|---|---|---|
| ★ **Plan Mode** | Task >1 file · belum yakin solusi · repo asing | Langsung eksekusi di repo besar tanpa rencana | Planning First |
| ★ **CLAUDE.md** | Aturan yang berlaku di **tiap** task | CLAUDE.md gemuk berisi hal yang bisa dibaca dari kode | Context Quality · Dokumentasi |
| ★ **`/init`** | Sekali per project, lalu **rapikan hasilnya** | Pakai output mentah `/init` apa adanya | Context Quality |
| ★ **`/context`** | Sebelum mulai kerja & saat jawaban mulai ngawur | Jalan terus sampai Claude "bodoh" | Efisiensi Token |
| ★ **`/compact` vs `/clear`** | `/compact` = lanjut task sama · `/clear` = ganti task | Satu sesi hidup lintas banyak task (*context rot*) | Efisiensi Token |
| ★ **Built-in agents** | Explore (cari) · Plan (riset saat plan mode) · general-purpose · claude-code-guide | Semua dikerjakan di main session | Delegasi & Tooling |
| ★ **Tulis, jangan re-prompt** | Claude salah? Perbaiki **aturannya**, bukan hanya jawabannya | Mengoreksi hal yang sama tiap sesi lewat chat | Dokumentasi · Efisiensi Token |

**Resep CLAUDE.md sehat** — 4 section: *Stack · Perintah · Aturan wajib · Konvensi*. Target ≤50 baris.
Ujian tiap baris: *"kalau baris ini dihapus, apakah Claude salah jalan?"* Kalau tidak → hapus.

🛠️ **Cara pakai**

```bash
claude --version          # semua peserta wajib versi sama (lihat _shared/versions.md)
```

Masuk **plan mode** — tekan `Shift+Tab` untuk meng-*cycle* permission mode:
`default (Manual)` → `acceptEdits` → `plan`. Mode aktif tampil di status bar.
Atau langsung: `/plan perbaiki bug auth`. Keluar tanpa approve: `Shift+Tab` lagi.

```bash
claude --permission-mode plan     # mulai sesi langsung di plan mode
```

Built-in yang dipakai minggu ini:

```
/init              # generate CLAUDE.md awal dari isi repo → LALU RAPIKAN
/context           # audit context window (grid berwarna + saran)
/compact <hint>    # ringkas percakapan, lanjut task yang sama (hint = fokus ringkasan)
/clear             # buang context, mulai task baru
/memory            # edit CLAUDE.md + kelola auto-memory
/review <PR>       # review GitHub PR (diff lokal → /code-review, w2)
```

**Template prompt "konteks penuh di turn pertama"** — tempel pola ini, jangan mencicil informasi:

```
Goal:        <hasil akhir yang kamu mau, 1 kalimat>
Constraints: <batasan: jangan sentuh X, pakai library Y, no new deps>
Acceptance:  <cara membuktikan selesai: test hijau, endpoint balas 201, dst>
```

**Pola "tulis, jangan re-prompt"** — kalimat yang wajib jadi kebiasaan:

```
Update your CLAUDE.md so you don't make that mistake again.
```

Kontrol sesi: background task `Ctrl+B` · todo list `Ctrl+T` · extended thinking `Alt+T`.

> **Project baru vs existing** — alur sama, titik berat beda. Project **baru**: BANGUN konteks (definisi produk → `/init` → template → PRD). Project **existing**: SARING konteks (`/init` → review diff-nya → pangkas ≤50 baris). Sudah punya CLAUDE.md? `/init` mengusulkan perbaikan, bukan menimpa buta — **review diff-nya**. Detail: `w01/handout.md`.

🔨 **Live build** — definisi produk `vibescore` → `/init` di repo kosong → CLAUDE.md + AGENTS.md + PRD. **End state `s1w1-end`.**

> 🎒 **Toolkit kumulatif s/d w1** *(fondasi — semua tanpa install)*
> - ★ **Loop:** Plan → Context → Task → Execute → Verify
> - ★ **CLAUDE.md** (primitive #1) + resep sehat ≤50 baris
> - ★ **Plan Mode** (`Shift+Tab` / `/plan`)
> - ★ **Built-ins:** `/init` `/context` `/compact` `/clear` `/memory` `/review`
> - ★ **Built-in agents:** Explore · Plan · general-purpose · claude-code-guide
> - ★ **Kontrol:** background `Ctrl+B` · todo `Ctrl+T` · thinking `Alt+T`
> - ★ **`/grademe` v0.1** (baseline skor)

🎯 **Challenge Besok Pagi** — `/init` di project kerja nyata → rapikan ≤50 baris → kerjakan 1 task lewat plan mode → jalankan `/grademe`, simpan skornya sebagai baseline. (`w01/exercise.md`)

---

### Minggu 2 — Skills: Ekosistem yang Sudah Matang &nbsp;&nbsp; 🟢
**Primitive #2: Skills** · *"Berhenti mengetik ulang prompt panjang yang sama."*

❓ **Konteks**
Kamu mengetik instruksi yang sama berulang: "review diff ini, cari bug, jangan ubah apa-apa". Itu tanda sebuah **skill** seharusnya ada. Kabar baiknya: ekosistemnya sudah matang — sebagian besar yang kamu butuhkan sudah dibuat orang lain dan sudah terpasang di CLI.

🎯 **Outcome** — setelah minggu ini kamu bisa:
- ☐ Membedakan CLAUDE.md (always-on) vs skill (on-demand) dan memilih yang tepat
- ☐ Memakai bundled skills: `/code-review`, `/verify`, `/simplify`
- ☐ Memasang skill komunitas dengan aman (audit dulu, baru install)
- ☐ Menjalankan `brainstorming` sampai spec matang sebelum satu baris kode ditulis

🔧 **Elemen**

| Elemen | Kapan pakai | Anti-pattern | → Dimensi |
|---|---|---|---|
| ★ **Anatomi SKILL.md** | Workflow berulang, prosedur bertahap | Menaruh prosedur panjang di CLAUDE.md (dibayar tiap sesi) | Context Quality · Efisiensi Token |
| ★ **`description` = trigger** | Ditulis untuk **mesin** yang memilih skill | Deskripsi puitis yang tak menyebut kapan dipakai | Delegasi & Tooling |
| ★ **Bundled skills** | `/code-review` cari bug · `/verify` buktikan jalan · `/simplify` bersihkan | Bilang "selesai" tanpa `/verify` | Verifikasi |
| ★ **superpowers** | Brainstorm → plan → execute → TDD → review | Loncat ke coding padahal spec belum jelas | Planning First · Task Decomposition |
| ★ **gstack picks** | `/investigate` root-cause · `/ship` · `/qa` | Menebak penyebab bug tanpa investigasi sistematis | Delegasi & Tooling · Verifikasi |
| ★ **caveman + ponytail** | Output prosa ringkas · kode minimal (YAGNI) | Membiarkan agent over-engineer | Efisiensi Token |
| ★ **Audit sebelum install** | **Selalu** — skill = instruksi yang dieksekusi di repomu | "Bintangnya banyak, pasti aman" | — |

**Ekosistem 4 lapis:** ① Built-in CLI (tanpa install) → ② Resmi Anthropic → ③ Komunitas battle-tested → ④ Internal Venturo (`/grademe`).

**9 tips authoring skill** (yang paling sering dilanggar): `description` adalah trigger, bukan judul · sediakan section **Gotchas** (bagian paling bernilai) · *progressive disclosure* — skill = folder, `SKILL.md` = hub, detail di file terpisah · **jangan mengekang** (*don't railroad*): beri Claude informasi, bukan skrip kaku.

🛠️ **Cara pakai**

Bundled skills — sudah ada, tanpa install:

```
/code-review [low|medium|high|xhigh|max|ultra] [--fix] [--comment] [target]
/verify                 # buktikan perubahan jalan: build + run + amati
/simplify [target]      # bersihkan over-engineering (cleanup-only, TIDAK cari bug)
/security-review        # audit kerentanan pada diff branch (dalami di w10)
```

Install skill komunitas (**terverifikasi 2026-07** — jalur lain sering keliru):

```bash
# superpowers — metodologi brainstorm→plan→TDD→review
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace

# ponytail — kode minimal (YAGNI ladder)
/plugin marketplace add DietrichGebert/ponytail
/plugin install ponytail@ponytail

# gstack — suite /investigate /ship /qa /review /health  (BUKAN lewat /plugin)
git clone --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack
cd ~/.claude/skills/gstack && ./setup

# caveman — output ringkas (±65% lebih hemat)
# pakai install script `curl` dari README resminya

# find-skills — cari skill di ekosistem
npx skills find "<query>"
```

Anatomi skill sendiri — `.claude/skills/<nama>/SKILL.md`:

```markdown
---
name: api-contract-check
description: Gunakan saat mengubah openapi.yaml atau handler HTTP, untuk memastikan
             kontrak FE↔BE tetap sinkron sebelum commit.
---

## Langkah
1. Baca `openapi.yaml`, bandingkan dengan handler di `internal/server/`.
2. ...

## Gotchas
- `openapi.yaml` adalah kontrak lintas-repo: mengubah shape = breaking change untuk FE.
```

> Skill personal: `~/.claude/skills/` · skill project (ikut di-commit): `.claude/skills/`.
> Custom command lama (`.claude/commands/deploy.md`) tetap jalan — kini setara skill `/deploy`.

**Prompt brainstorm yang benar** — minta beberapa arah untuk direaksikan, jangan minta satu jawaban:

```
/superpowers:brainstorming
Kita mau bikin halaman leaderboard. Jangan tulis kode dulu — ajukan pertanyaan
sampai spec-nya jelas, lalu tawarkan 3–4 arah desain yang berbeda.
```

🔨 **Live build** — `brainstorming` LIVE → plan → execute ringkas: skeleton `vibescore-api` (chi router, `/healthz`, kontrak `openapi.yaml`) → tutup dengan `/code-review` pada diff hasil build. **End state `s1w2-end`.**

> 🎒 **Toolkit kumulatif s/d w2**
> - Semua dari **w1**, plus:
> - ★ **Skills** (primitive #2) + anatomi SKILL.md + ekosistem 4 lapis
> - ★ **Bundled:** `/code-review` · `/verify` · `/simplify` · `/security-review`
> - ★ **superpowers:** `brainstorming` · `writing-plans` · `executing-plans`
> - ★ **gstack:** `/investigate` · `/ship` · `/qa` · `/review` · `/health`
> - ★ **Token economy:** caveman (`/caveman-stats`) · ponytail (YAGNI ladder)
> - ★ **find-skills** (`npx skills find`) untuk discovery

🎯 **Challenge Besok Pagi** — install superpowers + caveman → brainstorm 1 task nyata → pilih 1 skill dari katalog & pakai → catat bedanya + banding baseline skor w1. (`w02/exercise.md`)

---

### Minggu 3 — Subagents: Jaga Context Tetap Bersih &nbsp;&nbsp; 🟢
**Primitive #3: Subagents** · *"Sesi Claude makin lama makin bodoh karena context penuh sampah."*

❓ **Konteks**
Context adalah resource termahal. Tiap file yang dibaca **menetap** sampai sesi mati — inilah *context rot*. Subagent membaca 10 file di context **dia sendiri**, lalu mengembalikan 1 ringkasan; sesi utamamu tetap bersih. Ini cara **ketiga** menjaga context: bukan menyembuhkan (`/compact`, `/clear`), tapi **mencegah** sampah masuk.

🎯 **Outcome** — setelah minggu ini kamu bisa:
- ☐ Membuat subagent sendiri di `.claude/agents/` dengan tool paling sempit
- ☐ Memilih sadar antara subagent (cegah) · `/compact` (ringkas) · `/clear` (reset)
- ☐ Merutekan model: yang cepat untuk ekstraksi, yang terkuat untuk reasoning
- ☐ Menjalankan workflow lintas-repo tanpa FE membaca kode backend

🔧 **Elemen**

| Elemen | Kapan pakai | Anti-pattern | → Dimensi |
|---|---|---|---|
| ★ **Isolasi context** | Riset banyak file, hasil akhirnya cuma ringkasan | Membaca 20 file di main session | Efisiensi Token · Delegasi & Tooling |
| ★ **`.claude/agents/*.md`** | Worker yang sama dipanggil berulang | `tools:` dibiarkan luas padahal cuma perlu baca | Context Quality · Delegasi & Tooling |
| ★ **Model routing** | Ekstraksi → model cepat · review/test → model terkuat | Semua pakai model termahal (bakar uang) atau semua murah (review dangkal) | Efisiensi Token |
| ★ **Aturan main** | 1 arah (tugas masuk → 1 ringkasan keluar); tak mewarisi skill parent | Berharap subagent "ngobrol" bolak-balik | — |
| ★ **3 failure mode context penuh** | Sadari gejalanya | Menyalahkan model, bukan context | Verifikasi |
| ★ **`--add-dir`** | Baca repo tetangga (kontrak API) tanpa pindah folder | Copy-paste file antar repo | Context Quality |

**3 failure mode saat context penuh** — kenali gejalanya:
① *self-preferential bias* — Claude enggan menemukan kesalahan pada kode yang ia tulis sendiri (karena itu **verifier ≠ author**: pakai subagent terpisah untuk review).
② *goal drift* — tujuan awal memudar, terutama setelah kompaksi.
③ *agentic laziness* — jawaban makin dangkal, verifikasi dilewati.

🛠️ **Cara pakai**

Buat subagent — `.claude/agents/api-contract-reader.md`:

```markdown
---
name: api-contract-reader
description: Baca openapi.yaml dari repo tetangga dan kembalikan ringkasan kontrak
             (endpoint, request/response shape). Pakai saat FE butuh tahu kontrak BE.
tools: Read, Grep, Glob
model: sonnet
---

Kamu read-only. Baca `openapi.yaml`, ringkas tiap endpoint: method, path,
request body, response 2xx/4xx. Jangan menyarankan perubahan kode.
```

> `model:` menerima alias (`haiku`/`sonnet`/`opus`); tanpa field ini subagent mengikuti model sesi utama.
> **D3 model-agnostik:** pilih *tier*-nya (cepat vs terkuat), bukan nama modelnya. Nama model yang dipakai kelas ada di `_shared/versions.md`.
> `tools:` = pagar least-privilege — tool yang tak disebut **tidak bisa** dipakai.

Memanggilnya:

```
@api-contract-reader baca ../vibescore-api/openapi.yaml, ringkas kontrak /scores
```

@-mention menjamin subagent **itu** yang jalan. Tanpa @, Claude memilih sendiri berdasarkan `description`.
`/agents` sejak v2.1.198 **bukan UI interaktif** — minta Claude membuatkan, atau edit filenya langsung.

Lintas-repo & context hygiene:

```bash
claude --add-dir ../vibescore-api      # izinkan akses direktori lain
```

```
/compact fokus ke keputusan desain leaderboard    # ringkas, lanjut task yang sama
/clear                                            # buang total, ganti task
```

Turunkan ambang auto-compact bila sesi panjang (default kompaksi otomatis ±967K token):

```bash
export CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000
```

**3 subagent standar Venturo** (di `w03/assets/agents/` → nanti dibundel jadi plugin `venturo-standards` di w7):

| Subagent | Tier model | tools | Peran |
|---|---|---|---|
| `api-contract-reader` | cepat | Read, Grep, Glob | Baca `openapi.yaml` repo tetangga → ringkasan typed. **Kunci lintas-repo.** Read-only. |
| `code-reviewer` | terkuat | + Bash | Review diff: bug + standar Venturo. Lapor ter-rank, **tidak** nge-fix. |
| `test-writer` | terkuat | + Write, Edit, Bash | Tulis test konvensi repo, jalankan sampai hijau. Nemu bug → lapor, jangan tambal source. |

> ⚠️ **Teaser (D2):** subagent bisa dibatasi hak spawn-nya lewat `tools: Agent(worker)`. Subagent bersarang punya batasan yang belum terdokumentasi resmi — **verifikasi H-7** sebelum dipakai di kelas.

🔨 **Live build** — scaffold `vibescore-web` → `api-contract-reader` baca `openapi.yaml` repo BE → generate typed client + halaman Leaderboard + form submit → 2 subagent paralel (review + test). **End state `s1w3-end`.**

> 🎒 **Toolkit kumulatif s/d w3**
> - Semua dari **w1–w2**, plus:
> - ★ **Subagents** (primitive #3) + anatomi `.claude/agents/*.md` + aturan (1-arah, no-inherit)
> - ★ **Model routing:** tier cepat (grunt) vs tier terkuat (reasoning)
> - ★ **3 subagent standar:** `api-contract-reader` · `code-reviewer` · `test-writer`
> - ★ **Ladder context lengkap:** subagent (cegah) + `/compact` (ringkas) + `/clear` (reset)
> - ★ **`--add-dir`** lintas-repo · **`CLAUDE_CODE_AUTO_COMPACT_WINDOW`**

🎯 **Challenge Besok Pagi** — salin `code-reviewer` ke project kerja → review 1 PR/diff nyata → banding dengan review manualmu. (`w03/exercise.md`)

---

### Minggu 4 — BATTLE #1: "Speed Run Foundations" &nbsp;&nbsp; ⚔️
*Konsolidasi w1–w3. Tidak ada primitive baru.*

❓ **Konteks**
Semua yang kalian pelajari tiga minggu terakhir dipakai di bawah tekanan waktu. Bukan menguji hafalan command — menguji **proses**: apakah kamu tetap plan dulu saat dikejar waktu?

📋 **Format ujian**
60 menit di `battle-1-template` — fullstack mini 1 repo (Go chi API + FE statis vanilla, nol build step). `CLAUDE.md` **kosong** — wajib kamu isi dulu. Soal mini-fitur end-to-end di-reveal saat battle (tidak ada di repo).

| | |
|---|---|
| **Gate sah** (wajib, kalau tidak → diskualifikasi skor) | plan mode dipakai · ≥1 subagent · `CLAUDE.md` terisi |
| **Skor** | `/grademe` **60%** + checklist fitur/kualitas juri **40%** |
| **Checklist juri** | fitur jalan end-to-end (skrip verifikasi), test hijau, `openapi.yaml` diupdate |

🎯 **Yang diuji** — Planning First · Task Decomposition · Delegasi & Tooling · Verifikasi (4 dari 7 dimensi rubrik).

🛠️ **Cara pakai** — alur wajib peserta di akhir battle:

```bash
# 1. Jalankan /grademe di sesi battle-mu, simpan output JSON ke file
#    (di Claude Code: /grademe → salin blok JSON)
cat > <nama-kamu>.json          # tempel JSON /grademe, lalu Ctrl+D

# 2. Commit & push repo battle-mu
git add -A && git commit -m "battle 1" && git push
```

> Output `/grademe` **wajib disimpan sebagai file JSON** (bukan screenshot) — juri merekap ±80 peserta secara batch. Screenshot hanya bukti visual tambahan.

> 🎒 **Toolkit kumulatif s/d w4:** *tak bertambah* — battle menguji penguasaan w1–w3.

*Tak ada challenge baru: battle **adalah** ujiannya.* Cliffhanger: *"season depan, upload otomatis ke leaderboard yang kita bangun sendiri."*

---
### Minggu 5 — MCP: Colokan Universal ke Dunia Luar &nbsp;&nbsp; 🟢
**Primitive #4: MCP** · *"Berhenti klik-klik dashboard untuk hal yang bisa satu prompt."*

❓ **Konteks**
Claude pintar soal kode, tapi buta soal *sistemmu*: isi database, dokumentasi library versi terbaru, keadaan browser. MCP (Model Context Protocol) adalah standar yang menyambungkan Claude ke sistem itu — "USB-C-nya AI tooling". Bahayanya sama besar: satu koneksi salah ke production bisa merusak data sungguhan.

🎯 **Outcome** — setelah minggu ini kamu bisa:
- ☐ Memasang MCP server (remote OAuth & lokal stdio) dengan scope yang benar
- ☐ Membedakan kapan MCP perlu vs kapan CLI biasa / skill lebih murah
- ☐ Menjaga kredensial tidak pernah tampil di layar atau ter-commit
- ☐ Mengaudit tool bloat lewat `/context` dan mematikan MCP yang tak dipakai

🔧 **Elemen**

| Elemen | Kapan pakai | Anti-pattern | → Dimensi |
|---|---|---|---|
| ★ **Konsep MCP** | Sistem eksternal butuh protokol (OAuth, state, discovery) | Pakai MCP padahal `git`/`psql` di terminal sudah cukup | Delegasi & Tooling |
| ★ **Scope** `local`/`project`/`user` | `project` = `.mcp.json` di-commit untuk tim (tanpa secret) | Menaruh token di file yang ikut ter-commit | — |
| ★ **Supabase MCP** | Schema, migration, query, generate TS types | Konek ke database **production** | Delegasi & Tooling |
| ★ **Context7** | Docs library versi-akurat → bunuh halusinasi API usang | Percaya ingatan model soal API yang berubah | Context Quality |
| ★ **Playwright MCP** | Verifikasi UI lewat accessibility tree (dalami w7) | — | Verifikasi |
| ★ **GitHub MCP** | PR & issue lintas repo (dipakai battle 2) | — | Delegasi & Tooling |
| ★ **Tool bloat** | Aktifkan **3–5 MCP saja**, matikan sisanya | Semua server nyala; puluhan tool definition dibayar tiap sesi | Efisiensi Token |

**3 aturan keamanan MCP** (teaser w10): ① jangan pernah konek tulis ke **production** — selalu dev; ② scope sesempit mungkin (`read_only`, filter fitur); ③ review **tiap** tool call sebelum approve.

**Kapan JANGAN pakai MCP:** CLI biasa sudah cukup (git/gh/psql) → jangan. Butuh *prosedur* bukan *koneksi* → skill lebih murah (skill ±100 token; MCP server bisa ribuan).

🛠️ **Cara pakai**

Remote HTTP + OAuth (tanpa menempel token — cara yang dianjurkan):

```bash
claude mcp add --transport http supabase \
  "https://mcp.supabase.com/mcp?project_ref=<ref>&read_only=true"
```
Lalu di dalam sesi: `/mcp` → pilih server → **Authenticate** (OAuth di browser).

Server lokal (stdio) — perhatikan `--` sebelum command:

```bash
claude mcp add context7 -- npx -y @upstash/context7-mcp
claude mcp add playwright -- npx -y @playwright/mcp@latest
```

Scope — default `local` (privat, hanya kamu, project ini):

```bash
claude mcp add --scope project github -- npx -y @modelcontextprotocol/server-github
#   local   → privat, project ini (default)
#   project → tertulis di .mcp.json, ikut di-commit untuk tim
#   user    → berlaku di semua project milikmu
```

Bentuk `.mcp.json` (project scope — **tanpa secret**, pakai env var):

```json
{
  "mcpServers": {
    "supabase": {
      "type": "http",
      "url": "https://mcp.supabase.com/mcp?project_ref=<ref>&read_only=true"
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
```

Kelola & audit:

```bash
claude mcp list              # daftar server + status koneksi
claude mcp get supabase      # detail satu server
claude mcp remove supabase
```
```
/mcp                          # kelola koneksi & OAuth dari dalam sesi
/mcp disable playwright       # matikan sementara (hemat token)
/context                      # lihat porsi context yang dimakan tool MCP
```

> **Aturan kredensial kelas:** connection string & API key hidup di `.env` (yang di-`.gitignore`), tidak pernah ditempel ke chat, tidak pernah tampil di layar saat demo.

**Use case nyata di luar database:** MCP Slack — tempel thread bug, ketik `fix`, nol context switching. `bq` (BigQuery) untuk analitik — jembatan ke sesi analisa data di w11.

🔨 **Live build** — migrasi `vibescore-api` dari in-memory → Supabase Postgres: interface `Store` + `PgStore` (pgx pgxpool) + fallback `MemStore`. Kontrak `openapi.yaml` **tidak berubah** (framing project existing: ganti storage tanpa mengganggu konsumen API). **End state `s2w5-end`** — data persisten, restart tak menghapus apa pun.

> 🎒 **Toolkit kumulatif s/d w5** *(+ primitive #4)*
> - Semua dari **w1–w4**, plus:
> - ★ **MCP** (primitive #4) + `claude mcp add` + scope local/project/user + `.mcp.json`
> - ★ **4 MCP:** Supabase · Context7 · Playwright (teaser) · GitHub
> - ★ **Disiplin token:** audit tool bloat lewat `/context`, aktif 3–5 saja

🎯 **Challenge Besok Pagi** — pasang Context7 di project kerja; tanyakan hal yang sama ke Claude **dengan** dan **tanpa** Context7, banding jawabannya. (`w05/exercise.md`)

---

### Minggu 6 — Hooks: Aturan yang Menegakkan Dirinya &nbsp;&nbsp; 📝
**Primitive #5: Hooks** · *"CLAUDE.md bisa dilupakan model. Hook tidak bisa."*

❓ **Konteks**
Kamu sudah menulis "JANGAN sentuh `.env`" di CLAUDE.md — dan sesekali Claude tetap menyentuhnya. CLAUDE.md adalah **saran**; model boleh lupa. Hook adalah **penegakan**: command yang dijalankan Claude Code sendiri di titik lifecycle tertentu, deterministik, tidak bisa dibujuk.

🎯 **Outcome** — setelah minggu ini kamu bisa:
- ☐ Memblokir aksi berbahaya (edit `.env`, `rm -rf`) secara deterministik
- ☐ Memasang quality gate: lint + test otomatis tiap file disentuh
- ☐ Membaca peta lifecycle event dan memilih event yang tepat
- ☐ Menyambungkan `/grademe --upload` ke leaderboard yang kalian bangun sendiri

🔧 **Elemen**

| Elemen | Kapan pakai | Anti-pattern | → Dimensi |
|---|---|---|---|
| ★ **Hook vs CLAUDE.md** | Aturan yang **tidak boleh** dilanggar → hook | Menulis larangan keras di CLAUDE.md lalu berharap | Context Quality |
| ★ **PreToolUse** | Guard: blokir sebelum aksi terjadi | Membersihkan kerusakan setelah kejadian | Verifikasi |
| ★ **PostToolUse** | Quality gate: lint + test tiap edit | Menunggu CI menemukan lint error 20 menit kemudian | Verifikasi |
| ★ **Stop** | Notifikasi "Claude selesai" (sound/Slack) | Menatap layar menunggu | — |
| ★ **PostCompact** | Re-inject instruksi kritis setelah kompaksi | Heran kenapa Claude "lupa aturan" di sesi panjang | Context Quality |
| ★ **SessionStart** | Bootstrap konteks tiap sesi (dipakai superpowers & caveman) | — | Delegasi & Tooling |
| ★ **`caveman-compress`** | Pangkas CLAUDE.md → hemat input token tiap sesi | CLAUDE.md gemuk dibayar selamanya | Efisiensi Token |

**Peta lifecycle event** (yang resmi, jauh lebih luas dari yang dipakai kelas):

| Kelompok | Event |
|---|---|
| Sesi | `SessionStart` · `Setup` · `SessionEnd` |
| Per-turn | `UserPromptSubmit` · `Stop` · `StopFailure` |
| Loop agentik | `PreToolUse` · `PostToolUse` · `PostToolUseFailure` · `PermissionRequest` · `PermissionDenied` |
| Subagent & team | `SubagentStart` · `SubagentStop` · `TeammateIdle` · `TaskCreated` · `TaskCompleted` |
| Kompaksi | `PreCompact` · `PostCompact` |
| File & config | `FileChanged` · `ConfigChange` · `InstructionsLoaded` |

Yang **kita pakai** di kelas: `PreToolUse`, `PostToolUse`, `Stop`, `SessionStart`, `PostCompact`.

🛠️ **Cara pakai**

Lokasi file: `.claude/settings.json` (project, **ikut di-commit**) · `.claude/settings.local.json` (privat, di-gitignore) · `~/.claude/settings.json` (semua project).

**Guard — blokir Edit/Write ke `.env`** (`PreToolUse` + exit code 2 = blocking):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [{ "type": "command", "command": ".claude/hooks/guard-env.sh" }]
      }
    ]
  }
}
```

```bash
#!/bin/bash
# .claude/hooks/guard-env.sh — hook menerima JSON lewat stdin
FILE=$(jq -r '.tool_input.file_path')
if [[ "$FILE" == *.env* ]]; then
  echo "Ditolak: .env tidak boleh disentuh Claude." >&2
  exit 2          # exit 2 = blocking error; stderr dikirim balik ke Claude
fi
exit 0            # exit 0 = lanjut ke alur izin normal
```

**Quality gate — lint + test tiap file Go diedit** (`PostToolUse`):

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [{
          "type": "command",
          "command": "golangci-lint run ./... && go test ./...",
          "timeout": 180,
          "statusMessage": "Lint + test..."
        }]
      }
    ]
  }
}
```

**Notifikasi selesai** (`Stop`) dan **re-inject aturan pasca-kompaksi** (`PostCompact`):

```json
{
  "hooks": {
    "Stop": [
      { "hooks": [{ "type": "command", "command": "afplay /System/Library/Sounds/Glass.aiff" }] }
    ],
    "PostCompact": [
      { "hooks": [{ "type": "command", "command": "cat .claude/aturan-kritis.md" }] }
    ]
  }
}
```

> **Exit code:** `0` = sukses (stdout diproses) · `2` = **blocking**, stderr dibaca Claude sebagai error · lainnya = non-blocking.
> Cara uji: jalankan `/hooks` untuk melihat konfigurasi aktif, lalu minta Claude melakukan aksi yang seharusnya diblokir.

**Starter pack hooks Venturo** (dibagikan siap pakai): guard `.env` · guard `rm -rf` & `git push --force` · quality gate Go (`golangci-lint` + `go test`) · quality gate TS (`eslint` + `vitest`) · notifikasi `Stop` · audit log Bash.

🔨 **Live build** — fitur upload otomatis: `POST /scores` menerima JSON `/grademe` + validasi schema + **auth API key per peserta**; rilis **`/grademe` v0.2 flag `--upload`**; pasang starter hooks di kedua repo. **End state `s2w6-end`** — pipeline `/grademe` → leaderboard tersambung.

> 🎒 **Toolkit kumulatif s/d w6** *(+ primitive #5)*
> - Semua dari **w1–w5**, plus:
> - ★ **Hooks** (primitive #5) + peta lifecycle event + `matcher` + exit code 2
> - ★ **Starter pack hooks Venturo** (guard · quality gate · notif · audit log)
> - ★ **`PostCompact`** re-inject aturan kritis
> - ★ **`/grademe` v0.2** (`--upload`) + `caveman-compress`

🎯 **Challenge Besok Pagi** — pasang 1 hook guard + 1 hook quality gate di project kerja (file `settings.json` disediakan).

---

### Minggu 7 — Plugins, Design Pass & Shipping &nbsp;&nbsp; 📝
**Primitive #6: Plugins** · *"Onboarding developer baru = satu perintah, bukan setengah hari setup."*

❓ **Konteks**
Enam minggu ini kalian mengumpulkan aset: subagent standar, hooks, konfigurasi MCP. Sekarang semuanya masih tersebar di folder masing-masing. Plugin membungkusnya jadi **satu unit installable** — developer baru mengetik satu perintah dan langsung punya standar tim.

🎯 **Outcome** — setelah minggu ini kamu bisa:
- ☐ Membungkus skill + hook + subagent + MCP jadi satu plugin
- ☐ Mempublikasikan lewat marketplace internal & mengaudit plugin sebelum install
- ☐ Melakukan design pass yang hasilnya tidak terlihat "generik AI"
- ☐ Men-deploy FE + BE dan memverifikasi lewat browser sungguhan

🔧 **Elemen**

| Elemen | Kapan pakai | Anti-pattern | → Dimensi |
|---|---|---|---|
| ★ **Anatomi plugin** | Aset dipakai >1 orang | Copy-paste folder `.claude/` antar repo | Dokumentasi |
| ★ **Marketplace** | Distribusi ke tim | Install plugin tanpa membaca isinya | — |
| ★ **Audit sebelum install** | **Selalu** — plugin bawa hooks & MCP yang jalan otomatis | "Ini dari internal, pasti aman" | — |
| ★ **frontend-design / ui-ux-pro-max** | Design pass halaman nyata | Menerima tampilan default AI apa adanya | Dokumentasi |
| ★ **Verifikasi FE di browser** | Buktikan UI benar-benar jalan | "Kelihatannya benar" dari membaca kode | Verifikasi |
| ★ **Deploy** | Ship ke URL production | Selesai = merge, bukan = jalan di production | Verifikasi |

🛠️ **Cara pakai**

Struktur folder plugin (direktori komponen ada di **root plugin**, bukan di dalam `.claude-plugin/`):

```
venturo-standards/
├── .claude-plugin/
│   └── plugin.json          # manifest: name, description, version, author
├── skills/                  # skill tim
├── agents/                  # 3 subagent standar (w3)
├── hooks/                   # starter pack hooks (w6)
└── .mcp.json                # MCP default tim (tanpa secret)
```

Dev loop → publish:

```bash
claude --plugin-dir ./venturo-standards      # muat plugin lokal untuk dites
claude plugin validate ./venturo-standards   # cek manifest sebelum publish
```

```bash
claude plugin marketplace add <owner>/<repo>       # daftarkan marketplace
claude plugin install venturo-standards@venturo-tools
claude plugin list
claude plugin details venturo-standards           # inventaris komponen + perkiraan biaya token
claude plugin uninstall venturo-standards
```

Verifikasi sebelum ship — rantai yang dipakai:

```
/verify          # buktikan perubahan jalan (build + run + amati)
/simplify        # bersihkan over-engineering sebelum PR
/ship            # (gstack) test → review → changelog → PR
```

> ⚠️ Kalau kalian membaca soal command `/go` yang merangkai verify→simplify→ship di tulisan lain: **command itu tidak ada** di Claude Code per 2026-07-09. Pakai rantai tiga command di atas.

Verifikasi tampilan FE: **Playwright MCP** (accessibility tree) atau **Claude in Chrome** (`claude --chrome`) — mengamati halaman sungguhan alih-alih menebak dari kode. ⚠️ verifikasi H-7.

🔨 **Live build** — **A:** bundel aset s1–s2 → plugin `venturo-standards` v1.0, PR ke marketplace `venturo-tools`. **B:** design pass halaman leaderboard. **C:** deploy FE + BE ke Vercel. **End state `s2w7-end`** + URL production.

> 🎒 **Toolkit kumulatif s/d w7** *(+ primitive #6)*
> - Semua dari **w1–w6**, plus:
> - ★ **Plugins** (primitive #6) + marketplace + `claude plugin validate`
> - ★ **Plugin `venturo-standards` v1.0** (subagent + hooks + `.mcp.json` bundel)
> - ★ **Design:** frontend-design + ui-ux-pro-max
> - ★ **Deploy:** verifikasi browser (Playwright MCP / Claude in Chrome) + Vercel → leaderboard LIVE

🎯 **Challenge Besok Pagi** — design pass 1 halaman project kerja di branch terpisah → screenshot before/after.

---

### Minggu 8 — BATTLE #2: "Bug Hunt" &nbsp;&nbsp; ⚔️
*Konsolidasi w1–w7.*

❓ **Konteks**
Kali ini kodenya sudah ada — dan ada yang salah di dalamnya. Menemukan bug orang lain menguji hal yang berbeda dari menulis fitur: kemampuan **menyelidiki secara sistematis** alih-alih menebak, dan **membuktikan** perbaikan benar-benar bekerja.

📋 **Format ujian**
60 menit di `battle-2-template` — sejumlah bug sengaja ditanam di kode yang sudah jalan. Jumlah & jenis bug di-reveal saat battle dimulai (tidak ada di repo maupun silabus). Tugasmu: temukan, perbaiki, **buktikan**.

| | |
|---|---|
| **Gate sah** | ≥1 subagent · ≥1 MCP · hooks aktif |
| **Skor** | `/grademe` **60%** + bug valid yang diperbaiki **40%** |
| **Payoff** 🎉 | `/grademe --upload` → skormu **masuk leaderboard production otomatis** — pipeline yang kalian bangun sendiri di w6 |

🎯 **Yang diuji** — Verifikasi · Delegasi & Tooling · Context Quality. Review otomatis (`/code-review` menjalankan beberapa agent sekaligus) sering menemukan bug yang mata manusia lewatkan — pakai itu, tapi buktikan temuannya.

🛠️ **Cara pakai**

```
/investigate    # (gstack) debugging root-cause sistematis, bukan tebak-tebakan
/code-review high    # cari bug di diff
/verify              # buktikan perbaikan jalan end-to-end
/grademe --upload    # skor langsung ke leaderboard
```

> 🎒 **Toolkit kumulatif s/d w8:** *tak bertambah* — menguji penguasaan w1–w7 (subagent + MCP + hooks).

---
### Minggu 9 — Agent Teams: Satu Lead, Banyak Tangan &nbsp;&nbsp; 📝
**Primitive #7: Agent Teams** · *"Fitur full-stack tak harus dikerjakan serial."*

> ⚠️ **Status: EXPERIMENTAL, disabled by default.** Perilaku, syarat versi, dan default mode bergerak cepat. **Wajib re-verifikasi H-7 & H-1.** Ini demo paling berisiko sepanjang kurikulum — bukti statis per fase disiapkan sebagai cadangan.

❓ **Konteks**
Subagent berguna, tapi komunikasinya **satu arah**: tugas masuk, ringkasan keluar, tidak ada percakapan. Untuk pekerjaan di mana beberapa pekerja perlu saling mendebat temuan — misalnya menyelidiki bug dengan hipotesis yang bersaing — kamu butuh sesi yang bisa saling berkirim pesan. Itulah Agent Teams. Harganya: token berlipat.

🎯 **Outcome** — setelah minggu ini kamu bisa:
- ☐ Menjelaskan beda subagent (1 arah) vs agent team (2 arah) dan memilih dengan sadar
- ☐ Menjalankan tim 3–5 teammate untuk review/investigasi paralel
- ☐ Menjawab jujur: **kapan teams overkill** (jawabannya: sering)
- ☐ Mengenali fitur otonomi lain dan tahu kapan tidak memakainya

🔧 **Elemen**

| Elemen | Kapan pakai | Anti-pattern | → Dimensi |
|---|---|---|---|
| ★ **Subagents vs Teams** | Teammate perlu saling kirim pesan & berdebat | Pakai team untuk task sekuensial (buang token) | Delegasi & Tooling |
| ★ **Lead orchestrator** | Main session = lead; teammate kerja mandiri | Lead ikut ngoding sambil mengoordinasi | Task Decomposition |
| ★ **Shared task list** | Teammate self-claim task, dependency otomatis | Membagi tugas manual lewat chat | Task Decomposition |
| ★ **Model & permission** | Teammate **tidak** mewarisi `/model` lead | Mengira `/model` lead berlaku ke semua | Efisiensi Token |
| ★ **Failure modes** | Konflik temuan → rekonsiliasi / opini ketiga | Percaya konsensus tim tanpa verifikasi | Verifikasi |
| ★ **`/statusline`** | Monitor context/token real-time | — | Efisiensi Token |

**Kapan teams overkill?** Untuk task berurutan, edit file yang sama, atau pekerjaan dengan banyak dependency — **satu sesi atau subagent lebih efektif**. Kekuatan teams: riset, review paralel, dan debugging dengan hipotesis bersaing.

🛠️ **Cara pakai**

Aktifkan (disabled by default) — di `~/.claude/settings.json` atau environment:

```json
{ "env": { "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1" } }
```

Spawn teammate lewat **bahasa natural** — tidak ada command khusus:

```
Spawn tiga teammate untuk mereview PR #142:
- satu fokus keamanan
- satu fokus performa
- satu memvalidasi test coverage
Suruh mereka saling menantang temuan, lalu rangkum konsensusnya.
```

> `TeamCreate`/`TeamDelete` **sudah dihapus** — cukup minta dalam bahasa natural; cleanup otomatis saat sesi berakhir.
> **Model teammate**: set di `/config` → "Default teammate model" (teammate **tidak** ikut `/model` lead).
> Tampilan: `teammateMode` = `in-process` (default, terminal biasa) atau split pane (butuh tmux/iTerm2) — `claude --teammate-mode auto`.
> Kirim pesan langsung ke teammate: pilih di panel agent (↑/↓) lalu `Enter`. Batas sehat: **3–5 teammate**.

Quality gate lewat hook (exit code 2 = tolak + kirim feedback):

```
TeammateIdle    → teammate mau berhenti padahal kerjaan belum beres
TaskCreated     → cegah task yang tak sesuai standar dibuat
TaskCompleted   → cegah task ditandai selesai tanpa bukti
```

⚠️ **Teaser fitur otonomi (D2 — konsep + cara pakai, bukan tuntutan):**

```
/goal <kondisi>        # Claude terus bekerja lintas turn sampai kondisi tercapai
claude agents          # kelola background agent (agent view); mulai: claude --bg
/loop [interval] [prompt]   # ulangi prompt selama sesi terbuka
/schedule <deskripsi>       # routine terjadwal di infrastruktur cloud Anthropic
```

Keterbatasan yang perlu kamu tahu: **tidak ada nested team** (teammate tak bisa spawn teammate) · lead tetap lead seumur sesi · `/resume` & `/rewind` tidak memulihkan in-process teammate.

🔨 **Live build** — fitur lintas-layer dikerjakan 3 teammate paralel (FE, BE, test). **End state `s3w9-end`.**

> 🎒 **Toolkit kumulatif s/d w9** *(+ primitive #7 — LENGKAP 7/7)*
> - Semua dari **w1–w8**, plus:
> - ★ **Agent Teams** (primitive #7, ⚠️ experimental) + komunikasi 2 arah + shared task list
> - ★ **Statusline custom** · hook `TeammateIdle`/`TaskCreated`/`TaskCompleted`
> - ★ **Teaser otonomi:** `/goal` · `claude agents` · `/loop` · `/schedule`
> - ★ **7 primitives lengkap** — mental model utuh

🎯 **Challenge Besok Pagi** — ambil 1 task nyata, tentukan layer yang tepat (skill / subagent / team) **beserta alasannya**. Kalau jawabannya "subagent", kamu sudah paham materinya.

---

### Minggu 10 — Security Handling: Vibe Coding yang Tidak Bocor &nbsp;&nbsp; 📝
*Pendalaman — bukan primitive baru.*

❓ **Konteks**
Delapan minggu terakhir kalian meng-install skill, plugin, dan MCP dari internet. Sudah ada yang membaca isinya? Skill adalah **instruksi yang dieksekusi dengan akses ke repo kalian**. Dan data yang dibaca Claude — baris database, isi issue, halaman web — bisa berisi instruksi jahat. *Data adalah kode yang berjalan.*

🎯 **Outcome** — setelah minggu ini kamu bisa:
- ☐ Mengaudit skill/plugin sebelum install (dan tahu apa yang dicari)
- ☐ Menyusun `permissions.allow/deny` yang masuk akal untuk timmu
- ☐ Mengenali serangan prompt injection dan menerapkan pola karantina
- ☐ Menjalankan `/security-review` sebagai bagian rutin sebelum merge

🔧 **Elemen**

| Elemen | Kapan pakai | Anti-pattern | → Dimensi |
|---|---|---|---|
| ★ **Secrets** | Hook guard `.env`; kredensial lewat env var | Paste credential ke chat "sebentar saja" | Context Quality |
| ★ **Supply chain** | Audit isi skill/plugin + pin versi | Install karena bintangnya banyak | — |
| ★ **Permission model** | Allowlist command aman, deny yang berbahaya | Membiasakan `--dangerously-skip-permissions` | — |
| ★ **Prompt injection** | Data eksternal = tidak tepercaya | Membiarkan agent yang membaca data untrusted punya hak tulis | Verifikasi |
| ★ **Pola karantina** | Pisahkan pembaca data dari pelaku aksi | Satu agent membaca isu publik **dan** boleh push | Delegasi & Tooling |
| ★ **`/security-review`** | Sebelum merge, tiap kali | Menunggu security review manual di akhir kuartal | Verifikasi |

🛠️ **Cara pakai**

Kurangi prompt izin **tanpa** mematikan pengamanan — scan transcript, usulkan allowlist:

```
/fewer-permission-prompts
```

Aturan izin di `.claude/settings.json` — format `Tool(pola)`:

```json
{
  "permissions": {
    "allow": ["Bash(go test:*)", "Bash(git status)", "Read(~/.zshrc)"],
    "deny":  ["Bash(curl:*)", "Read(./.env)", "Read(./.env.*)", "Read(./secrets/**)"],
    "defaultMode": "acceptEdits"
  }
}
```

> **Deny selalu menang**, di mode apa pun. Path terproteksi (`.git`, `.claude`, `.mcp.json`, `.zshrc`, …) tidak pernah auto-approve — bahkan dengan allow rule.

Isolasi filesystem & network untuk Bash:

```
/sandbox          # toggle sandbox mode (tersedia di platform tertentu)
```

Audit sebelum merge & sebelum install:

```
/security-review                    # analisa diff branch: injection, auth, data exposure
```
```bash
claude plugin details <plugin>      # lihat komponen plugin + biaya token sebelum percaya
```

**Pola karantina** (aturan, bukan command): agent yang membaca konten **untrusted** (isu publik, halaman web, baris DB) **tidak boleh** punya tool berhak tinggi. Pisahkan: subagent read-only merangkum → main session yang bertindak.

⚠️ **Auto mode & classifier (teaser D1/D2).** Auto mode (research preview) menjalankan classifier terpisah yang memblokir aksi berisiko — mengunduh & mengeksekusi kode, deploy production, force push, mengirim data sensitif keluar. Argumennya jujur: *auto mode lebih aman daripada menekan "approve" 99 kali membabi buta.* Tapi ia **bukan** pengganti review pada operasi sensitif, dan ketersediaannya bergantung plan & model (verifikasi H-7). **Plan mode tetap alat utama kita (D1).**

```bash
claude auto-mode defaults     # lihat daftar aksi yang diblokir classifier
```

🔨 **Live build** — hardening: rate limit, hashing API key, RLS ketat, input validation → **`venturo-standards` v1.1** + subagent `security-auditor`. **End state `s3w10-end`.**

> 🎒 **Toolkit kumulatif s/d w10**
> - Semua dari **w1–w9**, plus:
> - ★ **`/security-review`** rutin + subagent `security-auditor`
> - ★ **Permission model:** `permissions.allow/deny` · `/fewer-permission-prompts` · `/sandbox`
> - ★ **Pola karantina** + audit supply chain
> - ★ **`venturo-standards` v1.1** (+security)

🎯 **Challenge Besok Pagi** — audit 1 skill/plugin yang sudah kamu install: baca `SKILL.md` dan hooks-nya. Temukan satu hal yang membuatmu tidak nyaman.

---

### Minggu 11 — Token Economy & Second Brain &nbsp;&nbsp; 📝
*Sistematisasi — menyatukan semua tips corner jadi peta utuh.*

❓ **Konteks**
Tiap sesi baru, Claude membaca ulang repo dari nol — kalian membayar tokennya setiap hari. Sampai sekarang tips hemat token datang sepotong-sepotong. Minggu ini kita susun jadi satu peta: input, output, memory, tooling, disiplin. Dan satu kebiasaan yang paling sering dilewatkan: **mundur lebih murah daripada mengoreksi**.

🎯 **Outcome** — setelah minggu ini kamu bisa:
- ☐ Menyebut 5 layer penghematan token dan memilih yang tepat untuk situasimu
- ☐ Mengganti kebiasaan "mengoreksi lewat chat" dengan `/rewind` + re-prompt
- ☐ Membangun second brain yang membuat Claude ingat keputusan tim
- ☐ Memakai Claude Code untuk pekerjaan non-coding (analisa data)

🔧 **Elemen**

| Elemen | Kapan pakai | Anti-pattern | → Dimensi |
|---|---|---|---|
| ★ **Rewind > correcting** | Claude salah arah → mundur, perbaiki prompt | Mengoreksi lewat chat (jejak salah tetap di context) | Efisiensi Token |
| ★ **4 Unknowns** | Sebelum task besar: petakan yang kamu tak tahu | Mulai coding dengan asumsi tak teruji | Planning First |
| ★ **Context minimalism** | Beri *goal*, bukan micro-step | Minimal ≠ vague — jangan pelit informasi | Context Quality |
| ★ **graphify** | Codebase besar (ratusan file) | Overkill untuk project <30 file — jujur saja | Efisiensi Token · Context Quality |
| ★ **Second brain (Obsidian)** | Keputusan tim yang berumur panjang | Menaruh semuanya di CLAUDE.md sampai gemuk | Dokumentasi |
| ★ **Non-coding** | Analisa data, rekap, riset | Membuka spreadsheet manual untuk hal berulang | Delegasi & Tooling |

**Peta 5 layer token economy:**

| Layer | Alat | Kapan efektif |
|---|---|---|
| Input (repo) | graphify — knowledge graph codebase | Codebase besar; overkill di project kecil |
| Output | caveman (prosa ringkas) · ponytail (kode minimal) | Sesi panjang · agent suka over-engineer |
| Memory | `caveman-compress` untuk CLAUDE.md | CLAUDE.md dibayar **tiap** sesi |
| Tooling | MCP seperlunya · skill > MCP bila bisa · model routing | Skill ±100 token vs MCP ribuan |
| Disiplin | plan dulu · `/compact` & `/clear` tepat waktu · `/rewind` | **Selalu** — retry adalah pemborosan terbesar |

**4 Unknowns** — petakan sebelum mulai: *known-known* (sudah pasti) · *known-unknown* (tahu belum tahu → riset) · *unknown-known* (tim tahu, kamu belum → tanya) · *unknown-unknown* (blind spot → minta Claude mewawancaraimu satu pertanyaan pada satu waktu).

🛠️ **Cara pakai**

**Mundur, jangan mengoreksi.** Koreksi lewat chat meninggalkan jejak salah di context — dan Claude tetap "melihat" jalan buntu itu sampai sesi mati:

```
/rewind          # kembalikan percakapan dan/atau kode ke checkpoint sebelumnya
                 # (alias: /checkpoint, /undo). Bisa juga "summarize from here"
                 # untuk memotong sesi jadi handoff message yang bersih.
```

Disiplin context:

```
/context                       # audit: siapa memakan window-mu?
/compact <fokus ringkasan>     # ringkas terarah, lanjut task sama
/clear                         # ganti task = mulai bersih
export CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000   # kompaksi otomatis lebih awal
```

Knowledge graph untuk codebase besar:

```bash
uv tool install graphifyy        # nama package: graphifyy (double-y)
graphify install
```
```
/graphify   # lalu tanyakan arsitektur ke graph, jangan baca ulang file
```

Non-coding & pekerjaan berulang:

```
/loop 30m rekap progres tim dari commit hari ini    # berulang selama sesi terbuka
/schedule rekap mingguan tiap Jumat 17:00           # routine cloud (⚠️ cek ketersediaan)
```

**Second brain (Obsidian)** — vault = folder markdown biasa yang bisa dibaca Claude langsung. Struktur yang dipakai: `decisions/` · `meetings/` · `knowledge/`. Aturan penempatan:

| Simpan di | Isinya |
|---|---|
| `CLAUDE.md` | Aturan yang dibutuhkan **tiap** task (≤50 baris) |
| Vault | Keputusan, notulen, pengetahuan berumur panjang |
| `/memory` (auto-memory) | Preferensimu yang ditemukan Claude sendiri lintas sesi |

🔨 **Live build** — dashboard insight leaderboard (agregat per dimensi rubrik, tren tim, top movers) dari dataset 10 minggu yang dibekukan. **End state `s3w11-end`** — leaderboard lengkap.

> 🎒 **Toolkit kumulatif s/d w11**
> - Semua dari **w1–w10**, plus:
> - ★ **`/rewind`** — rewind-over-correcting
> - ★ **4 Unknowns** + context minimalism ("minimal ≠ vague")
> - ★ **graphify** (knowledge graph codebase, `/graphify`)
> - ★ **Second brain:** vault Obsidian (decisions / meetings / knowledge) + auto-memory
> - ★ **Peta token economy utuh** (input · output · memory · tooling · disiplin)
> - ★ **Non-coding:** analisa data · `/loop` · `/schedule`

🎯 **Challenge Besok Pagi** — pilih 1 teknik token economy, pasang di project kerja, catat penghematannya. Ganti satu kebiasaan mengoreksi dengan `/rewind`.

---

### Minggu 12 — BATTLE FINAL: "Full Stack Showdown" &nbsp;&nbsp; ⚔️
*Konsolidasi total.*

❓ **Konteks**
Dua belas minggu, tujuh primitive, satu leaderboard yang kalian bangun sendiri. Battle terakhir bukan soal siapa paling cepat mengetik — soal siapa yang paling **sadar memilih alat**.

📋 **Format ujian**
75 menit, fitur lengkap: FE + BE + test + docs + deploy preview. **Semua senjata boleh**, dengan bonus poin untuk pemakaian yang tepat guna (bukan pemakaian terbanyak).

| | |
|---|---|
| **Skor** | `/grademe --upload` **50%** + kelengkapan fitur **30%** + juri **20%** |
| **Elemen juri** | *quiz-before-merge* — kamu harus bisa **menjelaskan diff-mu sendiri** sebelum dianggap selesai |
| **Bonus** | Pemakaian fitur otonomi berskala kecil & beralasan (D2) |
| **Penutup** | Crowning **Vibe Coding Champion** dari leaderboard kumulatif + retrospektif + voting arah season berikutnya |

🎯 **Yang diuji** — ketujuh dimensi rubrik sekaligus.

🛠️ **Cara pakai**

```
/grademe --upload      # skor langsung ke leaderboard production
```

Sebelum bilang "selesai", tanya dirimu (dan juri akan menanyakannya): *"Bisakah aku menjelaskan setiap baris diff ini dan kenapa ia ada?"* Kalau tidak — kamu belum selesai, kamu baru punya kode.

> 🎒 **Toolkit LENGKAP & PENUH** — 7 primitives + loop inti + seluruh ekosistem skill/MCP/hook/plugin + token economy + security. Inilah silabus yang "lengkap dan penuh".

---
## Apendiks A — Kamus Elemen (referensi cepat)

> Kolom **Mg** = minggu perkenalan. Semua klaim diverifikasi ke docs resmi + CLI aktual (2026-07-09) kecuali ditandai **⚠️**.

### A.1 Tujuh Primitives

| Primitive | Mg | Fungsi 1-baris |
|---|---|---|
| CLAUDE.md | 1 | Konteks always-on tiap session |
| Skills | 2 | Instruksi terpaket on-demand |
| Subagents | 3 | Worker terisolasi, komunikasi 1 arah |
| MCP | 5 | Tool surface ke sistem eksternal |
| Hooks | 6 | Kontrol deterministik di lifecycle |
| Plugins | 7 | Bundel installable + distribusi |
| Agent Teams | 9 | Session paralel, komunikasi 2 arah (⚠️ experimental) |

### A.2 Built-in CLI, command & bundled skills

| Elemen | Mg | Fungsi | Catatan |
|---|---|---|---|
| Plan Mode | 1 | Rencana read-only sebelum eksekusi | `Shift+Tab` cycle SEMUA permission mode · `/plan [deskripsi]` · `claude --permission-mode plan` |
| `/init` | 1 | Generate CLAUDE.md dari repo | ✅ |
| `/context [all]` | 1 | Audit context window (grid berwarna) | ✅ |
| `/compact [instruksi]` | 1 | Ringkas percakapan, lanjut task sama | ✅ menerima hint fokus |
| `/clear [nama]` | 1 | Buang context, mulai task baru | ✅ |
| `/memory` | 1 | Edit CLAUDE.md + kelola auto-memory | ✅ |
| `/review [PR]` | 1 | Review **GitHub PR** (single-pass) | ✅ diff lokal → `/code-review` |
| `/code-review` | 2 | Cari bug + cleanup di diff lokal | ✅ level `low…max`/`ultra`, `--fix`, `--comment` |
| `/verify` | 2 | Buktikan perubahan jalan end-to-end | ✅ bundled skill |
| `/simplify [target]` | 2 | Bersihkan over-engineering (cleanup-only) | ✅ TIDAK cari bug |
| `/security-review` | 2,10 | Audit kerentanan di diff branch | ✅ **built-in command** |
| Explore · Plan · general-purpose · claude-code-guide | 1 | Built-in agents | ✅ plan mode pakai **Plan** (bukan Explore) |
| Background `Ctrl+B` · todo `Ctrl+T` · thinking `Alt+T` | 1 | Kontrol sesi | ✅ |
| `--add-dir <dir>` | 3 | Akses direktori/repo lain | ✅ |
| ★ `CLAUDE_CODE_AUTO_COMPACT_WINDOW` | 3,11 | Ambang auto-compact (default ±967K token) | ✅ env var |
| `/agents` `/hooks` `/mcp` `/plugin` | 3,5–7 | Kelola tiap primitive | ⚠️ `/agents` sejak v2.1.198 **bukan UI interaktif** |
| ★ `/fewer-permission-prompts` | 10 | Scan transcript → usulkan allowlist aman | ✅ bundled skill |
| ★ `/sandbox` | 10 | Toggle sandbox mode (isolasi file/network) | ✅ platform tertentu |
| ★ `claude auto-mode [defaults]` | 10 | Inspeksi classifier auto mode | ⚠️ auto mode = **research preview**, syarat plan & model |
| ★ `/rewind` | 11 | Mundurkan percakapan/kode ke checkpoint | ✅ alias `/checkpoint`, `/undo` |
| ★ `/goal [kondisi\|clear]` | 9 | Claude lanjut lintas turn sampai kondisi tercapai | ⚠️ D2 teaser |
| ★ `claude agents` · `claude --bg` | 9 | Kelola background agent (agent view) | ⚠️ D2 teaser |
| `/loop [interval] [prompt]` | 11 | Ulangi prompt selama sesi terbuka | ✅ |
| `/schedule [deskripsi]` | 11 | Routine terjadwal di cloud Anthropic | ⚠️ cek ketersediaan H-7 |
| `/statusline` | 9 | Monitor context/token real-time | ✅ |
| ★ Nested subagents | 3,9 | Subagent membatasi spawn via `tools: Agent(<tipe>)` | ⚠️ batas kedalaman **tak terdokumentasi** — verifikasi H-7. Agent teams: **tidak boleh** nested |
| ★ ~~`/go`~~ | — | *Dikabarkan merangkai verify→simplify→ship* | ❌ **TIDAK ADA** di Claude Code (cek 2026-07-09). Pakai `/verify` → `/simplify` → `/ship` |

### A.3 Skills & plugins komunitas/resmi — install terverifikasi

| Tool | Mg | Fungsi | Install (per Juli 2026) |
|---|---|---|---|
| **superpowers** | 2+ | Metodologi brainstorm→plan→TDD→review | `/plugin marketplace add obra/superpowers-marketplace` → `/plugin install superpowers@superpowers-marketplace` |
| **frontend-design** | 7 | Frontend produksi, anti "AI generik" | `/plugin install frontend-design@claude-plugins-official` |
| **ui-ux-pro-max** | 7 | Design intelligence (style/palet/font) | `/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill` → `/plugin install ui-ux-pro-max@ui-ux-pro-max-skill` |
| **caveman** | 2,6,11 | Prosa ringkas ±65%; `/caveman-stats`; `caveman-compress` | install script `curl` dari README kanonik |
| **ponytail** | 2,11 | Kode minimal — YAGNI ladder | `/plugin marketplace add DietrichGebert/ponytail` → `/plugin install ponytail@ponytail` |
| **gstack** | 2,7,8 | Suite `/ship` `/investigate` `/qa` `/review` `/health` | `git clone --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack && cd ~/.claude/skills/gstack && ./setup` (**bukan** `/plugin`) |
| **find-skills** | 2 | Discovery skill di ekosistem | `npx skills find "<query>"` · add: `npx skills add <owner/repo@skill>` |
| **graphify** | 11 | Knowledge graph codebase (`/graphify`) | `uv tool install graphifyy` → `graphify install` (package **`graphifyy`**, double-y) |
| **skill-creator** | 2 | Bikin skill sendiri secara benar | marketplace resmi Anthropic |
| **`/grademe`** | 1+ | Scoring vibe coding 7 dimensi (internal Venturo) | `claude plugin marketplace add venturo-id/venturo-claude` → `claude plugin install grademe@venturo-tools` |

### A.4 MCP servers (semua resmi vendor)

| MCP | Mg | Use case | Keamanan |
|---|---|---|---|
| **Supabase** (`mcp.supabase.com`) | 5,10 | Schema, migration, query, TS types, logs | `?project_ref=` scoped · **DEV ONLY** · `?read_only=true` · `?features=` |
| **Context7** (Upstash) | 5+ | Docs library versi-akurat → anti-halusinasi | read-only, risiko nol |
| **Playwright** (Microsoft) | 5,7 | Browser automation via accessibility tree | sandbox |
| **GitHub** | 5,8 | PR/issue/code lintas repo | fine-grained PAT |
| **Vercel** (`mcp.vercel.com`) | 7 | Deploy, preview, build logs | OAuth |

Aturan kelas: maksimal **3–5 MCP aktif** per session; matikan sisanya (`/mcp disable <server>`), audit lewat `/context`.
Sintaks: `claude mcp add [--transport http] [--scope local|user|project] [-e KEY=val] <name> <url-atau-command>`.

### A.5 Token economy (progression tips corner)

| Mg | Teknik | Alat |
|---|---|---|
| 1 | Audit context `/context` · plan dulu (retry = boros terbesar) | built-in |
| 2 | caveman (−65% output) + ponytail (kode minimal) | komunitas |
| 3 | `/compact <hint>` vs `/clear` vs subagent (cegah) · ★ `CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000` | built-in |
| 5 | MCP tool bloat: aktifkan 3–5 saja | built-in |
| 6 | `caveman-compress` → CLAUDE.md ramping | caveman |
| 7 | Model routing subagent (tier cepat vs tier terkuat) | built-in |
| 9 | Statusline monitor context real-time | built-in |
| 10 | Permission model / allowlist · ★ `/fewer-permission-prompts` | built-in |
| 11 | ★ **rewind-over-correcting** (`/rewind`) · graphify (codebase besar) · peta lengkap | built-in + graphify |

### A.6 Mindset & disiplin (non-tool, berlaku selamanya)

| Prinsip | Diperkenalkan |
|---|---|
| Plan dulu — retry karena salah paham = boros terbesar | 1 |
| **Tulis, jangan re-prompt** — koreksi chat = tambalan sekali pakai; aturan tertulis = perbaikan selamanya | 1 |
| CLAUDE.md sehat ≤50 baris (ujian: "kalau dihapus, Claude salah jalan?") | 1 |
| Battle-tested only + **audit isi skill sebelum install** | 2,10 |
| Context = resource termahal; cegah *context rot* | 3 |
| **Verifier ≠ author** — yang menilai jangan yang menulis | 3 |
| Buktikan sebelum bilang "selesai" (`/verify`) | 2 |
| Data = kode yang berjalan (prompt injection) | 10 |
| **Mundur lebih murah daripada mengoreksi** (`/rewind`) | 11 |
| Tulis sekali, Claude ingat selamanya (second brain) | 11 |

---

## Apendiks B — Peta Akumulasi (kurva partial → penuh)

Jumlah **primitive** yang dikuasai di akhir tiap minggu:

```
Primitives  1  2  3  3  4  5  6  6  7  7  7  7
dikuasai    │  │  │  │  │  │  │  │  │  │  │  │
w:          1  2  3  4  5  6  7  8  9 10 11 12
            ▲           ▲           ▲
         Season 1    Season 2    Season 3
         Fondasi     Automation  Mastery
```

| Akhir minggu | Primitives | Tambahan besar hari itu |
|---|---|---|
| w1 | 1/7 | Loop inti + CLAUDE.md + built-ins + `/grademe` baseline |
| w2 | 2/7 | Skills 4 lapis + superpowers + token duo |
| w3 | 3/7 | Subagents + model routing + 3 subagent standar |
| w4 | 3/7 | ⚔️ Battle — konsolidasi w1–w3 |
| w5 | 4/7 | MCP + 4 server |
| w6 | 5/7 | Hooks + `/grademe` v0.2 `--upload` |
| w7 | 6/7 | Plugins + design + deploy LIVE |
| w8 | 6/7 | ⚔️ Battle — payoff auto-upload |
| w9 | **7/7** | Agent Teams — mental model utuh |
| w10 | 7/7 | Security hardening + `venturo-standards` v1.1 |
| w11 | 7/7 | Token economy sistemik + second brain |
| w12 | 7/7 | ⚔️ Battle Final — **lengkap & penuh** |

---

*Silabus ini turunan dari `curriculum-v3.3-plan.md` (sumber cakupan) + fact-check ke `code.claude.com/docs` & CLI aktual pada 2026-07-09 (sumber kebenaran eksternal). Detail per sesi: `w{NN}/handout.md`, `w{NN}/demo-script.md`, `w{NN}/exercise.md`. Versi tool & model yang di-pin: `_shared/versions.md`. Item ⚠️ wajib diverifikasi ulang H-7/H-1 sesuai Bagian G #7 master plan.*
