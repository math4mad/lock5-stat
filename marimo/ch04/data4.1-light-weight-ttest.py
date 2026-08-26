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
    mo.md(r"""# Data 4.1 — Does light at night affect weight gain?

Port of `UnitB/ch04/data4.1-light-weight-ttest.jl`. Two-sample equal-variance
t-test of `BMGain` between the `Light` and `Dark` groups.""")
    return


@app.cell
def _(lock5, np, pl):
    desc = lock5.Lock5Table(302, "LightatNight", "data4.1 Does Light at Night Affect Weight Gain?",
                            ["Group", "BMGain"])
    df = lock5.load_csv(desc.name)
    gdf = df.group_by("Group", maintain_order=True).agg(pl.col("BMGain"))
    g1 = np.asarray(gdf.row(0)[1], dtype=float)
    g2 = np.asarray(gdf.row(1)[1], dtype=float)
    return desc, df, g1, g2, gdf


@app.cell
def _(g1, g2, lock5, mo):
    res = lock5.equal_var_ttest(g1, g2)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
