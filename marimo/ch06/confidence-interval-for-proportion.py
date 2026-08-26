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
    mo.md(r"""# Confidence interval for a proportion (z-interval)

Port of `UnitC/ch06/confidence-interval-for-proportion.jl` — `get_zscore` and
`get_ci_for_proportion` helpers, applied to a few textbook examples.""")
    return


@app.cell
def _(lock5):
    get_zscore = lock5.get_zscore
    get_ci_for_proportion = lock5.get_ci_for_proportion
    return get_zscore, get_ci_for_proportion


@app.cell
def _(GT, get_ci_for_proportion, get_zscore, mo, pl):
    rows = {
        "case": ["52/100", "Quebec separate (0.28, n=800)", "Quebec distinct (0.82, n=800)"],
        "ci": [
            str(get_ci_for_proportion(52, 100)),
            str(get_ci_for_proportion(0.28, 800)),
            str(get_ci_for_proportion(0.82, 800)),
        ],
    }
    mo.Html(GT(pl.DataFrame(rows)).tab_header(title="Proportion confidence intervals", subtitle=f"z-score (95%) = {get_zscore(0.95)}").as_raw_html())
    return


@app.cell
def _(stats):
    pdf_val = stats.norm(loc=0.5).pdf(3.319)
    return pdf_val


@app.cell
def _(GT, mo, pdf_val, pl):
    mo.Html(GT(pl.DataFrame({"pdf(Normal(0.5), 3.319)": [round(pdf_val, 6)]})).as_raw_html())
    return


if __name__ == "__main__":
    app.run()
