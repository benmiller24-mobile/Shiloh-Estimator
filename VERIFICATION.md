# VERIFICATION — Shiloh price book v34.2.0 (2026-08-17)

Source of truth: 2shiloh_catalog_v342_interactive.pdf (50.6MB, 795 pages, v3.42).

## Method
Three independent extractions reconciled:
1. June 2026 coordinate grid scrape (4,989 SKUs; basis of the interim catalog).
2. April 2026 pipeline (3,495 clean + 1,010 shiloh-only + 105 overrides).
3. Fresh August 2026 extraction (this build): pdfplumber word-coordinate pass +
   layout-text pass over all 795 pages; grid synthesis by column-insertion with
   brute-force naming match; per-page section codes recovered for catalog refs.

## Results
- 4,957 / 5,015 interim SKUs (98.8%) price-verified character-exact against the PDF.
- 0 price conflicts across all sources after reconciliation.
- 58 SKUs carried on scrape authority only (listed in BUILD-FLAGGED.md).
- 3,041 additional SKUs merged from April extraction + shiloh-only + PDF-adds + rates.
- Final book: 8,056 SKUs.

## Golden checks (all pass)
Sanity 5 (April plan): W1230=332, W24-2D30=583, B24-2D=738, B39=819, O3093=1715.
Soderstrom book-level: W1836=449, RW3015-30D=715, U1893=1260, U2493=1518,
FIOM3393-27=2725, B15/B18/B21/B24-RT=912/923/958/977, VTB12=447, VTSB24=506,
BCF-INSET=732, INFBDEPL=656. (Derived-SKU goldens — REP panels, UT…-RT-27R —
price through the app's resolver, unchanged from Eclipse v8.8.)
All 105 April overrides present at override prices; 0 deviations.
Structure charges verified against catalog C2; species % against Section D.
