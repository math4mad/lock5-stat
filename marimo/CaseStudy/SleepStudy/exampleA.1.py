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
    mo.md(r"""# Example A.1 — Sleep Study dimensions

Port of `UnitA/CaseStudy/exampleA.1.jl`. Shape of the dataset (expected 253 × 27).""")
    return


@app.cell
def _(lock5):
    df = lock5.load_csv("SleepStudy")
    return df


@app.cell
def _(df, mo):
    rows, cols = df.shape
    mo.md(f"SleepStudy has **{rows}** rows and **{cols}** columns.")
    return cols, rows


if __name__ == "__main__":
    app.run()
