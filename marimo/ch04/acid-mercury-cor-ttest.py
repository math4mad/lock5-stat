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
    mo.md(r"""# Acid–mercury correlation test

Port of `UnitB/ch04/acid-mercury-cor-ttest.jl`. Test whether `pH` and
`AvgMercury` are correlated.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(348, "FloridaLakes", "Water pH vs mercury has negative relationship",
                            ["pH", "AvgMercury"])
    return desc


@app.cell
def _(desc, lock5, mo):
    res = lock5.make_cor_ttest(desc)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
