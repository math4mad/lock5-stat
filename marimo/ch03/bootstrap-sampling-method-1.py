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
    mo.md(r"""# Bootstrap sampling — method 1 (std of a salary sample)

Port of `UnitB/ch03/bootstrap-sampling-method-1.jl`. Bootstrap the *standard
deviation* of a 30-salary sample (sample std uses `ddof = 1`, matching
StatsBase `std`). Bootstrap results are random, so values differ from Julia.""")
    return


@app.cell
def _(lock5):
    data = lock5.load_data("BaseballSalaries2019").select("Salary")["Salary"].to_numpy().astype(float)
    return data


@app.cell
def _(data, lock5, mo, np, pl):
    rng = np.random.default_rng(3434343)
    sample = rng.choice(data, 30, replace=True)
    boots = lock5.boot_sampling(sample, n=1000, method=lambda a: np.std(a, ddof=1), seed=3434343)
    estimate = float(np.std(sample, ddof=1))
    bci = lock5.basic_confint(boots, estimate, 0.95)
    res_df = pl.DataFrame({
        "item": ["estimate (std)", "bias", "std error", "basic 95% CI lower", "basic 95% CI upper"],
        "value": [round(estimate, 2), round(float(boots.mean() - estimate), 2),
                  round(float(boots.std(ddof=1)), 2), round(bci[1], 2), round(bci[2], 2)],
    })
    mo.Html(lock5.gt_table(res_df, title="Bootstrap std (1000 samples)").as_raw_html())
    return bci, boots, estimate, res_df, sample


if __name__ == "__main__":
    app.run()
