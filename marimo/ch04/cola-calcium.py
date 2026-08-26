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
    mo.md(r"""# Cola and calcium

Port of `UnitB/ch04/cola-calcium.jl`. Two-sample equal-variance t-test of
`Calcium` between `Diet cola` and `Water` drinkers.""")
    return


@app.cell
def _(lock5, np, pl):
    df = lock5.load_data("ColaCalcium").group_by("Drink", maintain_order=True).agg(pl.col("Calcium"))
    g1 = np.asarray(df.row(0)[1], dtype=float)
    g2 = np.asarray(df.row(1)[1], dtype=float)
    return df, g1, g2


@app.cell
def _(g1, g2, lock5, mo):
    res = lock5.equal_var_ttest(g1, g2)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
