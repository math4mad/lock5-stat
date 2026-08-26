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
    mo.md(r"""# Exercise 1.74 — Random sample of Hollywood movies

Port of `UnitA/ch01/exercise1.74.jl`. Draw a random sample of 5 rows from
`HollywoodMovies` (seeded, same RNG caveat as `example1.5`).""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(53, "HollywoodMovies", "random sample", [])
    df = lock5.load_csv(desc.name)
    row = df.height
    return desc, df, row


@app.cell
def _(df, lock5, mo, np, row):
    rng = np.random.default_rng(343434)
    idx = rng.integers(0, row, size=5)
    samples = df[idx]
    mo.Html(lock5.gt_table(samples, title="Random sample of 5 movies").as_raw_html())
    return idx, rng, samples


if __name__ == "__main__":
    app.run()
