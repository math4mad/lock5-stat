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
    mo.md(r"""# Case Study — Golden State Warriors free throws (data)

Port of `UnitC/CaseStudy/GSWarriro2018-2019-Season/data-c.1.jl`.

- `Location`: home or away
- `FTA` / `FT`: Warriors free-throw attempts / makes
- `OppFTA` / `OppFT`: opponent free-throw attempts / makes

*(The original Julia source referenced an undefined `str`; this port loads
`GSWarriors2019` from `desc.name`.)*""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(537, "GSWarriors2019", "statistics", ["Location", "FTA", "FT", "OppFTA", "OppFT"])
    data = lock5.load_csv(desc.name)
    return desc, data


@app.cell
def _(GT, data, mo):
    mo.Html(GT(data.head(8)).tab_header(title="GSWarriors2019 — first 8 games").as_raw_html())
    return


if __name__ == "__main__":
    app.run()
