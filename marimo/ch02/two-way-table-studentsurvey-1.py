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
    mo.md(r"""# Two-way table — StudentSurvey Sex × Award

Port of `UnitA/ch02/two-way-table-studentsurvey-1.jl`. Contingency table of
`Sex` (rows) by `Award` (columns) with row/column totals.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(81, "StudentSurvey", "studentsuvey two way table ",
                            ["Sex", "Award"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return data


@app.cell
def _(data, lock5, mo, pl):
    award_cols = ["Academy", "Nobel", "Olympic"]
    ct = lock5.freqtable(data, "Sex", "Award")
    num = pl.DataFrame({
        c: [int(ct.filter(pl.col("Sex") == "M")[c][0]),
            int(ct.filter(pl.col("Sex") == "F")[c][0])]
        for c in award_cols
    })
    ft = lock5.freq_table(num, typename=["Male", "Female", "Total"])
    mo.Html(lock5.gt_table(ft, title="Sex by Award").as_raw_html())
    return award_cols, ct, ft, num


if __name__ == "__main__":
    app.run()
