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
    mo.md(r"""# Body temperature — is the mean 98.6 °F?

Using `BodyTemp50`, test whether the mean body temperature equals 98.6 °F.
p-value = 0.0029 < 0.05 and the 95% CI (98.04, 98.48) excludes 98.6, so we
reject the null hypothesis.

Port of `UnitC/ch05/body-tempature.jl`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(410, "BodyTemp50", "example5.8", [])
    df = lock5.load_csv(desc.name)
    data = df.to_numpy()[:, 0].astype(float)
    return desc, df, data


@app.cell
def _(GT, data, lock5, mo, pl):
    m, s = lock5.mean_and_std(data)
    stat_df = pl.DataFrame({"statistic": ["mean", "std"], "value": [round(m, 4), round(s, 4)]})
    mo.Html(GT(stat_df).tab_header(title="BodyTemp50 — descriptive statistics").as_raw_html())
    return m, s


@app.cell
def _(data, lock5, np):
    rng = np.random.default_rng(1)
    means = [np.mean(rng.choice(data, size=30, replace=True)) for _ in range(1000)]
    m_means, s_means = lock5.mean_and_std(means)
    return means, m_means, s_means


@app.cell
def _(GT, mo, pl, m_means, s_means):
    sample_df = pl.DataFrame({
        "statistic": ["mean of 1000 sample means", "std of 1000 sample means"],
        "value": [round(m_means, 6), round(s_means, 6)],
    })
    mo.Html(GT(sample_df).tab_header(title="Sampling distribution of the mean (n=30)").as_raw_html())
    return


@app.cell
def _(data, lock5, mo):
    res = lock5.one_sample_ttest(data, 98.6)
    mo.Html(lock5.gt_ttest(res).as_raw_html())
    return res


if __name__ == "__main__":
    app.run()
