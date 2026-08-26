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
    mo.md(r"""# Example B.2 — Bootstrap and t-tests on tips

Port of `UnitB/CaseStudy-Restaurant Tips/example-b2.jl`. Bootstrap the mean tip,
test whether `PctTip` exceeds 15% / 20%, and compare two servers. Bootstrap and
resampling results are random, so values differ from the Julia run (same method).""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(395, "RestaurantTips", "",
                            ["Bill", "Tip", "Credit", "Guests", "Day", "Server", "PctTip"])
    data = lock5.load_data(desc.name)
    return data, desc


@app.cell
def _(data, lock5, np):
    tips = data["Tip"].to_numpy().astype(float)
    boots = lock5.boot_sampling(tips, n=1000, method=np.mean, seed=3434343)
    estimate = float(tips.mean())
    bci = lock5.basic_confint(boots, estimate, 0.95)
    return bci, boots, estimate, tips


@app.cell
def _(bci, estimate, lock5, mo, pl):
    boot_df = pl.DataFrame({
        "item": ["bootstrap mean estimate", "basic 95% CI lower", "basic 95% CI upper"],
        "value": [round(estimate, 3), round(bci[1], 3), round(bci[2], 3)],
    })
    mo.Html(lock5.gt_table(boot_df, title="Bootstrap CI for mean Tip").as_raw_html())
    return boot_df


@app.cell
def _(data, lock5, mo):
    t15 = lock5.one_sample_ttest(data["PctTip"].to_numpy().astype(float), 15)
    t20 = lock5.one_sample_ttest(data["PctTip"].to_numpy().astype(float), 20)
    mo.Html(lock5.gt_ttest(t15).as_raw_html())
    return t15, t20


@app.cell
def _(lock5, mo, t20):
    mo.Html(lock5.gt_ttest(t20).as_raw_html())
    return


@app.cell
def _(data, lock5, mo, np, pl):
    gdf = data.group_by("Server", maintain_order=True).agg(pl.col("PctTip"))
    rng = np.random.default_rng(3434343)
    g1 = np.asarray(gdf.row(0)[1], dtype=float)
    g2 = np.asarray(gdf.row(1)[1], dtype=float)
    d1 = rng.choice(g1, size=30, replace=True)
    d2 = rng.choice(g2, size=30, replace=True)
    server_test = lock5.paired_ttest(d1, d2)
    mo.Html(lock5.gt_ttest(server_test).as_raw_html())
    return d1, d2, g1, g2, gdf, server_test


if __name__ == "__main__":
    app.run()
