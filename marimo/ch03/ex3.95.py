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
    mo.md(r"""# Ex 3.95 — ants on a sandwich (bootstrap)

Port of `UnitB/ch03/ex3.95.jl`. Bootstrap the mean number of ants for the
"Peanut Butter" filling (5000 samples) and compute a basic 95% CI. Bootstrap
results are random, so values differ from the Julia run.""")
    return


@app.cell
def _(lock5, pl):
    desc = lock5.Lock5Table(281, "SandwichAnts", "3.95 Ants on a Sandwich",
                            ["Butter", "Filling", "Bread", "Ants", "Order"])
    df = lock5.load_csv(desc.name)
    peanbutter_ants = df.filter(pl.col("Filling") == "Peanut Butter")
    data = peanbutter_ants["Ants"].to_numpy().astype(float)
    return data, desc, df, peanbutter_ants


@app.cell
def _(data, lock5, mo, np, pl):
    mn, sd = lock5.mean_and_std(data)
    boots = lock5.boot_sampling(data, n=5000, method=np.mean, seed=1)
    estimate = float(data.mean())
    bci = lock5.basic_confint(boots, estimate, 0.95)
    res_df = pl.DataFrame({
        "item": ["mean", "std (sample)", "bias", "std error",
                 "basic 95% CI lower", "basic 95% CI upper"],
        "value": [round(mn, 4), round(sd, 4), round(float(boots.mean() - estimate), 4),
                  round(float(boots.std(ddof=1)), 4), round(bci[1], 4), round(bci[2], 4)],
    })
    mo.Html(lock5.gt_table(res_df, title="Peanut Butter ants bootstrap (5000 samples)").as_raw_html())
    return bci, boots, estimate, res_df


if __name__ == "__main__":
    app.run()
