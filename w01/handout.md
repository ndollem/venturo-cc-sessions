# Cheat Sheet w01 — CLAUDE.md, Plan Mode & Built-ins

> Simpan di meja. Semua ini fitur BAWAAN Claude Code — tanpa install apa pun.

## Built-ins yang wajib kalian pakai mulai besok

| Perintah | Fungsi | Kapan |
|---|---|---|
| `Shift+Tab` (2×) | **Plan mode** — Claude riset & usul rencana, dilarang edit | Task >1 file · belum yakin solusi · repo asing |
| `/init` | Generate CLAUDE.md dari repo | Sekali per project (lalu rapikan!) |
| `/context` | Audit isi context window | Sebelum mulai kerja · saat jawaban mulai aneh |
| `/clear` | Kosongkan context, mulai bersih | Ganti topik/task besar |
| `/compact` | Ringkas percakapan, lanjut kerja | Context penuh TAPI masih 1 task yang sama |
| `/memory` | Edit CLAUDE.md global vs project | Atur aturan pribadi vs aturan tim |
| `/review` | Code review built-in | Sebelum commit perubahan besar |
| `Ctrl+B` | Jalankan command di background | Server/watcher sambil terus kerja |
| tanya `claude-code-guide` | "Tanya Claude tentang Claude" | Bingung fitur apa pun |

## Resep CLAUDE.md sehat (template: `_shared/templates/`)

4 section: **Stack → Perintah → Aturan wajib → Konvensi**. Target ≤ 50 baris.
Ujian tiap baris: *"Kalau baris ini dihapus, apakah Claude akan salah jalan?"* Tidak → hapus.
Jangan tulis yang bisa Claude temukan sendiri dari repo. CLAUDE.md = pajak token TIAP session.

## Tips Boris (pencipta Claude Code)

- **Tulis, jangan re-prompt.** Koreksi di chat = patch sekali-pakai (hilang tiap session baru). Tulis aturannya ke CLAUDE.md / bikin skill = fix selamanya. Ini yang bikin *"Claude bisa jalan berjam-jam"* tanpa kalian tuntun ulang.
- **Habit tiap koreksi:** tutup dengan *"Update your CLAUDE.md so you don't make that mistake again"* — biar salah yang sama tak terulang.
- **Konteks penuh di turn pertama** (Goal + Constraints + Acceptance) — selaras dimensi Planning & Context /grademe:

```
Goal: <apa yang mau dicapai, 1 kalimat>
Constraints: <batas — file yang boleh disentuh, jangan tambah dependency, ikut CLAUDE.md>
Acceptance: <kapan dianggap selesai — output/perilaku yang bisa diverifikasi>
```

## Workflow 5 langkah (= 7 dimensi /grademe)

**Plan** (rencana dulu, 20) → **Context** (CLAUDE.md & scope jelas, 20) → **Decompose** (task kecil-kecil, 15) → **Execute** (delegasi & tool tepat, 15) → **Verify** (test/jalankan sebelum bilang selesai, 15) · + Token efficiency 10 · Dokumentasi 5.

## Install & pakai /grademe (v0.1)

Dari marketplace (cara utama) — di dalam Claude Code:
```
/plugin marketplace add venturo-id/venturo-claude
/plugin install grademe@venturo-tools
```
Alternatif dev-only lokal (kalau punya folder panggung `<WS>`):
```bash
claude --plugin-dir <WS>/grademe
```
Lalu di dalam Claude Code: `/grademe <nama-kalian>` — jalankan SETELAH sesi kerja, idealnya dari session baru di project yang sama. Panduan lengkap + cara baca skor: `grademe/INSTALL.md`. Ingat: variance ±4 antar run normal; ada `misses` → skor maks 94; jangan coba-coba nge-gaming grader (terdeteksi = skor 0).

## Project baru vs existing — alur sama, titik berat beda

| | Project BARU (spt. vibescore di sesi) | Project EXISTING (punya kalian) |
|---|---|---|
| Hasil `/init` | Tipis (repo kosong/kecil) | Kaya (baca struktur, config, history) |
| Langkah kalian | BANGUN konteks: definisi produk → /init → template → PRD | SARING konteks: /init → review diff → pangkas ke ≤50 baris |
| Sudah ada CLAUDE.md? | — | Tetap boleh /init — dia mengusulkan perbaikan, bukan menimpa buta; review diff-nya |
| Monorepo besar | — | 1 CLAUDE.md di root dulu; per sub-folder hanya jika konvensi benar-benar beda |

Challenge Besok Pagi = jalur EXISTING (kolom kanan), di project kerja nyata kalian.

## Prompt yang di-scope (bandingkan!)

❌ `tambahkan endpoint healthz`
✅ `Tambahkan endpoint GET /healthz yang mengembalikan {"status":"ok"} status 200. Ikuti struktur cmd/ + internal/ sesuai CLAUDE.md. Jangan ubah file lain, jangan tambah dependency.`

Pola: **apa** persisnya + **di mana** (file/struktur) + **batas** (larangan eksplisit).

## Challenge Besok Pagi → detail & format lapor di `exercise.md`
