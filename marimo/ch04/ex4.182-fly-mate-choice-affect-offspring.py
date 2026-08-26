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
    mo.md(r"""# Ex 4.182 — mate choice and offspring viability

Port of `UnitB/ch04/ex4.182-fly-mate-choice-affect-offspring.jl`. Fisher exact
test of the two choice groups, plus a one-sample t-test of `Difference`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(369, "MateChoice", "果蝇对交配对象的选择是否影响到后代的存活力?",
                            ["Choice", "NoChoice", "Difference"])
    data = lock5.load_data(desc.name).select(desc.feature[2])
    return data, desc


@app.cell
def _(lock5, mo):
    res = lock5.fisher_exact_test(6067, 10000, 5967, 10000)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


@app.cell
def _(data, lock5, mo):
    res2 = lock5.one_sample_ttest(data["Difference"].to_numpy().astype(float), 0)
    mo.Html(lock5.gt_ttest(res2).as_raw_html())
    return res2


if __name__ == "__main__":
    app.run()
