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
    mo.md(r"""# FTA — normality check and 90% confidence interval

Port of `UnitC/CaseStudy/GSWarriro2018-2019-Season/fta-ci.jl`.  The Julia source
uses `OneSampleADTest` (Anderson–Darling) for normality and `OneSampleTTest` for
the interval; both are reproduced with scipy.""")
    return


@app.cell
def _(lock5, np, stats):
    desc = lock5.Lock5Table(537, "GSWarriors2019", "statistics", ["Location", "FTA", "FT", "OppFTA", "OppFT"])
    data = lock5.load_csv(desc.name)
    fta = data["FTA"].to_numpy().astype(float)
    # Anderson-Darling normality test (port of OneSampleADTest)
    ad = stats.anderson(fta, dist="norm")
    res90 = lock5.one_sample_ttest(fta, 0.0, level=0.90)
    return desc, data, fta, ad, res90


@app.cell
def _(GT, ad, mo, pl):
    ad_df = pl.DataFrame({
        "AD statistic": [round(ad.statistic, 6)],
        "critical values (5%)": [round(ad.critical_values[2], 6)],
        "conclusion": ["fail to reject normality" if ad.statistic < ad.critical_values[2] else "reject normality"],
    })
    mo.Html(GT(ad_df).tab_header(title="Anderson–Darling normality test (FTA)").as_raw_html())
    return


@app.cell
def _(GT, mo, pl, res90):
    ci_df = pl.DataFrame({
        "90% confidence interval": [f"({round(res90.ci_low, 4)}, {round(res90.ci_high, 4)})"],
    })
    mo.Html(GT(ci_df).tab_header(title="FTA mean — 90% CI").as_raw_html())
    return


if __name__ == "__main__":
    app.run()
