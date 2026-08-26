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
    mo.md(r"""# Ex 3.100 — tea, coffee, and your immune system

Port of `UnitB/ch03/ex3.100-immune-tea.jl`. Split `InterferonGamma` by `Drink`
(tea vs coffee) and summarise each group.""")
    return


@app.cell
def _(lock5, pl):
    desc = lock5.Lock5Table(282, "ImmuneTea", "3.100 Tea, Coffee, and Your Immune System",
                            ["InterferonGamma", "Drink"])
    df = lock5.load_csv(desc.name)
    gdf = df.group_by("Drink", maintain_order=True).agg(pl.col("InterferonGamma"))
    return desc, df, gdf


@app.cell
def _(gdf, lock5, mo, np, pl):
    rows = []
    for r in gdf.iter_rows():
        vals = np.asarray(r[1], dtype=float)
        rows.append({"drink": r[0], "n": int(len(vals)), "mean": float(vals.mean()),
                     "std": float(vals.std(ddof=1))})
    summary = pl.DataFrame(rows)
    mo.Html(lock5.gt_table(summary, title="InterferonGamma by Drink",
                            decimals={"mean": 3, "std": 3}).as_raw_html())
    return rows, summary


if __name__ == "__main__":
    app.run()
