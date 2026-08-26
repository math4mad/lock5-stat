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
    mo.md(r"""# Baseball salaries — sampling distribution dot plot

Port of `UnitB/ch03/baseball-salary-dot-plot.jl`. Draw 2000 samples of n = 30
salaries and dot-plot the sample means around the population mean. Resampling
results are random, so values differ from the Julia run.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(239, "BaseballSalaries2019", "sampling distribution", ["Name", "Salary"])
    data = lock5.load_csv(desc.name).select(desc.feature[1])
    salaries = data["Salary"].to_numpy().astype(float)
    mu = float(salaries.mean())
    return data, desc, mu, salaries


@app.cell
def _(mu, np, salaries):
    rng = np.random.default_rng(1)
    sample2000 = np.round([float(rng.choice(salaries, 30, replace=True).mean()) for _ in range(2000)], 1)
    return sample2000


@app.cell
def _(mu, np, plt, sample2000):
    fig, ax = plt.subplots(figsize=(12, 5))
    unique = np.unique(sample2000)
    for u in unique:
        cnt = int((sample2000 == u).sum())
        for y in range(1, cnt + 1):
            ax.scatter(u, y, s=8, color="black", edgecolors="none")
    ax.axvline(mu, color="red", linewidth=2, label="population mean")
    ax.set_title("MLB player salary sampling distribution (n=30, 2000 samples)")
    ax.set_xlabel("Salary")
    ax.set_ylabel("Count")
    ax.legend()
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
