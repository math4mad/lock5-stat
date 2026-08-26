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
    mo.md(r"""# Young blood — treadmill runtime by plasma group

Port of `UnitA/ch02/youngblood-dataset.jl`. Mean and median `Runtime` for each
`Plasma` group (old vs young).""")
    return


@app.cell
def _(lock5):
    df = lock5.load_data("YoungBlood")
    ages = df["Plasma"].unique(maintain_order=True).to_list()
    return ages, df


@app.cell
def _(ages, df, lock5, mo, pl):
    def treadmill_of(year, method="mean"):
        vals = df.filter(pl.col("Plasma") == year)["Runtime"].to_numpy()
        if method == "mean":
            return round(float(vals.mean()), 2)
        return round(float(np.median(vals)), 2)

    rows = []
    for i in ages:
        for m in ["mean", "median"]:
            rows.append({"Plasma": str(i), "statistic": m, "Runtime": treadmill_of(i, m)})
    res = pl.DataFrame(rows)
    mo.Html(lock5.gt_table(res, title="Treadmill runtime by plasma").as_raw_html())
    return res, treadmill_of


if __name__ == "__main__":
    app.run()
