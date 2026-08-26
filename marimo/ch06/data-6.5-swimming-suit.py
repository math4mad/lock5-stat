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
    mo.md(r"""# Data 6.5 — Are wetsuits faster? (paired swim speeds)

Port of `UnitC/ch06/data-6.5-swimming-suit.jl`: compare the paired `Wetsuit` and
`NoWetsuit` swim speeds with a summary table and a grouped box plot.""")
    return


@app.cell
def _(lock5, np):
    desc = lock5.Lock5Table(502, "Wetsuits", "more fast with wetsuit?", ["Wetsuit", "NoWetsuit", "Gender", "Type"])
    df = lock5.load_csv(desc.name, drop=False).select(desc.feature[:2])
    wet = df["Wetsuit"].to_numpy().astype(float)
    no_wet = df["NoWetsuit"].to_numpy().astype(float)
    data = [wet, no_wet]
    cats = ["wetsuits", "no-wetsuits"]
    summary = lock5.summary_df(cats, data)
    return desc, df, wet, no_wet, data, cats, summary


@app.cell
def _(GT, mo, summary):
    mo.Html(GT(summary).tab_header(title="Swim speed by suit").fmt_number(columns=["Mean", "Stddev"], decimals=4).as_raw_html())
    return


@app.cell
def _(cats, data, lock5):
    fig, ax = lock5.grouped_boxplot(cats, data, title="different speed", xlabel="speed", ylabel="group")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
