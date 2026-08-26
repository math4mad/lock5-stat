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
    mo.md(r"""# CommuteAtlanta — bootstrap sampling dot plot

Port of `UnitB/ch03/commuteatlanta-bootstrap-sampling.jl`. Bootstrap the mean
`Time` (1000 samples) and dot-plot the bootstrap means (rounded to 0.1).
Bootstrap results are random, so values differ from the Julia run.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(270, "CommuteAtlanta", "bootstrap sampling", ["Distance", "Time"])
    data = lock5.load_data(desc.name).select(desc.feature[1])
    times = data["Time"].to_numpy().astype(float)
    return data, desc, times


@app.cell
def _(lock5, mo, np, pl, times):
    mn, sd = lock5.mean_and_std(times)
    boots = lock5.boot_sampling(times, n=1000, method=np.mean, seed=1)
    rounded = np.round(boots, 1)
    res_df = pl.DataFrame({
        "item": ["mean", "std (sample)"],
        "value": [round(mn, 2), round(sd, 3)],
    })
    mo.Html(lock5.gt_table(res_df, title="CommuteAtlanta Time").as_raw_html())
    return boots, mn, res_df, rounded


@app.cell
def _(lock5, rounded):
    fig, ax = lock5.plot_dotplot(rounded, nbins=40, title="Bootstrap sampling",
                                 xlabel="Time", ylabel="Count", color="black")
    fig
    return fig, ax


if __name__ == "__main__":
    app.run()
