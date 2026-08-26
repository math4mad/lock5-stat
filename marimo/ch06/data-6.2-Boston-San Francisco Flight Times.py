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
    mo.md(r"""# Data 6.2 — Boston/San Francisco flight times (bootstrap)

Port of `UnitC/ch06/data-6.2-Boston-San Francisco Flight Times.jl`: bootstrap the
mean `Flight433.AirTime` and show a dot plot.""")
    return


@app.cell
def _(lock5, np):
    desc = lock5.Lock5Table(456, "Flight433", "Boston/San Francisco Flight Times", ["AirTime"])
    data = lock5.load_csv(desc.name)
    n_boot = 1000
    cil = 0.95
    airtime = data["AirTime"].to_numpy().astype(float)
    boots = lock5.boot_sampling(airtime, n=n_boot, method=np.mean)
    est, lo, hi = lock5.basic_confint(boots, np.mean(airtime), level=cil)
    return desc, data, airtime, boots, est, lo, hi


@app.cell
def _(GT, est, hi, lo, mo, pl):
    ci_df = pl.DataFrame({
        "estimate": [round(est, 4)],
        "lower (basic CI)": [round(lo, 4)],
        "upper (basic CI)": [round(hi, 4)],
    })
    mo.Html(GT(ci_df).tab_header(title="Bootstrap mean — 95% basic CI").as_raw_html())
    return


@app.cell
def _(airtime, lock5, plt):
    fig, ax = lock5.plot_dotplot(airtime, nbins=20, title="Flight433 AirTime (20 bins)", xlabel="AirTime")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
