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
    mo.md(r"""# Ex 4.215 — exercise hours by sex

Port of `UnitB/ch04/ex4.215.jl`. Draw 2000 resamples from each sex's `Exercise`,
run a paired t-test, and histogram the difference. Resampling is random, so
values differ from the Julia run.""")
    return


@app.cell
def _(lock5, np, pl):
    desc = lock5.Lock5Table(391, "ExerciseHours", "Exercise Hours diff in boy and girl",
                            ["Sex", "Exercise"])
    data = lock5.load_data(desc.name).select(desc.feature).group_by(desc.feature[0], maintain_order=True).agg(pl.col(desc.feature[1]))
    rng = np.random.default_rng(3434)
    d1 = rng.choice(np.asarray(data.row(0)[1], dtype=float), 2000, replace=True)
    d2 = rng.choice(np.asarray(data.row(1)[1], dtype=float), 2000, replace=True)
    return d1, d2, data, desc


@app.cell
def _(d1, d2, lock5, mo):
    res = lock5.paired_ttest(d1, d2)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


@app.cell
def _(d1, d2, plt):
    diff = d1 - d2
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.hist(diff, bins=15, color="gray", alpha=0.6, edgecolor="black", linewidth=1)
    ax.set_title("Difference in exercise hours (resampled)")
    ax.set_xlabel("difference")
    ax.set_ylabel("Frequency")
    fig
    return diff, fig, ax


if __name__ == "__main__":
    app.run()
