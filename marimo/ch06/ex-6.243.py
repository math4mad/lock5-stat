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
    mo.md(r"""# Ex 6.243 — Exercise enhances anti-depression? (StressedMice)

Port of `UnitC/ch06/ex-6.243.jl`: compare time in the dark between `Enriched` and
`Standard` environments, then run a two-sample t-test.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(499, "StressedMice", "exercise enhance anti-drepression", ["Time", "Environment"])
    df = lock5.load_csv(desc.name, drop=False).select(desc.feature)
    group, data, summary = lock5.group_summary(df, desc.feature[1], desc.feature[0])
    return desc, df, group, data, summary


@app.cell
def _(GT, mo, summary):
    mo.Html(GT(summary).tab_header(title="Time in dark by environment").fmt_number(columns=["Mean", "Stddev"], decimals=4).as_raw_html())
    return


@app.cell
def _(data, group, lock5):
    fig, ax = lock5.grouped_boxplot(group, data, title="time in dark place", xlabel="time", ylabel="group")
    fig
    return fig, ax


@app.cell
def _(lock5, mo, summary):
    res = lock5.pair_ttest(summary)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
