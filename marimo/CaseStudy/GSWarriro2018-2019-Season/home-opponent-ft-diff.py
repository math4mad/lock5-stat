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
    mo.md(r"""# Warriors vs opponents free-throw percentage (Fisher)

Port of `UnitC/CaseStudy/GSWarriro2018-2019-Season/home-opponent-ft-diff.jl`:
Fisher's exact test on `(sum FT, sum OppFT)` with totals `(sum FTA, sum OppFTA)`.""")
    return


@app.cell
def _(lock5):
    data = lock5.load_data("GSWarriors2019")
    gsft = int(data["FT"].sum())
    gsfta = int(data["FTA"].sum())
    oppft = int(data["OppFT"].sum())
    oppfta = int(data["OppFTA"].sum())
    return data, gsft, gsfta, oppft, oppfta


@app.cell
def _(gsft, gsfta, lock5, mo, oppft, oppfta):
    res = lock5.fisher_exact_test(gsft, oppft, gsfta, oppfta)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
