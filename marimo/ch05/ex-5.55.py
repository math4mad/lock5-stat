import marimo

__generated_with = "0.24.0"
app = marimo.App(width="1000")


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
    mo.md(r"""# Ex 5.55 — Bootstrap standard error of the correlation

Port of `UnitC/ch05/ex-5.55.jl`: resample `CommuteAtlanta[Distance, Time]`
1000 times (300 rows each) and compute the standard deviation of the
correlation coefficient.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(429, "CommuteAtlanta", "ex-5.55", ["Distance", "Time"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return desc, data


@app.cell
def _(data, np):
    rng = np.random.default_rng(1)
    cor_arr = []
    n = data.height
    for _ in range(1000):
        idx = rng.integers(0, n, 300)
        sub = data[idx]
        xs = sub["Distance"].to_numpy().astype(float)
        ys = sub["Time"].to_numpy().astype(float)
        cor_arr.append(np.corrcoef(xs, ys)[0, 1])
    cor_std = float(np.std(cor_arr, ddof=1))
    return cor_arr, cor_std


@app.cell
def _(GT, cor_std, mo, pl):
    se_df = pl.DataFrame({"correlation standard error (bootstrap)": [round(cor_std, 6)]})
    mo.Html(GT(se_df).tab_header(title="Bootstrap std of cor(Distance, Time)").as_raw_html())
    return


if __name__ == "__main__":
    app.run()
