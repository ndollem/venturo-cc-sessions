# {{NAMA_PROJECT}}

{{SATU_KALIMAT_TUJUAN_PROJECT — apa ini dan untuk siapa. Link dok produk bila ada, mis. docs/01-prd.md}}

## Stack

- Go {{VERSI}} + {{ROUTER/FRAMEWORK, mis. chi v5}}
- {{DATABASE + driver, mis. Supabase Postgres via pgx}}
- {{HOSTING}}

## Perintah

```bash
go run ./cmd/{{APP}}     # jalankan lokal (default :{{PORT}})
go test ./...            # semua test harus hijau sebelum commit
go vet ./...             # lint minimal
```

## Aturan wajib

1. {{ATURAN_KONTRAK — mis. "openapi.yaml adalah KONTRAK: update dulu, baru implementasi"}}
2. **Struktur**: `cmd/` (entrypoint) · `internal/` (logic private) · `docs/` (01-prd … 05-decision-log)
3. **Test dulu hijau, baru selesai.** Handler/fungsi baru = test baru.
4. {{LARANGAN_KRITIS — mis. "jangan sentuh DB production; kredensial via env, tidak pernah di-commit"}}
5. Error response konsisten: `{"error": "pesan"}` + status code tepat.

## Konvensi kode

- Bahasa komentar/dok: Indonesia boleh, istilah teknis English.
- Handler tipis — validasi & logika di package `internal/{{DOMAIN}}`.
- Config hanya lewat env var, dibaca sekali di startup.

<!-- Template Venturo Go v1 (w01). Aturan pakai: isi placeholder {{...}}, hapus
     yang tidak relevan, JAGA TETAP ≤ 50 baris — CLAUDE.md gemuk = pajak token
     di setiap session. Kalau Claude bisa menemukannya sendiri dari repo, hapus. -->
