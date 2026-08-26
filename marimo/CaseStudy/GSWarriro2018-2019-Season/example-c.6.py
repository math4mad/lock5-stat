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
    mo.md(r"""# Example C.6 — Warriors vs opponents shooting percentage (Fisher)

Port of `UnitC/CaseStudy/GSWarriro2018-2019-Season/example-c.6.jl`: Fisher's
exact test on the aggregated FT/FTA vs OppFT/OppFTA counts.""")
    return


@app.cell
def _(lock5, np):
    desc = lock5.Lock5Table(537, "GSWarriors2019", "statistics", ["Location", "FTA", "FT", "OppFTA", "OppFT"])
    data = lock5.load_csv(desc.name)
    a = int(data["FT"].sum())
    c = int(data["FTA"].sum())
    b = int(data["OppFT"].sum())
    d = int(data["OppFTA"].sum())
    return desc, data, a, b, c, d


@app.cell
def _(a, b, c, d, lock5, mo):
    res = lock5.fisher_exact_test(a, b, c, d)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
