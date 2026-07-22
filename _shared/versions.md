# Pinned Versions (A.6 #4 — update = re-rehearse affected demos)

> Diisi 2026-07-03 dari mesin build (macOS, darwin/arm64) + registry resmi.
> Status verifikasi: ✅ = ter-install & terpakai di mesin build · 📦 = pin dari registry resmi, **belum diuji install di mesin bersih** (H checklist v3.2 — wajib sebelum materi minggu terkait di-rehearse).
> Re-pin 2026-07-11 (keputusan user): CC 2.1.206 + Go 1.25 — aturan A.6 #4 tetap: semua rehearsal dilakukan di versi pin ini.

| Component | Version | Pinned date | Status | Notes |
|---|---|---|---|---|
| Claude Code | 2.1.206 | 2026-07-11 | ✅ | Semua peserta wajib versi sama; cek `claude --version` di w01 |
| Model | Sonnet 5 (`claude-sonnet-5`) | 2026-07-03 | ✅ | Baseline peserta (default Claude Code). Opus 4.8 opsional utk yang punya akses. Cek syarat Agent Teams H-7 sebelum Mg 9 |
| superpowers | 6.1.1 | 2026-07-03 | ✅ | `claude-plugins-official`, commit `6fd4507` |
| caveman | v1.9.1 | 2026-07-03 | 📦 | `JuliusBrussee/caveman` — install: `/plugin marketplace add JuliusBrussee/caveman` → `/plugin install caveman@caveman` |
| ponytail | v4.8.4 | 2026-07-03 | 📦 | `DietrichGebert/ponytail` — install: `/plugin marketplace add DietrichGebert/ponytail` → `/plugin install ponytail@ponytail` |
| frontend-design | 1.1.0 | 2026-07-03 | ✅ | Marketplace `claude-code-plugins` (resmi Anthropic), commit `a56ff02` |
| ui-ux-pro-max | 2.6.2 | 2026-07-03 | 📦 | `nextlevelbuilder/ui-ux-pro-max-skill` — install: `/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill` → `/plugin install ui-ux-pro-max@ui-ux-pro-max-skill` |
| gstack | TBD (pin saat uji mesin bersih) | 2026-07-03 | 📦 | `garrytan/gstack` — DIPUTUSKAN MASUK 2026-07-03; referensi skill: `docs/skills.md` di repo; framer DITUNDA |
| graphify | lokal (tanpa semver) | 2026-07-03 | ✅ | Skill lokal `~/.claude/skills/graphify` — TIDAK ada rilis bersemver; distribusi ke peserta perlu diputuskan saat riset F.2 (lihat PROGRESS blocker "gstack/gws & framer") |
| Supabase MCP | remote `https://mcp.supabase.com/mcp` | 2026-07-07 | 📦 | **REVISI 2026-07-07, TERVERIFIKASI WEB** (supabase.com/docs/guides/ai-tools/mcp): `claude mcp add --transport http supabase "https://mcp.supabase.com/mcp?project_ref=<ref>&read_only=true"` → `/mcp` → Authenticate (OAuth dynamic registration, tanpa PAT). Param `project_ref`/`read_only`/`features` ✓. DEV only; tulis hanya saat demo persist Mg 5. Versionless → re-dry-run H-1. Sisa: OAuth + smoke add di mesin panggung (H-7) |
| Context7 MCP | `@upstash/context7-mcp` 3.2.2 | 2026-07-03 | 📦 | Alternatif: plugin `context7@claude-plugins-official` (wrapper tanpa versi sendiri). Smoke mesin build tertunda (sesi 8) |
| Playwright MCP | `@playwright/mcp` 0.0.77 | 2026-07-03 | 📦 | Teaser Mg 5; alternatif plugin `playwright@claude-plugins-official`. Smoke mesin build tertunda (sesi 8) |
| Vercel MCP | remote `https://mcp.vercel.com` | 2026-07-03 | ✅ | Server remote, versionless — perilaku bisa berubah tanpa bump; WAJIB re-dry-run H-1 sebelum Mg 7 (deploy) |
| GitHub MCP | remote (plugin `github@claude-plugins-official`) | 2026-07-03 | ✅ | Server remote GitHub official, versionless — re-dry-run H-1 tiap sesi yang memakainya |
| Go / chi / pgx | Go 1.25.0 / chi v5.3.0 / pgx v5.10.0 | 2026-07-11 | ✅ | chi TERKUNCI di `vibescore-api/go.mod` (Phase 2); pgx menyusul saat s2w5 (Supabase) |
| Node / Vite / React | Node v24.10.0 (npm 11.6.0) / Vite 8.1.3 / React 19.2.7 / TS 6.0.3 / Tailwind 4.3.2 | 2026-07-03 | ✅ | TERKUNCI di `vibescore-web/package-lock.json` (scaffold Phase 2, 2026-07-03) |
| Next.js / React / vitest / oxlint / TS / @types/node (survey-app) | Next.js 16.2.10 / React 19.2.x / vitest 3.2.x / oxlint 1.x / TypeScript 5.9.x / @types/node 24.x | 2026-07-18 | ✅ | TERKUNCI di `survey-app/package-lock.json` — repo latihan **w03+** (`ndollem/survey-app`, gantikan vibescore mulai w03; lihat `survey-app-blueprint.md`) |
| webapp-testing (skill) | tak ber-semver, HEAD ~2026-07-16 | 2026-07-18 | 📦 | Marketplace `anthropic-agent-skills`, plugin `example-skills` — **belum diuji mesin bersih**. Butuh `python3` + `playwright` (`python3 -m pip install playwright && python3 -m playwright install chromium`). Dipakai w03 blok 7 (E2E + a11y) |

## Aturan

1. **Version bump ⇒ re-rehearse** semua demo yang menyentuh komponen itu (A.6 #4).
2. Komponen 📦 belum lolos uji "mesin bersih" — jalankan H checklist v3.2 (install dari nol, catat waktu & prompt izin) sebelum minggu pemakaiannya. Prioritas: caveman + ponytail + **gstack** (w02 — gstack masuk scope w02 sejak revisi 2026-07-05), ui-ux-pro-max (w07), Supabase/Context7/Playwright MCP (w05), **webapp-testing (w03)**.
3. Server MCP **remote** (Vercel, GitHub) tidak bisa di-pin — mitigasi: dry-run H-1 + fallback statis `[BUKTI-n]` (A.6 #6, revisi 2026-07-05: tanpa rekaman video).
4. chi/pgx/Vite/React di-pin final lewat lockfile repo vibescore saat Phase 2; angka di sini = target scaffold.
5. **Repo latihan per minggu (jangan campur):** w02 tetap `ndollem/vibescore-api` (Go/chi, tag `s1w1..s2w7`) — TIDAK berubah. w03 dan seterusnya pakai repo baru `ndollem/survey-app` (Next.js, tag `s1w3-start/-end`); vibescore-api tidak dihapus/direplace, hanya tidak dipakai lagi mulai w03.
