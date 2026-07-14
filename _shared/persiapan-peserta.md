# Persiapan Peserta — Sebelum Sesi

> Siapkan ini **sebelum minggu 1**. ±10 menit. Ini yang bikin kamu bisa **ikut mengetik**
> tiap langkah demo di mesinmu sendiri, bukan cuma menonton.

## Yang kamu butuh
- **Claude Code** terpasang (`claude --version`).
- **git** + akun GitHub.
- Editor (Cursor / VS Code).

## 1. Clone repo latihan (PUBLIC)
Project yang kita bangun bareng 12 minggu — leaderboard skor `vibescore`:
```bash
mkdir ~/venturo && cd ~/venturo
git clone https://github.com/ndollem/vibescore-api.git
git clone https://github.com/ndollem/vibescore-web.git      # baru dipakai mulai minggu 3
```

## 2. Mulai dari titik awal minggu
Tiap minggu punya tag mulai `-start` dan kunci jawaban `-end`:

| Minggu | Titik mulai | Kunci jawaban |
|---|---|---|
| Mg 1 | `s1w1-start` | `s1w1-end` |
| Mg 2 | `s1w2-start` | `s1w2-end` |
| Mg 3 | `s1w3-start` | `s1w3-end` |
| Mg 5 | `s2w5-start` | `s2w5-end` |
| Mg 6 | `s2w6-start` | `s2w6-end` |
| Mg 7 | `s2w7-start` | `s2w7-end` |

```bash
cd vibescore-api && git checkout s1w1-start      # contoh: siap minggu 1
```
Tersesat saat mengikuti demo? `git checkout <tag>-end -- <file>` untuk melihat versi jadi,
lalu lanjut — **jangan debug lama; tag adalah jaring pengaman.**

## 3. Pasang `/grademe`
Skoring 7-dimensi vibe coding kita. Di dalam `claude`:
```
/plugin marketplace add venturo-id/venturo-claude
/plugin install grademe@venturo-tools
```
Uji: buka `claude` di `vibescore-api`, ketik `/grademe nama-kamu` setelah sesi kerja — keluar
JSON skor. Bawa skormu tiap minggu (Challenge Besok Pagi).

## Peta materi
Deck slide tiap minggu + silabus lengkap: **[buka landing materi](../index.html)**.

---
*Repo `vibescore-*` read-only untuk peserta — kamu clone & kerja di salinanmu sendiri. Mulai
Mg 5 demo memakai database; kamu ikut alur command-nya, data live pemateri tak dibagikan.*
