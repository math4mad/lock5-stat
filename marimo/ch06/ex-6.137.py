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
    mo.md(r"""# Ex 6.137 — Home prices by state (one-sample t-tests)

Port of `UnitC/ch06/ex-6.137.jl`: summarise `HomesForSale.Price` by `State`, then
test whether the mean price of NY, NJ and PA equals 278 (thousand).""")
    return


@app.cell
def _(lock5, np, pl):
    desc = lock5.Lock5Table(467, "HomesForSale", "Difference price of house", ["State", "Price", "Size", "Beds", "Baths"])
    data = lock5.load_csv(desc.name).select(["State", "Price"])
    cats = data["State"].unique(maintain_order=True).to_list()
    groups = data.group_by("State", maintain_order=True).agg(pl.col("Price"))
    rows = []
    for i in range(groups.height):
        state = cats[i]
        prices = np.asarray(groups.row(i)[1], dtype=float)
        rows.append({"State": state, "n": len(prices), "Mean": prices.mean(), "Std_Dev": prices.std(ddof=1)})
    summary = pl.DataFrame(rows)
    return desc, data, cats, groups, summary


@app.cell
def _(GT, mo, summary):
    mo.Html(GT(summary).tab_header(title="Home price by state").fmt_number(columns=["Mean", "Std_Dev"], decimals=3).as_raw_html())
    return


@app.cell
def _(groups, lock5, mo, np):
    res_ny = lock5.one_sample_ttest(np.asarray(groups.row(2)[1], dtype=float), 278)
    res_nj = lock5.one_sample_ttest(np.asarray(groups.row(1)[1], dtype=float), 278)
    res_pa = lock5.one_sample_ttest(np.asarray(groups.row(3)[1], dtype=float), 278)
    return res_ny, res_nj, res_pa


@app.cell
def _(GT, mo, pl, res_nj, res_ny, res_pa):
    p_df = pl.DataFrame({
        "state": ["NY", "NJ", "PA"],
        "point estimate": [round(res_ny.estimate, 3), round(res_nj.estimate, 3), round(res_pa.estimate, 3)],
        "95% CI": [
            f"({round(res_ny.ci_low, 1)}, {round(res_ny.ci_high, 1)})",
            f"({round(res_nj.ci_low, 1)}, {round(res_nj.ci_high, 1)})",
            f"({round(res_pa.ci_low, 1)}, {round(res_pa.ci_high, 1)})",
        ],
        "p-value": [res_ny.pvalue, res_nj.pvalue, res_pa.pvalue],
        "reject h_0 (μ=278)": [res_ny.reject(), res_nj.reject(), res_pa.reject()],
    })
    mo.Html(GT(p_df).tab_header(title="One-sample t-tests vs μ = 278").as_raw_html())
    return


if __name__ == "__main__":
    app.run()
