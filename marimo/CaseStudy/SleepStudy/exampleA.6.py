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
    mo.md(r"""# Example A.6 — DASScore histogram and a z-score

Port of `UnitA/CaseStudy/exampleA.6.jl`. Summary statistics and a histogram of
`DASScore` with the mean and median marked, plus the z-score of 82 using
μ = 20.04, σ = 16.54.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(203, "SleepStudy", "histogram of DAS scores", ["DASScore"])
    df = lock5.load_csv(desc.name).select("DASScore")
    das = df["DASScore"].to_numpy().astype(float)
    stat = lock5.summarystats(das)
    return das, desc, df, stat


@app.cell
def _(lock5, mo, pl, stat):
    stat_df = pl.DataFrame({
        "statistic": list(stat.keys()),
        "value": [round(float(v), 6) for v in stat.values()],
    })
    mo.Html(lock5.gt_table(stat_df, title="DASScore summary statistics").as_raw_html())
    return stat_df


@app.cell
def _(das, plt, stat):
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.hist(das, bins="auto", color="gray", alpha=0.6, edgecolor="black", linewidth=1)
    ax.axvline(stat["mean"], color="red", linestyle=":", linewidth=3, label="mean")
    ax.axvline(stat["median"], color="blue", linestyle="--", linewidth=3, label="median")
    ax.set_title("DASScore histogram")
    ax.set_xlabel("DASScore")
    ax.set_ylabel("Frequency")
    ax.legend()
    fig
    return fig, ax


@app.cell
def _(lock5, mo):
    z82 = lock5.zscore([82], 20.04, 16.54)[0]
    mo.md(f"**z-score of 82** (μ = 20.04, σ = 16.54): `{z82}`")
    return z82


if __name__ == "__main__":
    app.run()
