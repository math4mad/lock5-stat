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
    mo.md(r"""# Data 3.1 — MLB salary sampling variability

Port of `UnitB/ch03/data3.1-mlb-salary.jl`. Repeatedly draw samples of n = 30
salaries and study how the sample mean varies around the population mean.
Resampling results are random, so values differ from the Julia run.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(239, "BaseballSalaries2019", "meta statistics", ["Name", "Salary"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    salaries = data["Salary"].to_numpy().astype(float)
    mu = float(round(salaries.mean(), 3))
    return data, desc, mu, salaries


@app.cell
def _(mu, np, salaries):
    rng = np.random.default_rng(1)
    def mean_30():
        return round(float(rng.choice(salaries, 30, replace=True).mean()), 3)
    means_arr = np.array([mean_30() for _ in range(100)])
    residual = np.round(means_arr - mu, 3)
    return means_arr, residual, rng


@app.cell
def _(mu, np, plt, residual, salaries):
    rng2 = np.random.default_rng(2)
    means2000 = np.array([float(rng2.choice(salaries, 30, replace=True).mean()) for _ in range(2000)])
    rng3 = np.random.default_rng(3)
    means1000 = np.array([float(rng3.choice(salaries, 30, replace=True).mean()) for _ in range(1000)])
    se = round(float(np.std(means1000, ddof=1)), 3)
    fig, ax = plt.subplots(figsize=(8, 3))
    ax.stem(np.arange(1, len(residual) + 1), residual, basefmt=" ")
    ax.set_title("Sample mean residual vs population mean")
    ax.set_xlabel("trial"); ax.set_ylabel("residual")
    fig
    return ax, fig, means1000, means2000, se


@app.cell
def _(lock5, mo, pl, se):
    res_df = pl.DataFrame({"statistic": ["standard error of 1000 sample means"], "value": [se]})
    mo.Html(lock5.gt_table(res_df, title="Standard error").as_raw_html())
    return res_df


if __name__ == "__main__":
    app.run()
