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
    mo.md(r"""# Ex 6.249 — Split the bill? (cost by sex)

Port of `UnitC/ch06/ex-6.249.jl`: compare `Cost` between female and male diners,
then run `pair_ttest` on the summary.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(501, "SplitBill", "Split the Bill?", ["Sex", "Cost"])
    df = lock5.load_csv(desc.name)
    group, data, summary = lock5.group_summary(df, desc.feature[0], desc.feature[1])
    return desc, df, group, data, summary


@app.cell
def _(GT, mo, summary):
    mo.Html(GT(summary).tab_header(title="Cost by sex").fmt_number(columns=["Mean", "Stddev"], decimals=4).as_raw_html())
    return


@app.cell
def _(data, group, lock5):
    fig, ax = lock5.grouped_boxplot(group, data, title="cost in different sex", xlabel="cost", ylabel="group")
    fig
    return fig, ax


@app.cell
def _(lock5, mo, summary):
    res = lock5.pair_ttest(summary)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
