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
    mo.md(r"""# Home vs away free-throw attempts (Welch t-test)

Port of `UnitC/CaseStudy/GSWarriro2018-2019-Season/home-ft-rating.jl`: compare
home and away `FTA` with an unequal-variance (Welch) t-test.""")
    return


@app.cell
def _(lock5, np):
    desc = lock5.Lock5Table(537, "GSWarriors2019", "statistics", ["Location", "FTA", "FT", "OppFTA", "OppFT"])
    data = lock5.load_csv(desc.name).select(["Location", "FTA"])
    groups = data.group_by("Location", maintain_order=True).agg(pl.col("FTA"))
    home = np.asarray(groups.row(0)[1], dtype=float)
    away = np.asarray(groups.row(1)[1], dtype=float)
    return desc, data, home, away


@app.cell
def _(away, home, lock5, mo):
    res = lock5.unequal_var_ttest(home, away)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
