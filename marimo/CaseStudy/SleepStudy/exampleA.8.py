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
    mo.md(r"""# Example A.8 — CognitionZscore summarised by AlcoholUse

Port of `UnitA/CaseStudy/exampleA.8.jl`. Sample size, mean and standard
deviation of `CognitionZscore` within each `AlcoholUse` group, plus an
`Overall` row. (The Julia `Overall` row sums the group means/stds — that
behaviour is reproduced faithfully here.)""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(203, "SleepStudy", "Cognition by AlcoholUse",
                            ["AlcoholUse", "CognitionZscore"])
    df = lock5.load_csv(desc.name).select(desc.feature)
    return desc, df


@app.cell
def _(df, np, pl):
    groups = df.group_by("AlcoholUse", maintain_order=True).agg(pl.col("CognitionZscore"))
    rows = []
    for r in groups.iter_rows():
        name = r[0]
        vals = np.asarray(r[1], dtype=float)
        rows.append({
            "name": name,
            "samplesize": int(len(vals)),
            "mean": float(vals.mean()),
            "std": float(vals.std(ddof=1)),
        })
    overall = {
        "name": "Overall",
        "samplesize": sum(r["samplesize"] for r in rows),
        "mean": sum(r["mean"] for r in rows),
        "std": sum(r["std"] for r in rows),
    }
    summary = pl.DataFrame([*rows, overall])
    return groups, rows, summary


@app.cell
def _(lock5, mo, summary):
    mo.Html(lock5.gt_table(
        summary,
        title="CognitionZscore by AlcoholUse",
        decimals={"mean": 6, "std": 6},
    ).as_raw_html())
    return


if __name__ == "__main__":
    app.run()
