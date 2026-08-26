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
    mo.md(r"""# Two-way table — StudentSurvey Sex × Award (FreqTables)

Port of `UnitA/ch02/two-way-table-studentsurvey-2.jl`. The original used
`freqtable(df, :Sex, :Award)` (referencing an undefined `df`); here we compute
the cross-tabulation directly.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(81, "StudentSurvey", "studentsuvey two way table ",
                            ["Sex", "Award"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return data


@app.cell
def _(data, lock5, mo):
    ft = lock5.freqtable(data, "Sex", "Award")
    mo.Html(lock5.gt_table(ft, title="Sex × Award cross-tabulation").as_raw_html())
    return ft


if __name__ == "__main__":
    app.run()
