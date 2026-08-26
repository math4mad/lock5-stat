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
    mo.md(r"""# Ex A.44 — Who smokes more: males or females?

Port of `UnitA/exercise/exA.44.jl`. Two-way table of `Smoke` (rows) by `Sex`
(columns) with totals, plus the smoking rate overall and by sex.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(216, "StudentSurvey", "Who Smokes More: Males or Females",
                            ["Sex", "Smoke"])
    df = lock5.load_csv(desc.name).select(desc.feature)
    return desc, df


@app.cell
def _(df, lock5, pl):
    smoke_rows = ["No", "Yes"]
    num = pl.DataFrame({
        "Female": [int(df.filter((pl.col("Smoke") == s) & (pl.col("Sex") == "F")).height)
                   for s in smoke_rows],
        "Male": [int(df.filter((pl.col("Smoke") == s) & (pl.col("Sex") == "M")).height)
                 for s in smoke_rows],
    })
    freq_df = lock5.freq_table(num, typename=["noSmoke", "Smoke", "Total"])
    return freq_df, num, smoke_rows


@app.cell
def _(freq_df, lock5, mo):
    mo.Html(lock5.gt_table(freq_df, title="Smoke by Sex").as_raw_html())
    return


@app.cell
def _(freq_df, mo):
    smoker_prop = freq_df["Total"][1] / freq_df["Total"][2] * 100
    male_prop = freq_df["Male"][1] / freq_df["Male"][2] * 100
    female_prop = freq_df["Female"][1] / freq_df["Female"][2] * 100
    mo.md(
        f"""- **overall smoker rate** = {smoker_prop:.2f}%
- **male smoker rate** = {male_prop:.2f}%
- **female smoker rate** = {female_prop:.2f}%"""
    )
    return female_prop, male_prop, smoker_prop


if __name__ == "__main__":
    app.run()
