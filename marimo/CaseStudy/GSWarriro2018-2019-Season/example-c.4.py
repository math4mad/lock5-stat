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
    mo.md(r"""# Example C.4 — Free throws made at home vs away

Port of `UnitC/CaseStudy/GSWarriro2018-2019-Season/example-c.4.jl`: compare `FT`
by `Location` with a summary table, box plot and a two-sample t-test.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(537, "GSWarriors2019", "statistics", ["Location", "FTA", "FT", "OppFTA", "OppFT"])
    data = lock5.load_csv(desc.name)
    group, group_data, summary = lock5.group_summary(data.select(["Location", "FT"]), "Location", "FT")
    return desc, data, group, group_data, summary


@app.cell
def _(GT, mo, summary):
    mo.Html(GT(summary).tab_header(title="FT by location").fmt_number(columns=["Mean", "Stddev"], decimals=4).as_raw_html())
    return


@app.cell
def _(group, group_data, lock5):
    fig, ax = lock5.grouped_boxplot(group, group_data, title="ft in home and away", xlabel="ft", ylabel="group")
    fig
    return fig, ax


@app.cell
def _(lock5, mo, summary):
    res = lock5.pair_ttest(summary)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
