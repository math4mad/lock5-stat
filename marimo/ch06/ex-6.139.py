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
    mo.md(r"""# Ex 6.139 — Baseball team batting averages

Port of `UnitC/ch06/ex-6.139.jl`: summary statistics of `BaseballHits2019.BattingAvg`
and a one-sample t-test against μ = 0.260.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(468, "BaseballHits2019", "BaseBall Team Statistics", ["Team", "BattingAvg"])
    data = lock5.load_csv(desc.name)
    batting = data["BattingAvg"].to_numpy().astype(float)
    s = lock5.summarystats(batting)
    n_teams = data["Team"].n_unique()
    return desc, data, batting, s, n_teams


@app.cell
def _(GT, mo, pl, s):
    s_df = pl.DataFrame({
        "statistic": ["n", "mean", "min", "1st quartile", "median", "3rd quartile", "max"],
        "value": [float(s["n"]), float(round(s["mean"], 6)), float(s["min"]), float(round(s["q1"], 6)), float(round(s["median"], 6)), float(round(s["q3"], 6)), float(s["max"])],
    })
    mo.Html(GT(s_df).tab_header(title="BattingAvg summary statistics").as_raw_html())
    return


@app.cell
def _(GT, mo, n_teams, pl):
    mo.Html(GT(pl.DataFrame({"number of teams": [n_teams]})).tab_header(title="Team count").as_raw_html())
    return


@app.cell
def _(batting, lock5, mo):
    res = lock5.one_sample_ttest(batting, 0.260)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
