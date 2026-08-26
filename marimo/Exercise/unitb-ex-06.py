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
    mo.md(r"""# Unit B Ex 6 — husbands older than wives?

Port of `UnitB/Exercises/unitb-ex-06.jl`. One-sample t-test on
`age_diff = Husband - Wife`, and the proportion of couples where the husband is
older.""")
    return


@app.cell
def _(lock5, pl):
    desc = lock5.Lock5Table(402, "MarriageAges", "Husbands Older Than Wives?",
                            ["Husband", "Wife"])
    data = lock5.load_data(desc.name).with_columns(
        (pl.col("Husband") - pl.col("Wife")).alias("age_diff")
    )
    return data, desc


@app.cell
def _(data, lock5, mo):
    res = lock5.one_sample_ttest(data["age_diff"].to_numpy().astype(float), 0)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


@app.cell
def _(data, mo, pl):
    morethan0 = int(data.filter(pl.col("age_diff") > 0).height)
    total = data.height
    ratio = morethan0 / total * 100
    mo.md(f"**Husband older than wife** = `{morethan0}/{total}` = `{ratio:.1f}%`")
    return morethan0, ratio, total


if __name__ == "__main__":
    app.run()
