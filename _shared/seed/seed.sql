-- ============================================================================
-- seed.sql — dataset DETERMINISTIK Vibe Score Leaderboard (A.6 #7)
-- ============================================================================
-- * Idempotent: aman dijalankan berulang (drop + recreate + insert).
-- * HANYA untuk Supabase DEV project — jangan pernah ke production.
-- * Dipakai: demo persist s2w5 · rehearsal & H-1 dry-run · analisa w11
--   (dataset beku: 8 peserta × 10 sesi, 79 baris — eko absen mg 3).
-- * Alur cerita utk demo insight w11: andi steady-high, budi TOP MOVER
--   (lompat setelah mg 6), citra konsisten-mid, dewi planning lemah lalu
--   membaik, eko plateau, fajar late bloomer (mg 7), gita volatile,
--   hana documentation selalu kuat.
-- * Kolom `source`: 'seed' = data beku demo · 'live' = skor peserta nyata
--   (upload /grademe mulai s2w6). Analisa w11 filter source='seed';
--   leaderboard production filter source='live'. KEPUTUSAN 2026-07-03.
-- * Skema ini = acuan migrasi s2w5 (Supabase MCP). Constraint = mirror
--   validasi internal/score/model.go + openapi.yaml (kontrak Bagian E).
-- * File ini di-freeze dari generator (seed 42) — JANGAN edit angka manual.
-- ============================================================================

drop table if exists scores;
drop table if exists participants;

create table participants (
  id         serial primary key,
  name       text not null unique,
  source     text not null default 'live' check (source in ('seed','live')),
  created_at timestamptz not null default now()
);

create table scores (
  id                  serial primary key,
  participant_id      int not null references participants (id),
  session_date        timestamptz not null,
  total_score         int not null check (total_score between 0 and 100),
  planning            int not null check (planning between 0 and 20),
  context             int not null check (context between 0 and 20),
  decomposition       int not null check (decomposition between 0 and 15),
  delegation          int not null check (delegation between 0 and 15),
  verification        int not null check (verification between 0 and 15),
  token_efficiency    int not null check (token_efficiency between 0 and 10),
  documentation       int not null check (documentation between 0 and 5),
  misses              jsonb not null default '[]'::jsonb,
  next_session_advice text not null default '',
  source              text not null default 'live' check (source in ('seed','live')),
  received_at         timestamptz not null default now(),
  constraint total_sama_dengan_jumlah_breakdown check (
    total_score = planning + context + decomposition + delegation
                + verification + token_efficiency + documentation
  )
);

create index scores_participant_idx on scores (participant_id, session_date);

insert into participants (name, source) values
  ('andi', 'seed'),
  ('budi', 'seed'),
  ('citra', 'seed'),
  ('dewi', 'seed'),
  ('eko', 'seed'),
  ('fajar', 'seed'),
  ('gita', 'seed'),
  ('hana', 'seed')
on conflict (name) do nothing;

insert into scores (participant_id, session_date, total_score, planning, context, decomposition, delegation, verification, token_efficiency, documentation, misses, next_session_advice, source) values
  ((select id from participants where name='andi'), '2026-07-15T10:00:00Z', 78, 15, 15, 12, 12, 12, 8, 4, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='andi'), '2026-07-22T10:00:00Z', 80, 16, 16, 12, 12, 12, 8, 4, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='andi'), '2026-07-29T10:00:00Z', 82, 17, 17, 12, 12, 12, 8, 4, '["task besar tidak dipecah, satu prompt raksasa"]'::jsonb, 'fokus perbaiki: task besar tidak dipecah, satu prompt raksasa', 'seed'),
  ((select id from participants where name='andi'), '2026-08-05T10:00:00Z', 83, 18, 17, 12, 12, 12, 8, 4, '["task besar tidak dipecah, satu prompt raksasa"]'::jsonb, 'fokus perbaiki: task besar tidak dipecah, satu prompt raksasa', 'seed'),
  ((select id from participants where name='andi'), '2026-08-12T10:00:00Z', 85, 17, 17, 13, 13, 13, 8, 4, '["context penuh file yang tidak relevan"]'::jsonb, 'fokus perbaiki: context penuh file yang tidak relevan', 'seed'),
  ((select id from participants where name='andi'), '2026-08-19T10:00:00Z', 86, 17, 17, 13, 13, 13, 9, 4, '["keputusan arsitektur tidak dicatat"]'::jsonb, 'fokus perbaiki: keputusan arsitektur tidak dicatat', 'seed'),
  ((select id from participants where name='andi'), '2026-08-26T10:00:00Z', 88, 18, 18, 13, 13, 13, 9, 4, '["keputusan arsitektur tidak dicatat"]'::jsonb, 'fokus perbaiki: keputusan arsitektur tidak dicatat', 'seed'),
  ((select id from participants where name='andi'), '2026-09-02T10:00:00Z', 89, 19, 18, 13, 13, 13, 9, 4, '["keputusan arsitektur tidak dicatat"]'::jsonb, 'fokus perbaiki: keputusan arsitektur tidak dicatat', 'seed'),
  ((select id from participants where name='andi'), '2026-09-09T10:00:00Z', 90, 17, 18, 14, 14, 14, 9, 4, '[]'::jsonb, 'pertahankan — session hampir tanpa cela', 'seed'),
  ((select id from participants where name='andi'), '2026-09-16T10:00:00Z', 91, 17, 18, 14, 14, 14, 9, 5, '[]'::jsonb, 'pertahankan — session hampir tanpa cela', 'seed'),
  ((select id from participants where name='budi'), '2026-07-15T10:00:00Z', 45, 7, 10, 8, 7, 7, 4, 2, '["langsung koding tanpa plan mode", "context penuh file yang tidak relevan", "keputusan arsitektur tidak dicatat"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='budi'), '2026-07-22T10:00:00Z', 48, 7, 11, 8, 8, 7, 5, 2, '["langsung koding tanpa plan mode", "keputusan arsitektur tidak dicatat", "klaim selesai tanpa menjalankan test"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='budi'), '2026-07-29T10:00:00Z', 50, 7, 11, 9, 8, 8, 5, 2, '["langsung koding tanpa plan mode", "keputusan arsitektur tidak dicatat", "context penuh file yang tidak relevan"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='budi'), '2026-08-05T10:00:00Z', 52, 10, 10, 8, 8, 8, 5, 3, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting", "context penuh file yang tidak relevan"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='budi'), '2026-08-12T10:00:00Z', 55, 10, 12, 8, 8, 8, 6, 3, '["langsung koding tanpa plan mode", "task besar tidak dipecah, satu prompt raksasa"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='budi'), '2026-08-19T10:00:00Z', 70, 13, 15, 11, 10, 10, 7, 4, '["langsung koding tanpa plan mode", "tidak pakai subagent untuk pekerjaan paralel"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='budi'), '2026-08-26T10:00:00Z', 78, 14, 16, 12, 12, 12, 8, 4, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='budi'), '2026-09-02T10:00:00Z', 82, 15, 17, 13, 13, 12, 8, 4, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='budi'), '2026-09-09T10:00:00Z', 86, 15, 18, 14, 13, 13, 9, 4, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='budi'), '2026-09-16T10:00:00Z', 88, 16, 19, 14, 13, 13, 9, 4, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='citra'), '2026-07-15T10:00:00Z', 62, 13, 13, 9, 9, 9, 6, 3, '["task besar tidak dipecah, satu prompt raksasa", "tidak pakai subagent untuk pekerjaan paralel"]'::jsonb, 'fokus perbaiki: task besar tidak dipecah, satu prompt raksasa', 'seed'),
  ((select id from participants where name='citra'), '2026-07-22T10:00:00Z', 63, 14, 13, 9, 9, 9, 6, 3, '["task besar tidak dipecah, satu prompt raksasa", "tidak pakai subagent untuk pekerjaan paralel"]'::jsonb, 'fokus perbaiki: task besar tidak dipecah, satu prompt raksasa', 'seed'),
  ((select id from participants where name='citra'), '2026-07-29T10:00:00Z', 65, 13, 13, 10, 10, 10, 6, 3, '["context penuh file yang tidak relevan", "keputusan arsitektur tidak dicatat"]'::jsonb, 'fokus perbaiki: context penuh file yang tidak relevan', 'seed'),
  ((select id from participants where name='citra'), '2026-08-05T10:00:00Z', 64, 12, 13, 10, 10, 10, 6, 3, '["langsung koding tanpa plan mode", "context penuh file yang tidak relevan"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='citra'), '2026-08-12T10:00:00Z', 66, 13, 13, 10, 10, 10, 7, 3, '["keputusan arsitektur tidak dicatat", "langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: keputusan arsitektur tidak dicatat', 'seed'),
  ((select id from participants where name='citra'), '2026-08-19T10:00:00Z', 67, 14, 13, 10, 10, 10, 7, 3, '["keputusan arsitektur tidak dicatat", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: keputusan arsitektur tidak dicatat', 'seed'),
  ((select id from participants where name='citra'), '2026-08-26T10:00:00Z', 68, 14, 14, 10, 10, 10, 7, 3, '["keputusan arsitektur tidak dicatat", "task besar tidak dipecah, satu prompt raksasa"]'::jsonb, 'fokus perbaiki: keputusan arsitektur tidak dicatat', 'seed'),
  ((select id from participants where name='citra'), '2026-09-02T10:00:00Z', 68, 14, 14, 10, 10, 10, 7, 3, '["keputusan arsitektur tidak dicatat", "task besar tidak dipecah, satu prompt raksasa"]'::jsonb, 'fokus perbaiki: keputusan arsitektur tidak dicatat', 'seed'),
  ((select id from participants where name='citra'), '2026-09-09T10:00:00Z', 69, 15, 14, 10, 10, 10, 7, 3, '["keputusan arsitektur tidak dicatat", "task besar tidak dipecah, satu prompt raksasa"]'::jsonb, 'fokus perbaiki: keputusan arsitektur tidak dicatat', 'seed'),
  ((select id from participants where name='citra'), '2026-09-16T10:00:00Z', 70, 15, 14, 10, 10, 10, 7, 4, '["task besar tidak dipecah, satu prompt raksasa", "tidak pakai subagent untuk pekerjaan paralel"]'::jsonb, 'fokus perbaiki: task besar tidak dipecah, satu prompt raksasa', 'seed'),
  ((select id from participants where name='dewi'), '2026-07-15T10:00:00Z', 70, 8, 15, 11, 11, 14, 7, 4, '["langsung koding tanpa plan mode", "context penuh file yang tidak relevan"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='dewi'), '2026-07-22T10:00:00Z', 71, 8, 15, 12, 11, 14, 7, 4, '["langsung koding tanpa plan mode", "context penuh file yang tidak relevan"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='dewi'), '2026-07-29T10:00:00Z', 73, 8, 16, 12, 12, 14, 7, 4, '["langsung koding tanpa plan mode", "context penuh file yang tidak relevan"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='dewi'), '2026-08-05T10:00:00Z', 74, 12, 15, 11, 11, 14, 7, 4, '["langsung koding tanpa plan mode", "context penuh file yang tidak relevan"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='dewi'), '2026-08-12T10:00:00Z', 76, 12, 15, 11, 11, 15, 8, 4, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='dewi'), '2026-08-19T10:00:00Z', 77, 11, 15, 12, 12, 15, 8, 4, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='dewi'), '2026-08-26T10:00:00Z', 79, 12, 16, 12, 12, 15, 8, 4, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='dewi'), '2026-09-02T10:00:00Z', 80, 13, 16, 12, 12, 15, 8, 4, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='dewi'), '2026-09-09T10:00:00Z', 81, 13, 17, 12, 12, 15, 8, 4, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='dewi'), '2026-09-16T10:00:00Z', 82, 13, 17, 13, 12, 15, 8, 4, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='eko'), '2026-07-15T10:00:00Z', 55, 11, 11, 8, 8, 8, 6, 3, '["task besar tidak dipecah, satu prompt raksasa", "tidak pakai subagent untuk pekerjaan paralel"]'::jsonb, 'fokus perbaiki: task besar tidak dipecah, satu prompt raksasa', 'seed'),
  ((select id from participants where name='eko'), '2026-07-22T10:00:00Z', 56, 12, 11, 8, 8, 8, 6, 3, '["task besar tidak dipecah, satu prompt raksasa", "tidak pakai subagent untuk pekerjaan paralel"]'::jsonb, 'fokus perbaiki: task besar tidak dipecah, satu prompt raksasa', 'seed'),
  ((select id from participants where name='eko'), '2026-08-05T10:00:00Z', 57, 10, 11, 9, 9, 9, 6, 3, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='eko'), '2026-08-12T10:00:00Z', 56, 12, 11, 8, 8, 8, 6, 3, '["task besar tidak dipecah, satu prompt raksasa", "tidak pakai subagent untuk pekerjaan paralel"]'::jsonb, 'fokus perbaiki: task besar tidak dipecah, satu prompt raksasa', 'seed'),
  ((select id from participants where name='eko'), '2026-08-19T10:00:00Z', 58, 11, 11, 9, 9, 9, 6, 3, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='eko'), '2026-08-26T10:00:00Z', 57, 10, 11, 9, 9, 9, 6, 3, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='eko'), '2026-09-02T10:00:00Z', 58, 11, 11, 9, 9, 9, 6, 3, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='eko'), '2026-09-09T10:00:00Z', 58, 11, 11, 9, 9, 9, 6, 3, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='eko'), '2026-09-16T10:00:00Z', 58, 11, 11, 9, 9, 9, 6, 3, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='fajar'), '2026-07-15T10:00:00Z', 40, 9, 7, 6, 6, 6, 4, 2, '["CLAUDE.md tidak di-update setelah keputusan penting", "task besar tidak dipecah, satu prompt raksasa", "tidak pakai subagent untuk pekerjaan paralel"]'::jsonb, 'fokus perbaiki: CLAUDE.md tidak di-update setelah keputusan penting', 'seed'),
  ((select id from participants where name='fajar'), '2026-07-22T10:00:00Z', 42, 9, 7, 7, 7, 6, 4, 2, '["CLAUDE.md tidak di-update setelah keputusan penting", "klaim selesai tanpa menjalankan test", "context penuh file yang tidak relevan"]'::jsonb, 'fokus perbaiki: CLAUDE.md tidak di-update setelah keputusan penting', 'seed'),
  ((select id from participants where name='fajar'), '2026-07-29T10:00:00Z', 41, 9, 7, 7, 6, 6, 4, 2, '["CLAUDE.md tidak di-update setelah keputusan penting", "tidak pakai subagent untuk pekerjaan paralel", "klaim selesai tanpa menjalankan test"]'::jsonb, 'fokus perbaiki: CLAUDE.md tidak di-update setelah keputusan penting', 'seed'),
  ((select id from participants where name='fajar'), '2026-08-05T10:00:00Z', 43, 10, 8, 7, 6, 6, 4, 2, '["CLAUDE.md tidak di-update setelah keputusan penting", "tidak pakai subagent untuk pekerjaan paralel", "klaim selesai tanpa menjalankan test"]'::jsonb, 'fokus perbaiki: CLAUDE.md tidak di-update setelah keputusan penting', 'seed'),
  ((select id from participants where name='fajar'), '2026-08-12T10:00:00Z', 44, 10, 7, 7, 7, 7, 4, 2, '["CLAUDE.md tidak di-update setelah keputusan penting", "context penuh file yang tidak relevan", "keputusan arsitektur tidak dicatat"]'::jsonb, 'fokus perbaiki: CLAUDE.md tidak di-update setelah keputusan penting', 'seed'),
  ((select id from participants where name='fajar'), '2026-08-19T10:00:00Z', 45, 10, 8, 7, 7, 7, 4, 2, '["CLAUDE.md tidak di-update setelah keputusan penting", "context penuh file yang tidak relevan", "keputusan arsitektur tidak dicatat"]'::jsonb, 'fokus perbaiki: CLAUDE.md tidak di-update setelah keputusan penting', 'seed'),
  ((select id from participants where name='fajar'), '2026-08-26T10:00:00Z', 60, 13, 11, 9, 9, 9, 6, 3, '["CLAUDE.md tidak di-update setelah keputusan penting", "task besar tidak dipecah, satu prompt raksasa"]'::jsonb, 'fokus perbaiki: CLAUDE.md tidak di-update setelah keputusan penting', 'seed'),
  ((select id from participants where name='fajar'), '2026-09-02T10:00:00Z', 68, 15, 13, 10, 10, 10, 7, 3, '["keputusan arsitektur tidak dicatat", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: keputusan arsitektur tidak dicatat', 'seed'),
  ((select id from participants where name='fajar'), '2026-09-09T10:00:00Z', 72, 15, 13, 11, 11, 11, 7, 4, '["CLAUDE.md tidak di-update setelah keputusan penting", "context penuh file yang tidak relevan"]'::jsonb, 'fokus perbaiki: CLAUDE.md tidak di-update setelah keputusan penting', 'seed'),
  ((select id from participants where name='fajar'), '2026-09-16T10:00:00Z', 75, 16, 14, 11, 11, 11, 8, 4, '["CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: CLAUDE.md tidak di-update setelah keputusan penting', 'seed'),
  ((select id from participants where name='gita'), '2026-07-15T10:00:00Z', 50, 9, 10, 8, 8, 8, 5, 2, '["keputusan arsitektur tidak dicatat", "langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: keputusan arsitektur tidak dicatat', 'seed'),
  ((select id from participants where name='gita'), '2026-07-22T10:00:00Z', 68, 14, 14, 10, 10, 10, 7, 3, '["keputusan arsitektur tidak dicatat", "task besar tidak dipecah, satu prompt raksasa"]'::jsonb, 'fokus perbaiki: keputusan arsitektur tidak dicatat', 'seed'),
  ((select id from participants where name='gita'), '2026-07-29T10:00:00Z', 52, 10, 10, 8, 8, 8, 5, 3, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting", "context penuh file yang tidak relevan"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='gita'), '2026-08-05T10:00:00Z', 71, 13, 14, 11, 11, 11, 7, 4, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='gita'), '2026-08-12T10:00:00Z', 55, 11, 11, 8, 8, 8, 6, 3, '["task besar tidak dipecah, satu prompt raksasa", "tidak pakai subagent untuk pekerjaan paralel"]'::jsonb, 'fokus perbaiki: task besar tidak dipecah, satu prompt raksasa', 'seed'),
  ((select id from participants where name='gita'), '2026-08-19T10:00:00Z', 73, 14, 15, 11, 11, 11, 7, 4, '["langsung koding tanpa plan mode", "context penuh file yang tidak relevan"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='gita'), '2026-08-26T10:00:00Z', 58, 11, 11, 9, 9, 9, 6, 3, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='gita'), '2026-09-02T10:00:00Z', 74, 15, 15, 11, 11, 11, 7, 4, '["context penuh file yang tidak relevan", "task besar tidak dipecah, satu prompt raksasa"]'::jsonb, 'fokus perbaiki: context penuh file yang tidak relevan', 'seed'),
  ((select id from participants where name='gita'), '2026-09-09T10:00:00Z', 60, 12, 12, 9, 9, 9, 6, 3, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='gita'), '2026-09-16T10:00:00Z', 75, 15, 15, 11, 11, 11, 8, 4, '["task besar tidak dipecah, satu prompt raksasa"]'::jsonb, 'fokus perbaiki: task besar tidak dipecah, satu prompt raksasa', 'seed'),
  ((select id from participants where name='hana'), '2026-07-15T10:00:00Z', 65, 12, 12, 10, 10, 10, 6, 5, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='hana'), '2026-07-22T10:00:00Z', 67, 12, 13, 10, 10, 10, 7, 5, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='hana'), '2026-07-29T10:00:00Z', 69, 13, 14, 10, 10, 10, 7, 5, '["langsung koding tanpa plan mode", "task besar tidak dipecah, satu prompt raksasa"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='hana'), '2026-08-05T10:00:00Z', 71, 13, 13, 11, 11, 11, 7, 5, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='hana'), '2026-08-12T10:00:00Z', 73, 14, 14, 11, 11, 11, 7, 5, '["langsung koding tanpa plan mode", "CLAUDE.md tidak di-update setelah keputusan penting"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='hana'), '2026-08-19T10:00:00Z', 75, 14, 15, 11, 11, 11, 8, 5, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='hana'), '2026-08-26T10:00:00Z', 76, 15, 15, 11, 11, 11, 8, 5, '["task besar tidak dipecah, satu prompt raksasa"]'::jsonb, 'fokus perbaiki: task besar tidak dipecah, satu prompt raksasa', 'seed'),
  ((select id from participants where name='hana'), '2026-09-02T10:00:00Z', 78, 15, 15, 11, 12, 12, 8, 5, '["task besar tidak dipecah, satu prompt raksasa"]'::jsonb, 'fokus perbaiki: task besar tidak dipecah, satu prompt raksasa', 'seed'),
  ((select id from participants where name='hana'), '2026-09-09T10:00:00Z', 79, 15, 15, 12, 12, 12, 8, 5, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed'),
  ((select id from participants where name='hana'), '2026-09-16T10:00:00Z', 80, 15, 16, 12, 12, 12, 8, 5, '["langsung koding tanpa plan mode"]'::jsonb, 'fokus perbaiki: langsung koding tanpa plan mode', 'seed');
