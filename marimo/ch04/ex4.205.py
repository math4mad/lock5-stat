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
    mo.md(r"""# Ex 4.205 — sleep, caffeine and memory

Port of `UnitB/ch04/ex4.205.jl`. Draw 1000 resamples from each `Group`'s `Words`,
then run an F-test and a Welch (unequal-variance) t-test. Resampling is random,
so values differ from the Julia run.""")
    return


@app.cell
def _(lock5, np, pl):
    desc = lock5.Lock5Table(389, "SleepCaffeine", "Effect of Sleep and Caffeine on Memory?",
                            ["Group", "Words"])
    gdf = lock5.load_data(desc.name).group_by("Group", maintain_order=True).agg(pl.col("Words"))
    rng = np.random.default_rng(3434)
    data1 = rng.choice(np.asarray(gdf.row(0)[1], dtype=float), 1000, replace=True)
    data2 = rng.choice(np.asarray(gdf.row(1)[1], dtype=float), 1000, replace=True)
    return data1, data2, desc, gdf


@app.cell
def _(data1, data2, lock5, mo, pl):
    f_res = lock5.variance_ftest(data1, data2)
    f_df = pl.DataFrame({"item": list(f_res.keys()), "value": [str(v) for v in f_res.values()]})
    mo.Html(lock5.gt_table(f_df, title="Variance F-test").as_raw_html())
    return f_df, f_res


@app.cell
def _(data1, data2, lock5, mo):
    res = lock5.unequal_var_ttest(data1, data2)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
