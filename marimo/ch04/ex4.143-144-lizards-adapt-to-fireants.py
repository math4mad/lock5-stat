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
    mo.md(r"""# Ex 4.143–4 — lizards fleeing fire ants

Port of `UnitB/ch04/ex4.143-144-lizards-adapt-to-fireants.jl`. Two-sample
equal-variance t-test of `Flee` between `Invaded` and `Uninvaded` habitats,
plus a frequency plot of `Flee` by habitat.""")
    return


@app.cell
def _(lock5, np, pl):
    desc = lock5.Lock5Table(354, "FireAnts", "蜥蜴对 fireant 是否有适应性的行为", ["Habitat", "Flee"])
    df = lock5.load_data(desc.name).select(desc.feature)
    data = df.group_by(desc.feature[0], maintain_order=True).agg(pl.col(desc.feature[1]))
    g1 = np.asarray(data.row(0)[1], dtype=float)
    g2 = np.asarray(data.row(1)[1], dtype=float)
    return data, desc, df, g1, g2


@app.cell
def _(g1, g2, lock5, mo):
    res = lock5.equal_var_ttest(g1, g2)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


@app.cell
def _(data, np, plt):
    fig, ax = plt.subplots(figsize=(7, 4))
    cats = [r[0] for r in data.iter_rows()]
    vals = [np.asarray(r[1], dtype=float) for r in data.iter_rows()]
    ax.hist(vals[0], bins=15, alpha=0.5, label=cats[0], color="blue")
    ax.hist(vals[1], bins=15, alpha=0.5, label=cats[1], color="orange")
    ax.set_title("Flee frequency by habitat")
    ax.set_xlabel("Flee")
    ax.set_ylabel("Frequency")
    ax.legend()
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
