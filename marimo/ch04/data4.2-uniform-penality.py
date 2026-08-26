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
    mo.md(r"""# Data 4.2 — Malevolent uniforms and penalties

Port of `UnitB/ch04/data4.2-uniform-penality.jl`. Scatter and correlation of
`NFL_Malevolence` vs `ZPenYds`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(307, "MalevolentUniformsNFL", "data4.2 Do Teams with Malevolent Uniforms Get More Penalties?",
                            ["NFLTeam", "NFL_Malevolence", "ZPenYds"])
    df = lock5.load_csv(desc.name).select(desc.feature[1:])
    return desc, df


@app.cell
def _(df, lock5):
    fig, ax = lock5.plot_pair_cor(df)
    fig
    return fig, ax


@app.cell
def _(df, lock5, mo):
    cor = lock5.pair_corletation(df, dig=4)
    mo.md(f"**Correlation (NFL_Malevolence, ZPenYds)** = `{cor}`")
    return cor


if __name__ == "__main__":
    app.run()
