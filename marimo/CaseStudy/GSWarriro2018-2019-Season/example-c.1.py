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
    mo.md(r"""# Example C.1 — Dot plots of the four free-throw statistics

Port of `UnitC/CaseStudy/GSWarriro2018-2019-Season/example-c.1.jl`.  The Julia
source loops over `desc.feature[1:4]` (which includes the categorical
`Location`); the four *numeric* statistics are plotted here instead.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(537, "GSWarriors2019", "statistics", ["Location", "FTA", "FT", "OppFTA", "OppFT"])
    data = lock5.load_csv(desc.name)
    features = ["FTA", "FT", "OppFTA", "OppFT"]
    return desc, data, features


@app.cell
def _(data, features, lock5, plt):
    fig, axes = plt.subplots(4, 1, figsize=(8, 12), sharey=True)
    for idx, (ax, f) in enumerate(zip(axes, features)):
        lock5.plot_dotplot(data[f].to_numpy(), ax=ax, title=f)
    fig
    return fig, axes


if __name__ == "__main__":
    app.run()
