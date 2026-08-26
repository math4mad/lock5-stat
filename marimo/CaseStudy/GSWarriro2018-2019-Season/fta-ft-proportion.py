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
    mo.md(r"""# FT / FTA proportion — 99% confidence interval

Port of `UnitC/CaseStudy/GSWarriro2018-2019-Season/fta-ft-proportion.jl`:
`BinomialTest(FT, FTA)` then `confint(level = 0.99)`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(537, "GSWarriors2019", "statistics", ["Location", "FTA", "FT", "OppFTA", "OppFT"])
    data = lock5.load_csv(desc.name)
    fta = int(data["FTA"].sum())
    ft = int(data["FT"].sum())
    res = lock5.binomial_test(ft, fta, 0.5, level=0.99)
    return desc, data, fta, ft, res


@app.cell
def _(GT, ft, fta, mo, pl, res):
    ci_df = pl.DataFrame({
        "FT": [ft],
        "FTA": [fta],
        "rate": [round(res.estimate, 6)],
        "99% confidence interval": [f"({round(res.ci_low, 4)}, {round(res.ci_high, 4)})"],
    })
    mo.Html(GT(ci_df).tab_header(title="Free-throw percentage — 99% CI").as_raw_html())
    return


if __name__ == "__main__":
    app.run()
