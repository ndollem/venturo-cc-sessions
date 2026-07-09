# {{NAMA_PROJECT}}

{{SATU_KALIMAT_TUJUAN_PROJECT. Link dok produk bila ada, mis. docs/01-prd.md}}

## Stack

- React {{VERSI}} + TypeScript, Vite {{VERSI}}
- {{STYLING, mis. Tailwind CSS}}
- {{HOSTING}}

## Perintah

```bash
npm run dev       # dev server (default :{{PORT}})
npm run build     # type-check + build produksi — harus hijau sebelum commit
npm test          # {{TEST_RUNNER, mis. vitest}}
```

## Aturan wajib

1. {{ATURAN_KONTRAK_API — mis. "shape API HANYA dari openapi.yaml backend; jangan baca source BE"}}
2. Base URL API lewat env `{{VITE_API_URL}}`, jangan hardcode.
3. Type API terpusat di `src/api/types.ts` — komponen tidak mendefinisikan ulang shape.
4. {{LARANGAN_KRITIS — mis. "jangan tambah state-management library tanpa keputusan tim"}}

## Konvensi kode

- Bahasa UI: Indonesia. Nama variabel & istilah teknis: English.
- Komponen kecil & fungsional; logika fetch terpisah dari tampilan.
- Styling hanya {{STYLING}} — tanpa CSS file per-komponen.

<!-- Template Venturo React v1 (w01). Isi placeholder {{...}}, hapus yang tidak
     relevan, JAGA ≤ 50 baris. Kalau Claude bisa menemukannya sendiri dari repo, hapus. -->
