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
    mo.md(r"""# Ex 4.212 — quiz vs lecture pulse rates

Port of `UnitB/ch04/ex4.212.jl`. Two-sample test, a paired test, and a
one-sample test on `diff = Quiz - Lecture` (all lead to the same conclusion).""")
    return


@app.cell
def _(lock5, np, pl):
    desc = lock5.Lock5Table(390, "QuizPulse10", "Quiz vs Lecture diff Pulse Rates",
                            ["Student", "Quiz", "Lecture"])
    data = lock5.load_data(desc.name).select(desc.feature[1:])
    quiz = data["Quiz"].to_numpy().astype(float)
    lecture = data["Lecture"].to_numpy().astype(float)
    return data, desc, lecture, quiz


@app.cell
def _(lecture, lock5, mo, quiz):
    res_eq = lock5.equal_var_ttest(quiz, lecture)
    mo.Html(lock5.gt_ttest(res_eq).as_raw_html())
    return res_eq


@app.cell
def _(lecture, lock5, mo, quiz):
    res_paired = lock5.paired_ttest(quiz, lecture)
    mo.Html(lock5.gt_ttest(res_paired).as_raw_html())
    return res_paired


@app.cell
def _(lock5, mo, quiz, lecture):
    diff = quiz - lecture
    res_diff = lock5.one_sample_ttest(diff, 0)
    mo.Html(lock5.gt_ttest(res_diff).as_raw_html())
    return diff, res_diff


if __name__ == "__main__":
    app.run()
