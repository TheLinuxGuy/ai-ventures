---
name: toilet-paper-value
description: Compare toilet paper deals by sheets per roll and user-provided price, then calculate per-sheet value and the Tetrion TP Calculator Pro deal grade.
---

# Toilet paper purchase value

When the user provides a product link and their price, identify the package quantity, sheets per roll, ply, and (when available) review score. Calculate value using the [Tetrion Toilet Paper Value Calculator Pro](https://tetrion.com/tpcalc.php) rules. Treat the user's stated price as authoritative: never substitute a public/list price. Do not add tax or shipping unless the user says their supplied price includes it or asks to include it.

## Product research

Read the product page and, if needed, corroborate missing specifications with reliable product/manufacturer sources or exact-ASIN search results. Record the source for the roll count, sheet count, ply, and review score. Do not infer quantity from marketing equivalents such as “regular rolls.” If pack count or sheets per roll remain uncertain, say what is missing and ask for clarification instead of presenting a definitive grade. If the listing is a multipack, use the total rolls and price for the quantity the user intends to buy; clarify if the link's deal is conditional on buying multiple packs and the provided price does not establish how many.

## Calculation

- Total sheets = rolls × sheets per roll.
- User price is the starting/final price for the stated purchase. The calculator's standard output also considers additional 0%, 5%, 10%, and 15% discount scenarios. Show those as hypothetical extra savings; do not assume they apply.
- For each scenario, scenario price = user price × (1 − extra discount); cost per sheet in cents = scenario price ÷ total sheets × 100.
- Compare each scenario against all three calculator benchmarks. A scenario earns one “yes” for each benchmark it meets (equal counts as meeting): 0.253¢/sheet (TofuVic), 0.24552631578947¢/sheet (Costco delivery), and 0.18412280701754¢/sheet (Costco warehouse).
- Price-only grade = 100 × yes count ÷ 12 comparisons, rounded to nearest integer, then map: A+ ≥96; A ≥80; A− ≥70; B+ ≥60; B ≥50; C+ ≥40; C ≥30; D+ ≥20; D ≥10; D− ≥1; F otherwise. State this is the Tetrion calculator's comparative grade, not a universal retail grade.
- If a review score q from 0–5 is available and clearly belongs to the exact product, quality-adjusted grade uses the same letter mapping on price-only percentage × (q ÷ 4). The calculator displays this score as optional. Omit it if not available or not reliable; do not invent a quality score.
- The calculator warns that its grades are based on 2-ply and do not adjust for 1-ply. Flag non-2-ply products; report the raw per-sheet cost but explain the benchmark grade is not a like-for-like comparison.

## Response

Give the item and pack assumptions, user-supplied price, total sheets, base cents per sheet, price-only letter grade, and a compact table for 0/5/10/15% extra discount showing scenario price, cents per sheet, and how many of the three benchmarks it meets. Include quality-adjusted grade only when supported. Briefly note source uncertainty and any ply limitation. Never replace the user's price with a page price.
