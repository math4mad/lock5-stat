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
    mo.md(r"""# Ex 4.132–3 — heat and reaction time

Port of `UnitB/ch04/ex4.132-3-heat-effect-cognition.jl`. Two-sample t-tests of
`MathZRT` and `ColorsZRT` between AC groups.""")
    return


@app.cell
def _(lock5):
    desc1 = lock5.Lock5Table(351, "HeatCognition", "Does Heat Affect Math Reaction Time?", ["AC", "MathZRT"])
    desc2 = lock5.Lock5Table(352, "HeatCognition", "Does Heat Affect Color Dissonance Reaction Time?", ["AC", "ColorsZRT"])
    return desc1, desc2


@app.cell
def _(desc1, lock5, mo):
    res1 = lock5.make_ttest(desc1)
    mo.Html(lock5.gt_ttest(res1).as_raw_html())
    return res1


@app.cell
def _(desc2, lock5, mo):
    res2 = lock5.make_ttest(desc2)
    mo.Html(lock5.gt_ttest(res2).as_raw_html())
    return res2


if __name__ == "__main__":
    app.run()
