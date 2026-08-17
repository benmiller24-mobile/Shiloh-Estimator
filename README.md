# Shiloh Cabinetry Estimator

Dealer estimator for **Shiloh Cabinetry** (W.W. Wood Products) — sister app to the
[Eclipse Estimator](https://eclipse-estimator.netlify.app). Forked from
`eclipse-estimator` v8.8.0; ~95% shared code, Shiloh-native data.

**Live:** https://shiloh-estimator.netlify.app

## Data provenance
- **Price book:** 8,056 SKUs from the Shiloh Interactive Catalog **v3.42**
  (`2shiloh_catalog_v342_interactive.pdf`, 795 pages), triple-checked against the
  June 2026 grid scrape (4,989 SKUs), the April 2026 extraction (3,495 SKUs),
  105 known Shiloh-vs-Eclipse price overrides, and 27 Soderstrom-verified golden prices.
- **Tall/utility/oven grids:** `src/tall-prices.js` — 261 height-grid keys native to
  Shiloh v3.42 (91 differ from Eclipse; see PARITY.md).
- **Species charges:** verified against catalog Section D (paint 10%, custom paint 20%,
  walnut 20%, rift WO 19%, …).
- **Structure charges:** verified against catalog p.C2 (door groups A–D $0/44/88/150,
  drawer boxes $0/57, guides $0/72, 1¼" overlay +$26/door +$12/DF).

## Updating pricing when a new catalog ships
See `scripts/` in the April build plan (Downloads/shiloh-cowork-project) or re-run the
extraction pipeline: parse the new PDF, verify against this book, splice `const _D=`
in `src/shiloh-estimator.jsx`, regenerate `src/tall-prices.js`.

## Setup
```bash
npm install
cp .env.example .env.local     # fill in the Shiloh Supabase project creds
npm run dev
```
Supabase: create a NEW project (do not reuse Eclipse's), run `supabase-schema.sql`
in its SQL editor, then set `VITE_SUPABASE_URL` / `VITE_SUPABASE_ANON_KEY` in
`.env.local` and in Netlify → Site settings → Environment variables.

## Deploy
Netlify site `shiloh-estimator`, linked to this repo. Build: `npm install && npm run build`,
publish `dist/` (netlify.toml). Eclipse site/repo/Supabase are untouched by this app.
