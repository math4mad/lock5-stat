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
    mo.md(r"""# Warriors vs opponents free-throw attempts by location

Port of `UnitC/CaseStudy/GSWarriro2018-2019-Season/home-opponent-fta-diff.jl`:
for Home, Away and both, compute `FTADiff = FTA - OppFTA` and its 95% CI.""")
    return


@app.cell
def _(lock5, pl):
    data = lock5.load_data("GSWarriors2019").select(["FTA", "OppFTA", "Location"])

    def fta_diff_of(location):
        sub = data.filter(pl.col("Location") == location).select(["FTA", "OppFTA"])
        return sub.with_columns((pl.col("FTA") - pl.col("OppFTA")).alias("FTADiff"))["FTADiff"].to_numpy()

    home_diff = fta_diff_of("Home")
    away_diff = fta_diff_of("Away")
    both_diff = np.concatenate([home_diff, away_diff])
    return data, home_diff, away_diff, both_diff


@app.cell
def _(away_diff, both_diff, home_diff, lock5):
    home_res = lock5.one_sample_ttest(home_diff, 0.0)
    away_res = lock5.one_sample_ttest(away_diff, 0.0)
    both_res = lock5.one_sample_ttest(both_diff, 0.0)
    return home_res, away_res, both_res


@app.cell
def _(GT, away_res, both_res, home_res, mo, pl):
    ci_df = pl.DataFrame({
        "group": ["homeCI", "awayCI", "bothCI"],
        "95% confidence interval": [
            f"({round(home_res.ci_low, 4)}, {round(home_res.ci_high, 4)})",
            f"({round(away_res.ci_low, 4)}, {round(away_res.ci_high, 4)})",
            f"({round(both_res.ci_low, 4)}, {round(both_res.ci_high, 4)})",
        ],
    })
    mo.Html(GT(ci_df).tab_header(title="FTA - OppFTA confidence intervals").as_raw_html())
    return


if __name__ == "__main__":
    app.run()
