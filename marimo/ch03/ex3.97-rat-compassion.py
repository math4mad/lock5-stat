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
    mo.md(r"""# Ex 3.97 — rats with compassion (bootstrap the count)

Port of `UnitB/ch03/ex3.97-rat-compassion.jl`. Recode `Empathy` (yes → 1, no → 0)
and bootstrap the *sum* (number of empathetic rats). Bootstrap results are
random, so values differ from the Julia run.""")
    return


@app.cell
def _(lock5, pl):
    desc = lock5.Lock5Table(281, "CompassionateRats", "3.97 Rats with Compassion", ["Sex", "Empathy"])
    df = lock5.load_csv(desc.name)
    df = df.with_columns(pl.col("Empathy").replace_strict({"yes": 1, "no": 0}).cast(pl.Int64))
    data = df["Empathy"].to_numpy().astype(float)
    return data, desc, df


@app.cell
def _(data, lock5, mo, np, pl):
    boots = lock5.boot_sampling(data, n=1000, method=np.sum, seed=1)
    res_df = pl.DataFrame({
        "item": ["number of empathetic rats (observed)", "bootstrap mean count", "bootstrap std"],
        "value": [float(data.sum()), round(float(boots.mean()), 2), round(float(boots.std(ddof=1)), 2)],
    })
    mo.Html(lock5.gt_table(res_df, title="Compassionate rats bootstrap (sum)").as_raw_html())
    return boots, res_df


if __name__ == "__main__":
    app.run()
