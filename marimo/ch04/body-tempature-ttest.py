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
    mo.md(r"""# Body temperature — histogram and mean

Port of `UnitB/ch04/body-tempature-ttest.jl`. Histogram and mean of `BodyTemp`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(381, "BodyTemp50", "Body temperature", ["BodyTemp", "Pulse", "Sex"])
    df = lock5.load_data(desc.name)
    temps = df["BodyTemp"].to_numpy().astype(float)
    return desc, df, temps


@app.cell
def _(lock5, mo, temps):
    mean_temp = float(temps.mean())
    mo.md(f"**Mean BodyTemp** = `{mean_temp:.4f}`")
    return mean_temp


@app.cell
def _(plt, temps):
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.hist(temps, bins=20, color="gray", alpha=0.6, edgecolor="black", linewidth=1)
    ax.axvline(temps.mean(), color="red", linewidth=2, label="mean")
    ax.set_title("BodyTemp histogram")
    ax.set_xlabel("BodyTemp")
    ax.set_ylabel("Frequency")
    ax.legend()
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
