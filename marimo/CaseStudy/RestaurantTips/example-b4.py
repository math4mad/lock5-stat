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
    mo.md(r"""# Example B.4 — Bootstrap distribution of the Tip~Bill slope

Port of `UnitB/CaseStudy-Restaurant Tips/example-b4.jl`. Draw 100 bootstrap
resamples (100 rows each, with replacement), refit `Tip ~ Bill`, and dot-plot
the resulting slopes. Bootstrap results are random, so values differ from the
Julia run (same method).""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(395, "RestaurantTips", "", ["Bill", "Tip", "Credit", "Guests", "Day", "Server", "PctTip"])
    data = lock5.load_data(desc.name).select(["Bill", "Tip"])
    bill = data["Bill"].to_numpy().astype(float)
    tip = data["Tip"].to_numpy().astype(float)
    return bill, data, desc, tip


@app.cell
def _(bill, np, stats, tip):
    rng = np.random.default_rng(343434)
    slopes = []
    for _ in range(100):
        idx = rng.integers(0, len(bill), 100)
        slopes.append(stats.linregress(bill[idx], tip[idx]).slope)
    slopes = np.asarray(slopes)
    return rng, slopes


@app.cell
def _(lock5, slopes):
    fig, ax = lock5.plot_dotplot(slopes, nbins=15, title="Bootstrap slopes (Tip ~ Bill)",
                                 xlabel="slope", ylabel="count")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
