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
    mo.md(r"""# Two-way table — true love (Table 2.4)

Port of `UnitA/ch02/two-way-table-truelove.jl`. Hard-coded contingency table of
`Male`/`Female` by agreement with "true love" (Agree / Disagree / Don't know).""")
    return


@app.cell
def _(lock5, mo, pl):
    df = lock5.freq_table(
        pl.DataFrame({
            "Male": [372, 807, 34],
            "Female": [363, 1005, 44],
        }),
        typename=["Agree", "Disagree", "Don't know", "Total"],
    )
    mo.Html(lock5.gt_table(df, title="True love two-way table").as_raw_html())
    return df


if __name__ == "__main__":
    app.run()
