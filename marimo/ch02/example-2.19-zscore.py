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
    mo.md(r"""# Example 2.19 — z-scores for ICU patient 772

Port of `UnitA/ch02/example-2.19-zscore.jl`. Standardise `Systolic` and
`HeartRate` (z-score) and show patient 772.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(113, "ICUAdmissions", "description", ["ID", "Systolic", "HeartRate"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return data


@app.cell
def _(data, lock5, mo, pl):
    standard = data.with_columns([
        ((pl.col("Systolic") - pl.col("Systolic").mean()) / pl.col("Systolic").std(ddof=1)).alias("Systolic_z"),
        ((pl.col("HeartRate") - pl.col("HeartRate").mean()) / pl.col("HeartRate").std(ddof=1)).alias("HeartRate_z"),
    ])
    patient = standard.filter(pl.col("ID") == 772)
    mo.Html(lock5.gt_table(patient, title="Patient 772 (standardised)").as_raw_html())
    return patient, standard


if __name__ == "__main__":
    app.run()
