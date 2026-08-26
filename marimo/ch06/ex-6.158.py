import marimo

__generated_with = "0.24.0"
app = marimo.App(width="medium")


@app.cell
def _():
    import marimo as mo
    import sys
    from pathlib import Path
    import numpy as np
    import polars as pl
    import matplotlib.pyplot as plt
    from scipy import stats
    from great_tables import GT
    _p = Path(mo.notebook_location()).resolve().parent
    while _p != _p.parent and not (_p / "lock5.py").exists():
        _p = _p.parent
    if str(_p) not in sys.path:
        sys.path.insert(0, str(_p))
    import lock5
    return mo, sys, Path, np, pl, plt, stats, GT, lock5


@app.cell
def _(mo):
    mo.md(r"""# Ex 6.158 — Public libraries and sex (Fisher's exact test)

Port of `UnitC/ch06/ex-6.158.jl`.  Contingency table:

| | Yes | No | Total |
|---|---|---|---|
| Females | 726 | 697 | 1423 |
| Males | 505 | 824 | 1329 |
| Total | 1231 | 1521 | 2752 |""")
    return


@app.cell
def _(lock5):
    a = 726   # Females, Yes
    c = 1423  # Females, Total
    b = 505   # Males, Yes
    d = 1329  # Males, Total
    return a, b, c, d


@app.cell
def _(a, b, c, d, lock5, mo):
    res = lock5.fisher_exact_test(a, b, c, d)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


@app.cell
def _(GT, a, b, c, d, mo, pl):
    diff = a / c - b / d
    ans_df = pl.DataFrame({
        "difference of proportions (a/c - b/d)": [round(diff, 4)],
        "interpretation": ["the proportion of women visiting the library is significantly higher than men's"],
    })
    mo.Html(GT(ans_df).tab_header(title="Interpretation").as_raw_html())
    return


if __name__ == "__main__":
    app.run()
