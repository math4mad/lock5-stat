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
    mo.md(r"""# Mustang price — bootstrap correlation

Port of `UnitB/ch03/mustang-price-cor-bs.jl`. Bootstrap the correlation between
`Miles` and `Price` (1000 resamples) and dot-plot the bootstrap correlations.
Bootstrap results are random, so values differ from the Julia run.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(289, "MustangPrice", "corelation bootstrap sampling", ["Miles", "Price"])
    data = lock5.load_data(desc.name).select(desc.feature)
    return data, desc


@app.cell
def _(data, lock5):
    x = data["Miles"].to_numpy().astype(float)
    y = data["Price"].to_numpy().astype(float)
    cor_obs = float(np.corrcoef(x, y)[0, 1])
    boots = lock5.boot_correlation(x, y, n=1000, seed=1)
    bci = lock5.basic_confint(boots, cor_obs, 0.95)
    return bci, boots, cor_obs


@app.cell
def _(bci, cor_obs, lock5, mo, pl):
    res_df = pl.DataFrame({
        "item": ["observed correlation", "basic 95% CI lower", "basic 95% CI upper"],
        "value": [round(cor_obs, 2), round(bci[1], 2), round(bci[2], 2)],
    })
    mo.Html(lock5.gt_table(res_df, title="Bootstrap correlation CI").as_raw_html())
    return res_df


@app.cell
def _(boots, lock5):
    rounded = np.round(boots, 2)
    fig, ax = lock5.plot_dotplot(rounded, nbins=20, title="Mustang Miles-Price cor (bootstrap)",
                                 xlabel="Correlation", ylabel="Count", color="black")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
