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
    mo.md(r"""# Case study — Sleep Study data

Port of `UnitA/CaseStudy/dataA.1.jl`. Load `SleepStudy` and list its features.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(201, "SleepStudy", "Sleep Study with College Students", [])
    df = lock5.load_csv(desc.name)
    return desc, df


@app.cell
def _(df, mo):
    mo.md("Columns: " + ", ".join(f"`{c}`" for c in df.columns))
    return


if __name__ == "__main__":
    app.run()
