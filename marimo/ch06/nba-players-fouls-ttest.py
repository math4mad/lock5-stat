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
    mo.md(r"""# NBA players — do they average 160 fouls?

Port of `UnitC/ch06/nba-players-fouls-ttest.jl`: one-sample t-test of
`NBAPlayers2019.Fouls` against μ = 160.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(491, "NBAPlayers2019", "Are player has 160 fouls average?", ["Fouls"])
    mu0 = 160
    return desc, mu0


@app.cell
def _(desc, lock5, mo, mu0):
    res = lock5.single_sample_ttest(desc, mu0)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
