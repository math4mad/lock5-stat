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
    mo.md(r"""# ICU admissions — heart rate description at ages 20 and 55

Port of `UnitA/ch02/Icu-admissions-description.jl`. Mean and median `HeartRate`
for patients aged 20 and 55.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(100, "ICUAdmissions", "description", ["Age", "HeartRate"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return data


@app.cell
def _(data, lock5, mo, pl):
    def heart_of_age(age):
        return data.filter(pl.col("Age") == age)["HeartRate"]

    res = {
        "hr_age20_mean": heart_of_age(20).mean(),
        "hr_age20_median": heart_of_age(20).median(),
        "hr_age55_mean": heart_of_age(55).mean(),
        "hr_age55_median": heart_of_age(55).median(),
    }
    df = pl.DataFrame({"statistic": list(res.keys()), "value": list(res.values())})
    mo.Html(lock5.gt_table(df, title="HeartRate by age").as_raw_html())
    return df, heart_of_age, res


if __name__ == "__main__":
    app.run()
