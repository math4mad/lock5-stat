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
    mo.md(r"""# SAT scores: Math vs Verbal (Ex 2.226)

Port of `UnitA/ch02/math-verbal-cor.jl`. Scatter of `MathSAT` vs `VerbalSAT`.""")
    return


@app.cell
def _(lock5):
    data = lock5.load_data("StudentSurvey").select(["MathSAT", "VerbalSAT"])
    return data


@app.cell
def _(data, lock5):
    fig, ax = lock5.plot_pair_cor(data)
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
