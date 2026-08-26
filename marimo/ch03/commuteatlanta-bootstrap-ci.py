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
    mo.md(r"""# CommuteAtlanta — bootstrap CI dot plot

Port of `UnitB/ch03/commuteatlanta-bootstrap-ci.jl`. Dot-plot the bootstrap means
and colour points inside the basic 95% CI black, outside red. Bootstrap results
are random, so values differ from the Julia run.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(270, "CommuteAtlanta", "bootstrap sampling", ["Distance", "Time"])
    data = lock5.load_data(desc.name).select(desc.feature[1])
    times = data["Time"].to_numpy().astype(float)
    return data, desc, times


@app.cell
def _(lock5, np, times):
    boots = lock5.boot_sampling(times, n=1000, method=np.mean, seed=1)
    estimate = float(times.mean())
    bci = lock5.basic_confint(boots, estimate, 0.95)
    lo, hi = bci[1], bci[2]
    rounded = np.round(boots, 1)
    return bci, boots, estimate, hi, lo, rounded


@app.cell
def _(hi, lock5, lo, mo, pl, rounded):
    inside = (rounded >= lo) & (rounded <= hi)
    res_df = pl.DataFrame({
        "item": ["estimate", "CI lower", "CI upper", "count inside CI", "count outside CI"],
        "value": [round(bci[0], 2), round(lo, 2), round(hi, 2), int(inside.sum()), int((~inside).sum())],
    })
    mo.Html(lock5.gt_table(res_df, title="Bootstrap CI summary").as_raw_html())
    return inside, res_df


@app.cell
def _(hi, inside, lo, np, plt, rounded):
    fig, ax = plt.subplots(figsize=(10, 5))
    unique = np.unique(rounded)
    for u in unique:
        cnt = int((rounded == u).sum())
        color = "black" if (u >= lo and u <= hi) else "red"
        for y in range(1, cnt + 1):
            ax.scatter(u, y, s=50, color=color, edgecolors="none")
    ax.set_title("Bootstrap sampling CI")
    ax.set_xlabel("Time")
    ax.set_ylabel("Count")
    ax.axvline(lo, color="red", linestyle="--", linewidth=1)
    ax.axvline(hi, color="red", linestyle="--", linewidth=1)
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
