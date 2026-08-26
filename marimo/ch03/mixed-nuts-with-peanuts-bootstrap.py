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
    mo.md(r"""# Mixed nuts with peanuts — bootstrap std of a proportion

Port of `UnitB/ch03/mixed-nuts-with-peanuts-bootstrap.jl`. Bootstrap the
standard deviation of `[0.52]` (the peanut proportion). Bootstrap results are
random, so values differ from the Julia run.""")
    return


@app.cell
def _(lock5, mo, np, pl):
    peanut_ratio_in_jar = 52 / 100
    boots = lock5.boot_sampling([peanut_ratio_in_jar], n=1000, method=lambda a: np.std(a, ddof=1), seed=1)
    res_df = pl.DataFrame({
        "item": ["peanut ratio", "bootstrap std"],
        "value": [peanut_ratio_in_jar, round(float(boots.mean()), 4)],
    })
    mo.Html(lock5.gt_table(res_df, title="Peanut ratio bootstrap").as_raw_html())
    return boots, peanut_ratio_in_jar, res_df


if __name__ == "__main__":
    app.run()
