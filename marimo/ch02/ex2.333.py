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
    mo.md(r"""# Ex 2.333 — Offensive vs defensive rebounds

Port of `UnitA/ch02/ex2.333.jl`. Scatter of `OffRebound` vs `DefRebound` plus
the correlation.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(158, "NBAPlayers2019", "Offensive Rebounds vs Defensive Rebounds",
                            ["OffRebound", "DefRebound"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return data


@app.cell
def _(data, lock5):
    fig, ax = lock5.plot_pair_cor(data)
    ax.set_xlabel("OffRebound")
    ax.set_ylabel("DefRebound")
    fig
    return fig, ax


@app.cell
def _(data, lock5, mo):
    r = lock5.pair_corletation(data)
    mo.md(f"Correlation of OffRebound and DefRebound: **{r}**")
    return r


if __name__ == "__main__":
    app.run()
