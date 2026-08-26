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
    mo.md(r"""# MLB salary — confidence interval from repeated sampling

Port of `UnitB/ch03/mlb-salary-tabletranformers.jl`. Repeatedly sample n = 30
salaries (2000 times) and compute a mean ± 2·SE interval. Resampling results are
random, so values differ from the Julia run.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(239, "BaseballSalaries2019", "mean diff", ["Name", "Salary"])
    data = lock5.load_data(desc.name).select(desc.feature[1])
    salaries = data["Salary"].to_numpy().astype(float)
    return data, desc, salaries


@app.cell
def _(lock5, mo, np, pl, salaries):
    rng = np.random.default_rng(1)
    sample2000 = np.array([float(rng.choice(salaries, 30, replace=True).mean()) for _ in range(2000)])
    m = float(sample2000.mean())
    se = float(sample2000.std(ddof=1))
    lo, hi = m - 2 * se, m + 2 * se
    res_df = pl.DataFrame({
        "item": ["mean of 2000 sample means", "standard error", "mean - 2SE", "mean + 2SE"],
        "value": [round(m, 3), round(se, 3), round(lo, 3), round(hi, 3)],
    })
    mo.Html(lock5.gt_table(res_df, title="Sampling distribution of the mean").as_raw_html())
    return hi, lo, m, res_df, sample2000, se


if __name__ == "__main__":
    app.run()
