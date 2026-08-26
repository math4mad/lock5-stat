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
    mo.md(r"""# Ex 6.100 — Bootstrap mean of computer hours (PASeniors)

Port of `UnitC/ch06/ex-6.100.jl`: bootstrap the mean `PASeniors.ComputerHours`.""")
    return


@app.cell
def _(lock5, np):
    desc = lock5.Lock5Table(460, "PASeniors", "ComputerTime", ["ComputerHours"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    hours = data["ComputerHours"].to_numpy().astype(float)
    boots = lock5.boot_sampling(hours, n=1000, method=np.mean)
    est, lo, hi = lock5.basic_confint(boots, np.mean(hours), level=0.95)
    return desc, data, hours, boots, est, lo, hi


@app.cell
def _(GT, est, hi, lo, mo, pl):
    ci_df = pl.DataFrame({
        "estimate": [round(est, 6)],
        "lower (basic CI)": [round(lo, 6)],
        "upper (basic CI)": [round(hi, 6)],
    })
    mo.Html(GT(ci_df).tab_header(title="Bootstrap mean ComputerHours — 95% basic CI").as_raw_html())
    return


if __name__ == "__main__":
    app.run()
