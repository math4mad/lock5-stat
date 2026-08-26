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
    mo.md(r"""# Example C.2 — Confidence interval for free-throw attempts (FTA)

Port of `UnitC/CaseStudy/GSWarriro2018-2019-Season/example-c.2.jl`: mean ±
`t·s/√n` with `t = 1.664`.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(537, "GSWarriors2019", "statistics", ["Location", "FTA", "FT", "OppFTA", "OppFT"])
    data = lock5.load_csv(desc.name)
    fta = data["FTA"].to_numpy().astype(float)
    m, s = lock5.mean_and_std(fta)
    n = len(fta)
    ci = lock5.computing_ci(m, s, n)
    return desc, data, fta, m, s, n, ci


@app.cell
def _(GT, ci, m, mo, n, pl, s):
    out_df = pl.DataFrame({
        "mean": [round(m, 2)],
        "std": [round(s, 2)],
        "n": [n],
        "95% CI": [f"{ci}"],
    })
    mo.Html(GT(out_df).tab_header(title="FTA confidence interval").as_raw_html())
    return


if __name__ == "__main__":
    app.run()
