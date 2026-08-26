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
    mo.md(r"""# Ex 6.242 — Mind-Set Matters (weight change by condition)

Port of `UnitC/ch06/ex-6.242.jl`: compute `WeightDiff = Wt2 - Wt`, group by
`Cond` (0 = control, 1 = experimental), and run a two-sample t-test.""")
    return


@app.cell
def _(lock5, np, pl):
    desc = lock5.Lock5Table(499, "MindsetMatters", "MindsetMatters", ["Cond", "Wt", "Wt2"])
    df = lock5.load_csv(desc.name, drop=False).select(desc.feature)
    df = df.with_columns((pl.col("Wt2") - pl.col("Wt")).alias("WeightDiff"))
    groups = df.group_by("Cond", maintain_order=True).agg(pl.col("WeightDiff"))
    data = [np.asarray(groups.row(0)[1], dtype=float), np.asarray(groups.row(1)[1], dtype=float)]
    group = ["control", "experimental"]
    summary = lock5.summary_df(group, data)
    return desc, df, data, group, summary


@app.cell
def _(GT, mo, summary):
    mo.Html(GT(summary).tab_header(title="Weight change by condition").fmt_number(columns=["Mean", "Stddev"], decimals=4).as_raw_html())
    return


@app.cell
def _(data, group, lock5):
    fig, ax = lock5.grouped_boxplot(group, data, title="Grouped Boxplot", xlabel="loss weight", ylabel="group")
    fig
    return fig, ax


@app.cell
def _(lock5, mo, summary):
    r1 = summary.row(0)
    r2 = summary.row(1)
    res = lock5.equal_var_ttest_stats(int(r1[1]), int(r2[1]), float(r1[2]), float(r2[2]), float(r1[3]), float(r2[3]))
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
