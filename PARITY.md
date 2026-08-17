# Shiloh–Eclipse Parity Log

Tracks every intentional divergence between `shiloh-estimator` and `eclipse-estimator`
(forked from v8.8.0, commit c807b07). Format: what changed / why.

## Initial fork — 2026-08-17
Cloned from eclipse-estimator v8.8.0 @ c807b07. `.git`, `node_modules`, `dist` stripped.

## Pricing data
- `_D` price book replaced: 8,056 Shiloh SKUs (from interactive catalog v3.42) vs
  Eclipse's 7,784. Types/W refs re-derived; catalog refs are Shiloh page codes (A1–S8),
  `SH` where a page code could not be pinned.
- `src/tall-prices.js` replaced with Shiloh grids (261 keys). 91 keys differ from
  Eclipse (U*-2D families, O3093 family, U27-27 off-by-$1, etc.). 56 Eclipse keys have
  **no Shiloh v3.42 pricing** and were omitted — picking those height combos shows no
  price rather than a wrong one. List in BUILD-FLAGGED.md.
- Species map `SP`: Paint (Std SW) 18→**10**, Paint (Trend) 18→**10**, Custom Paint
  28→**20** (catalog D13/D14). Removed Eclipse frameless-only materials: TFL (−25),
  PV (−10), Rauvisio Matte HPL (−4), Acrylic HG/Matte — no Shiloh pricing exists for
  them. Kept Recon WO/Walnut (+4, sample decks include RWOW chips) — CONFIRM with W.W.
- `DRW_BOX`: trimmed to Shiloh's options (5/8 & 3/4 dovetail × Tandem Edge / Full Ext;
  $0/$57/$72/$129 per C2). Removed Simulated Metal and Legrabox ($372) — not offered.
- **NEW: Overlay/Inset selector** (`OVL_OPTS`): 1¼" Overlay (EN) adds $26/door +
  $12/drawer front per catalog C2. ½" overlay and all insets $0. Persisted per quote
  (`ovl`, defaults CN). Eclipse (frameless full-overlay) had no such concept.
- Edge profile list → Shiloh's: 100/150/200/350/400/500/700/750 (dropped B-Alum,
  S-Alum, 3D aluminum profiles — GOLA/frameless only).
- NOT auto-priced (manual quote items, see BUILD-FLAGGED.md): custom paint $750
  fee for orders under $15k list; RBS toggle retained from Eclipse ($87) — confirm
  Shiloh applicability.

## Branding
- All UI strings, download filenames (`Shiloh-*`), order-form footers (SHI-SOF),
  CSV headers, localStorage keys (`shiloh_recent_skus`) swapped per
  BRAND-SWAP-CHECKLIST.md. Rep Discount Cover Sheet brand radio defaults to
  Choice1 (Shiloh). `starterEclipse` sample entry removed; `starterShiloh` kept.
- Palette/fonts unchanged (Phase-3 pending: Shiloh logo + brand colors from Ben).

## PDF forms
- Order form module `pdf-blank-order-form.js` = standard-order-form-shiloh.pdf
  (456 fields; 33 Eclipse-only checkbox fields — Legrabox, B-Alum edge, 3D edge —
  absent on the Shiloh form; fill code is per-field try/catch so they no-op).
- All 9 oven/microwave cutout spec modules = Shiloh versions (field names match).
- public/forms: warranty, sample-door (12½×15½), sample-door-express, sample-ddf
  (= Shiloh "Sample Face Frame and Door" form), color-blocks, color-chips replaced
  with Shiloh versions. `parcel.pdf`, `truck.pdf`, `rep-discount-cover-sheet.pdf`,
  `ddf.pdf` retained (shared W.W. Wood forms — confirm branding with W.W.).
- starter-package-eclipse.pdf left in place (unreferenced dead path).

## Infrastructure
- Supabase: hardcoded Eclipse creds removed → `VITE_SUPABASE_URL` /
  `VITE_SUPABASE_ANON_KEY` env vars, with a visible "not configured" banner and
  placeholder client so the app renders before configuration. NEW Supabase project
  required (schema: supabase-schema.sql). Eclipse's project is never touched.
- FINISH_COLORS / stain-glaze matrices retained from Eclipse v8.8 per checklist
  ("do not change without Benjamin") — styleCompat data pending Shiloh matrix review.
