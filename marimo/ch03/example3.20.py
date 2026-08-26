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
    mo.md(r"""# Example 3.20 — Manual bootstrap

Port of `UnitB/ch03/example3.20.jl`. Bootstrap the mean of `[16, 22, 9, 31, 6, 42]`
both manually (10 resamples) and with the bootstrap routine. Bootstrap results
are random, so values differ from the Julia run.""")
    return


@app.cell
def _(lock5, np):
    data = np.array([16, 22, 9, 31, 6, 42], dtype=float)
    rng = np.random.default_rng(3434343)

    def manual_bootstrap(n_boot=6, method=np.mean):
        idx = rng.integers(0, len(data), n_boot)
        sample = data[idx]
        return sample, float(method(sample))

    rows = []
    for _ in range(10):
        sample, stat = manual_bootstrap(6)
        rows.append({"sample": ", ".join(map(str, sample.astype(int))), "stat": round(stat, 4)})
    return data, manual_bootstrap, rng, rows


@app.cell
def _(lock5, mo, pl, rows):
    sample_df = pl.DataFrame(rows)
    mo.Html(lock5.gt_table(sample_df, title="Manual bootstrap (10 resamples of size 6)").as_raw_html())
    return sample_df


@app.cell
def _(data, lock5, mo, np, pl):
    boots = lock5.boot_sampling(data, n=1000, method=np.mean, seed=3434343)
    estimate = float(data.mean())
    bci = lock5.basic_confint(boots, estimate, 0.95)
    res_df = pl.DataFrame({
        "item": ["estimate", "bias", "std error", "basic 95% CI lower", "basic 95% CI upper"],
        "value": [round(estimate, 4), round(float(boots.mean() - estimate), 4),
                  round(float(boots.std(ddof=1)), 4), round(bci[1], 4), round(bci[2], 4)],
    })
    mo.Html(lock5.gt_table(res_df, title="Bootstrap mean (1000 samples)").as_raw_html())
    return bci, boots, estimate, res_df


if __name__ == "__main__":
    app.run()
