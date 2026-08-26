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
    mo.md(r"""# Example A.2 — Describe six SleepStudy variables

Port of `UnitA/CaseStudy/exampleA.2.jl`. Levels (distinct values) of six
variables.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(202, "SleepStudy", "Sleep Study with College Students",
                            ["DASScore", "Stress", "LarkOwl", "AlcoholUse",
                             "PoorSleepQuality", "CognitionZscore"])
    df = lock5.load_csv(desc.name).select(desc.feature)
    return df


@app.cell
def _(df, lock5, mo, pl):
    notes = {
        "DASScore": "depression/anxiety/stress score (1–100)",
        "Stress": "stress level: high / normal",
        "LarkOwl": "chronotype: Lark / Neither / Owl",
        "AlcoholUse": "alcohol use: Abstain / Heavy / Light / Moderate",
        "PoorSleepQuality": "sleep quality (0/1)",
        "CognitionZscore": "cognitive z-score",
    }
    rows = []
    for c in df.columns:
        uniq = df[c].unique(maintain_order=True).to_list()
        if df[c].dtype.is_numeric():
            lv = f"numeric ({len(uniq)} unique values)"
        else:
            lv = ", ".join(str(u) for u in uniq)
        rows.append({"variable": c, "description": notes.get(c, ""), "levels": lv})
    res = pl.DataFrame(rows)
    mo.Html(lock5.gt_table(res, title="Variable levels").as_raw_html())
    return notes, res


if __name__ == "__main__":
    app.run()
