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
    mo.md(r"""# Example 2.9 — StudentSurvey distributions (Pulse, Exercise, Piercings)

Port of `UnitA/ch02/example2.9.jl`. Density estimates (KDE) of three variables,
with histograms overlaid for reference.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(81, "StudentSurvey", "studentsuvey two way table ",
                            ["Pulse", "Exercise", "Piercings"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return data


@app.cell
def _(data, plt, stats):
    fig, axes = plt.subplots(1, 3, figsize=(13, 4))
    for ax, fe in zip(axes, data.columns):
        vals = data[fe].to_numpy().astype(float)
        ax.hist(vals, bins="auto", density=True, color="green", alpha=0.15,
                edgecolor="black", linewidth=1)
        xs = np.linspace(vals.min(), vals.max(), 200)
        kde = stats.gaussian_kde(vals)
        ax.plot(xs, kde(xs), color="green", linewidth=2)
        ax.set_xlabel(fe)
        ax.set_ylabel("density")
        ax.set_title(fe)
    fig.tight_layout()
    fig
    return fig, axes


if __name__ == "__main__":
    app.run()
