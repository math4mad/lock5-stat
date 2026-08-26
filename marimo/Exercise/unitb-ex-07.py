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
    mo.md(r"""# Unit B Ex 7 — husband vs wife ages

Port of `UnitB/Exercises/unitb-ex-07.jl`. Scatter of `Husband` vs `Wife` and a
correlation test.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(403, "MarriageAges", "Husbands Older Than Wives?",
                            ["Husband", "Wife"])
    data = lock5.load_data(desc.name)
    return data, desc


@app.cell
def _(data, lock5):
    fig, ax = lock5.plot_pair_cor(data)
    ax.set_title("Husband-Wife-Cor")
    fig
    return fig, ax


@app.cell
def _(data, lock5, mo):
    res = lock5.pearson_corr_test(data["Husband"].to_numpy().astype(float),
                                  data["Wife"].to_numpy().astype(float))
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
