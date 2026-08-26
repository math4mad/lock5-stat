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
    mo.md(r"""# Example C.5 — Free-throw attempt difference vs opponent

Port of `UnitC/CaseStudy/GSWarriro2018-2019-Season/example-c.5.jl`: compute
`FTADiff = FTA - OppFTA` and run a one-sample t-test (μ = 0).""")
    return


@app.cell
def _(lock5, np, pl):
    desc = lock5.Lock5Table(537, "GSWarriors2019", "statistics", ["Location", "FTA", "FT", "OppFTA", "OppFT"])
    data = lock5.load_csv(desc.name)
    df = data.select(["FTA", "OppFTA"]).with_columns((pl.col("FTA") - pl.col("OppFTA")).alias("FTADiff"))
    return desc, data, df


@app.cell
def _(df, lock5, plt):
    fig, ax = lock5.plot_dotplot(df["FTADiff"].to_numpy(), title="FTA - OppFTA", xlabel="FTADiff")
    fig
    return fig, ax


@app.cell
def _(df, lock5, mo):
    res = lock5.one_sample_ttest(df["FTADiff"].to_numpy(), 0.0)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
