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
    mo.md(r"""# Ex 6.60 — Is B a good choice on a multiple-choice exam?

Port of `UnitC/ch06/ex-6.60-multiple-choice-exam.jl`: test whether answer "B"
appears more often than the 1/5 expected by chance.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(447, "APMultipleChoice", "Is B a Good Choice on a Multiple-Choice Exam?", ["Answer"])
    df = lock5.load_csv(desc.name)
    b_count = df.filter(pl.col("Answer") == "B").height
    n = df.height
    cats = df["Answer"].n_unique()
    return desc, df, b_count, n, cats


@app.cell
def _(b_count, cats, lock5, mo, n):
    res = lock5.binomial_test(b_count, n, 1 / cats)
    mo.Html(lock5.gt_proportion(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
