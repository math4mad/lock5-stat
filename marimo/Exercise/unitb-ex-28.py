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
    mo.md(r"""# Unit B Ex 28 — skateboard prices bootstrap

Port of `UnitB/Exercises/unitb-ex-28.jl`. Bootstrap the mean `Price` (1000
samples), report bias / std error / basic 95% CI, and histogram the bootstrap
means. Bootstrap results are random, so values differ from the Julia run.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(386, "SkateboardPrices", "Skateboard Prices?", ["Price"])
    data = lock5.load_csv(desc.name)
    prices = data["Price"].to_numpy().astype(float)
    return data, desc, prices


@app.cell
def _(lock5, mo, np, pl, prices):
    mn, sd = lock5.mean_and_std(prices)
    boots = lock5.boot_sampling(prices, n=1000, method=np.mean, seed=1)
    estimate = float(prices.mean())
    bci = lock5.basic_confint(boots, estimate, 0.95)
    res_df = pl.DataFrame({
        "item": ["mean", "std (sample)", "bias", "std error",
                 "basic 95% CI lower", "basic 95% CI upper"],
        "value": [round(mn, 4), round(sd, 4), round(float(boots.mean() - estimate), 4),
                  round(float(boots.std(ddof=1)), 4), round(bci[1], 4), round(bci[2], 4)],
    })
    mo.Html(lock5.gt_table(res_df, title="Skateboard prices bootstrap (1000 samples)").as_raw_html())
    return bci, boots, estimate, res_df


@app.cell
def _(boots, plt):
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.hist(boots, bins=8, color="gray", alpha=0.6, edgecolor="black", linewidth=1)
    ax.set_title("Bootstrap mean Price")
    ax.set_xlabel("Price")
    ax.set_ylabel("Frequency")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
