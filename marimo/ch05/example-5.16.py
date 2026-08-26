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
    mo.md(r"""# Example 5.16 — Bootstrap sampling distribution of Atlanta commute time

Port of `UnitC/ch05/example-5.16.jl`: bootstrap the mean of `CommuteAtlanta.Time`
(1000 resamples) and show the dot plot of the bootstrap distribution.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(423, "CommuteAtlanta", "example5.16", ["Time"])
    data = lock5.load_csv(desc.name)
    n_boot = 1000
    cil = 0.95
    return desc, data, n_boot, cil


@app.cell
def _(data, lock5, n_boot, np):
    boots = lock5.boot_sampling(data["Time"].to_numpy(), n=n_boot, method=np.mean)
    est, lo, hi = lock5.basic_confint(boots, np.mean(data["Time"].to_numpy()), level=0.95)
    return boots, est, lo, hi


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
def _(boots, lock5, plt):
    fig, ax = lock5.plot_dotplot(boots, nbins=60, title="Bootstrap means (60 bins)", xlabel="mean Time")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
