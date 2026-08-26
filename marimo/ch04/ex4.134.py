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
    mo.md(r"""# Ex 4.134 — tears and sadness ratings

Port of `UnitB/ch04/ex4.134.jl`. One-sample t-test of `SadDiff` against μ₀ = 0.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(352, "HumanTears25", "Do Tears Subconsciously Affect Sadness Ratings?",
                            ["SexDiff", "SadDiff"])
    df = lock5.load_csv(desc.name)
    return desc, df


@app.cell
def _(df, lock5, mo):
    res = lock5.one_sample_ttest(df["SadDiff"].to_numpy().astype(float), 0)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
