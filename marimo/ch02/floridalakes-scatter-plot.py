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
    mo.md(r"""# Florida lakes — scatter plot matrix and correlations

Port of `UnitA/ch02/floridalakes-scatter-plot.jl`. All pairwise scatter plots of
`Alkalinity`, `pH`, `AvgMercury`, `ThreeYrStdMercury`, plus their correlations.""")
    return


@app.cell
def _(lock5):
    df = lock5.load_data("FloridaLakes")
    data = df.select(["Alkalinity", "pH", "AvgMercury", "ThreeYrStdMercury"])
    return data


@app.cell
def _(data, lock5):
    fig, axes = lock5.plot_cor_group(data, ncols=3, figsize=(10, 7))
    fig
    return fig, axes


@app.cell
def _(data, lock5, mo):
    from itertools import combinations
    cats = list(data.columns)
    pairs = list(combinations(cats, 2))
    rows = []
    for a, b in pairs:
        r = lock5.pair_corletation(data.select([a, b]), dig=6)
        rows.append({"pair": f"{a}-{b}", "correlation": r})
    cor_df = pl.DataFrame(rows)
    mo.Html(lock5.gt_table(cor_df, title="Pairwise correlations").as_raw_html())
    return cats, cor_df, pairs, rows


if __name__ == "__main__":
    app.run()
