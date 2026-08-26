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
    mo.md(r"""# Ex 3.90 — hitchhiker snails bootstrap

Port of `UnitB/ch03/ex3.90-hitchhiker-snails-bootstrap-sampling.jl`. Bootstrap
the mean of `[26/174]` (the snail escape rate). Bootstrap results are random, so
values differ from the Julia run.""")
    return


@app.cell
def _(lock5, mo, np, pl):
    ratio = 26 / 174
    boots = lock5.boot_sampling([ratio], n=1000, method=np.mean, seed=1)
    res_df = pl.DataFrame({
        "item": ["escape ratio", "bootstrap mean", "bootstrap std"],
        "value": [round(ratio, 4), round(float(boots.mean()), 4), round(float(boots.std(ddof=1)), 4)],
    })
    mo.Html(lock5.gt_table(res_df, title="Snail escape rate bootstrap").as_raw_html())
    return boots, ratio, res_df


if __name__ == "__main__":
    app.run()
