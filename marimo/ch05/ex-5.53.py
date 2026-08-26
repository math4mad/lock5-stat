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
    mo.md(r"""# Ex 5.53 — Bootstrap confidence interval for MustangPrice.Price

Port of `UnitC/ch05/ex-5.53.jl`: 1000 bootstrap resamples of the mean price,
basic bootstrap CI, and a normal approximation from the bootstrap distribution.""")
    return


@app.cell
def _(lock5, np):
    desc = lock5.Lock5Table(428, "MustangPrice", "ex-5.53", ["Age", "Miles", "Price"])
    data = lock5.load_csv(desc.name)
    n_boot = 1000
    cil = 0.95
    price = data["Price"].to_numpy().astype(float)
    boots = lock5.boot_sampling(price, n=n_boot, method=np.mean)
    est, lo, hi = lock5.basic_confint(boots, np.mean(price), level=cil)
    return desc, data, n_boot, cil, price, boots, est, lo, hi


@app.cell
def _(GT, est, hi, lo, mo, pl):
    ci_df = pl.DataFrame({
        "estimate": [round(est, 6)],
        "lower (basic CI)": [round(lo, 6)],
        "upper (basic CI)": [round(hi, 6)],
    })
    mo.Html(GT(ci_df).tab_header(title="Bootstrap mean — 95% basic CI").as_raw_html())
    return


@app.cell
def _(boots, lock5, stats):
    m, s = lock5.mean_and_std(boots)
    dist = stats.norm(loc=m, scale=s)
    q_lo = dist.ppf(0.025)
    q_hi = dist.ppf(0.975)
    return m, s, dist, q_lo, q_hi


@app.cell
def _(GT, m, mo, pl, q_hi, q_lo, s):
    norm_df = pl.DataFrame({
        "bootstrap mean": [round(m, 6)],
        "bootstrap std": [round(s, 6)],
        "normal 2.5% quantile": [round(q_lo, 6)],
        "normal 97.5% quantile": [round(q_hi, 6)],
    })
    mo.Html(GT(norm_df).tab_header(title="Normal approximation of bootstrap distribution").as_raw_html())
    return


if __name__ == "__main__":
    app.run()
