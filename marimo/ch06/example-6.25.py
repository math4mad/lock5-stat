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
    mo.md(r"""# Example 6.25 — Exercise hours (can we use the t-distribution?)

Port of `UnitC/ch06/example-6.25.jl`: dot plot of the first `Sex` group
(male, since `Sex="M"` appears first in `ExerciseHours.csv`) of `Exercise`.""")
    return


@app.cell
def _(lock5, np, pl):
    desc = lock5.Lock5Table(487, "ExerciseHours", "can we use t-dist?", ["Sex", "Exercise"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    groups = data.group_by(desc.feature[0], maintain_order=True).agg(pl.col(desc.feature[1]))
    male_data = np.asarray(groups.row(0)[1], dtype=float)
    return desc, data, male_data


@app.cell
def _(lock5, male_data, plt):
    fig, ax = lock5.plot_dotplot(male_data, nbins=12, title="Exercise hours (male)", xlabel="Exercise")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
