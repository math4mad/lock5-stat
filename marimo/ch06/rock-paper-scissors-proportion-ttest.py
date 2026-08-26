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
    mo.md(r"""# Rock–Paper–Scissors — proportion t-test

Is the probability of throwing "rock" first 1/3?

> This stub (`UnitC/ch06/rock-paper-scissors-proprotion-ttest.jl`) only carries a
> docstring in the Julia source; the full analysis lives in
> `data-6.1-proportion-ttest.py`, where `BinomialTest(66, 119, 1/3)` rejects the
> null hypothesis.""")
    return


if __name__ == "__main__":
    app.run()
