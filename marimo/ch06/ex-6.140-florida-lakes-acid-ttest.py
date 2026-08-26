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
    mo.md(r"""# Ex 6.140 — Are Florida lakes acidic or alkaline? (pH t-test)

Port of `UnitC/ch06/ex-6.140-florida-lakes-acid-ttest.jl`: test pH against μ = 7.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(468, "FloridaLakes", "Are Florida Lakes Acidic or Alkaline?", ["pH"])
    data = lock5.load_csv(desc.name)
    return desc, data


@app.cell
def _(data, lock5, mo):
    res = lock5.one_sample_ttest(data["pH"].to_numpy(), 7.0)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
