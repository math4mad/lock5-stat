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
    mo.md(r"""# Example 2.29 — TV watching by sex (dot plots)

Port of `UnitA/ch02/example-2.29-watch-tv.jl`. Dot plots of `TV` hours for
males and females.""")
    return


@app.cell
def _(lock5):
    desc = lock5.Lock5Table(129, "StudentSurvey", "description", ["Sex", "TV"])
    data = lock5.load_csv(desc.name).select(desc.feature)
    return data


@app.cell
def _(data, plt):
    def dotplot(ax, subset, title):
        counts = subset.group_by("TV", maintain_order=True).len()
        xs = counts["TV"].to_list()
        ys = counts["len"].to_list()
        for x, cnt in zip(xs, ys):
            for y in range(1, int(cnt) + 1):
                ax.scatter(x, y, s=50, color="lightgreen", alpha=0.5,
                           edgecolors="black", linewidths=0.5)
        ax.set_xlabel("TV")
        ax.set_ylabel("Count")
        ax.set_title(title)
        ax.set_xlim(0, 40)
        ax.set_ylim(0, 35)

    male = data.filter(data["Sex"] == "M")
    female = data.filter(data["Sex"] == "F")
    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(8, 7))
    dotplot(ax1, male, "male")
    dotplot(ax2, female, "female")
    fig.tight_layout()
    fig
    return dotplot, fig, (ax1, ax2)


if __name__ == "__main__":
    app.run()
