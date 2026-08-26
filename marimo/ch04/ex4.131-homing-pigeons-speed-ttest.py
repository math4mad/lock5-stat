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
    mo.md(r"""# Ex 4.131 — homing pigeon speed by sex

Port of `UnitB/ch04/ex4.131-homing-pigeons-speed-ttest.jl`. F-test for equal
variances then a two-sample equal-variance t-test of `Speed` by `Sex`.""")
    return


@app.cell
def _(lock5, np, pl):
    desc = lock5.Lock5Table(351, "HomingPigeons", "Are Female or Male Homing Pigeons Faster?",
                            ["Sex", "Speed"])
    data = lock5.load_csv(desc.name).select(desc.feature).group_by(desc.feature[0], maintain_order=True).agg(pl.col(desc.feature[1]))
    g1 = np.asarray(data.row(0)[1], dtype=float)
    g2 = np.asarray(data.row(1)[1], dtype=float)
    return data, desc, g1, g2


@app.cell
def _(g1, g2, lock5, mo, pl):
    f_res = lock5.variance_ftest(g1, g2)
    f_df = pl.DataFrame({"item": list(f_res.keys()), "value": [str(v) for v in f_res.values()]})
    mo.Html(lock5.gt_table(f_df, title="Variance F-test").as_raw_html())
    return f_df, f_res


@app.cell
def _(g1, g2, lock5, mo):
    res = lock5.equal_var_ttest(g1, g2)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
