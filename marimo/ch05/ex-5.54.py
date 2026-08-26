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
    mo.md(r"""# Ex 5.54 — Linear regression of MustangPrice: Price ~ Miles

Port of `UnitC/ch05/ex-5.54.jl`: fit `Price ~ Miles`, plot data + fitted line,
then bootstrap the slope's standard error.""")
    return


@app.cell
def _(lock5):
    import statsmodels.api as sm

    desc = lock5.Lock5Table(429, "MustangPrice", "ex-5.53", ["Miles", "Price"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    x = data["Miles"].to_numpy().astype(float)
    y = data["Price"].to_numpy().astype(float)
    model = sm.OLS(y, sm.add_constant(x)).fit()
    slope = float(model.params[1])
    intercept = float(model.params[0])
    return sm, desc, data, x, y, model, slope, intercept


@app.cell
def _(GT, mo, model, pl):
    ci = model.conf_int(alpha=0.05)
    coef_df = pl.DataFrame({
        "term": ["(Intercept)", "Miles"],
        "coef": model.params.tolist(),
        "std err": model.bse.tolist(),
        "t": model.tvalues.tolist(),
        "p-value": model.pvalues.tolist(),
        "lower 95%": ci[:, 0].tolist(),
        "upper 95%": ci[:, 1].tolist(),
    })
    mo.Html(GT(coef_df).tab_header(title="Price ~ Miles (OLS)").fmt_number(
        columns=["coef", "std err", "t", "lower 95%", "upper 95%"], decimals=6).as_raw_html())
    return


@app.cell
def _(intercept, lock5, plt, slope, x, y):
    fig, ax = lock5.scatter_fit(x, y, slope, intercept, xlabel="Miles", ylabel="Price")
    fig
    return fig, ax


@app.cell
def _(data, np, sm):
    rng = np.random.default_rng(1)
    slopes = []
    for _ in range(1000):
        idx = rng.integers(0, 25, 100)
        sub = data[idx]
        xs = sub["Miles"].to_numpy().astype(float)
        ys = sub["Price"].to_numpy().astype(float)
        m = sm.OLS(ys, sm.add_constant(xs)).fit()
        slopes.append(m.params[1])
    slope_se = float(np.std(slopes, ddof=1))
    return slopes, slope_se


@app.cell
def _(GT, mo, pl, slope_se):
    se_df = pl.DataFrame({"slope standard error (bootstrap)": [round(slope_se, 6)]})
    mo.Html(GT(se_df).tab_header(title="Bootstrap standard error of the slope").as_raw_html())
    return


if __name__ == "__main__":
    app.run()
