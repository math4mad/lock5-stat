"""lock5stat — Python port of the Julia helper utilities (utils.jl + types.jl).

This module backs the marimo notebooks in this repository.  It is deliberately
kept free of any marimo import so it can also be unit-tested / run as a plain
Python module.  Statistical helpers wrap scipy.stats / numpy and reproduce the
HypothesisTests.jl semantics used throughout UnitC.

Data files live in ``./data`` (project root), exactly as in the Julia version.
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Callable, Iterable, Sequence

import numpy as np
import polars as pl
from scipy import stats

# --------------------------------------------------------------------------- #
# Paths / data loading
# --------------------------------------------------------------------------- #

#: Project root = parent of the ``marimo`` package directory.
PROJECT_ROOT = Path(__file__).resolve().parent.parent
DATA_DIR = PROJECT_ROOT / "data"


def data_path(name: str) -> Path:
    """Absolute path of ``./data/<name>.csv``."""
    return DATA_DIR / f"{name}.csv"


def load_data(name: str) -> pl.DataFrame:
    """Read a CSV into a polars DataFrame and drop rows with missing values.

    Port of ``load_data(str)`` in utils.jl::

        CSV.File("./data/$str.csv") |> DataFrame |> dropmissing
    """
    return pl.read_csv(data_path(name), infer_schema_length=None).drop_nulls()


def load_csv(name: str, drop: bool = True) -> pl.DataFrame:
    """Read a CSV into a polars DataFrame; optionally drop missing rows.

    Port of ``load_csv(str, drop=true)`` in utils.jl.
    """
    df = pl.read_csv(data_path(name), infer_schema_length=None)
    return df.drop_nulls() if drop else df


def list_features(df: pl.DataFrame) -> None:
    """Print the column names of a DataFrame (port of ``list_features``)."""
    print(list(df.columns))


def peek(df: pl.DataFrame, n: int = 5) -> pl.DataFrame:
    """First ``n`` rows of a DataFrame (port of ``peek``)."""
    return df.head(n)


# --------------------------------------------------------------------------- #
# Structs  (port of types.jl)
# --------------------------------------------------------------------------- #


@dataclass
class Lock5Table:
    """Metadata describing a Lock5 dataset / question (port of ``Lock5Table``)."""

    page: int
    name: str
    question: str
    feature: list[str] = field(default_factory=list)


@dataclass
class ProportionTTest:
    """Metadata for a proportion test (port of ``ProportionTTest``).

    ``params`` is ``[observation, n, h0_rating]`` (e.g. ``[66, 119, 1/3]``).
    """

    page: int
    name: str
    question: str
    params: list[float] = field(default_factory=list)


# --------------------------------------------------------------------------- #
# Frequency / contingency table  (port of ``freq_table``)
# --------------------------------------------------------------------------- #


def freq_table(df: pl.DataFrame, typename: Sequence[str] | None = None) -> pl.DataFrame:
    """Build a contingency table with a ``Total`` row/column and a ``Type`` column.

    Port of ``freq_table(df; typename=nothing)`` in utils.jl.  ``df`` must contain
    numeric columns; ``typename`` labels each row (its length must equal the number
    of rows of ``df`` + 1 — the last entry labels the ``Total`` row).
    """
    cols = list(df.columns)
    arr = df.to_numpy().astype(float)

    if typename is None:
        typename = [f"cat{i}" for i in range(1, arr.shape[0] + 1)] + ["Total"]
    if len(typename) != arr.shape[0] + 1:
        raise ValueError("typename must have one label per row plus 'Total'")

    row_totals = arr.sum(axis=1)
    col_totals = arr.sum(axis=0)
    grand_total = arr.sum()

    rows: list[list[Any]] = []
    for i in range(arr.shape[0]):
        rows.append([typename[i], *arr[i].tolist(), row_totals[i]])
    rows.append([typename[-1], *col_totals.tolist(), grand_total])

    out = pl.DataFrame(rows, schema=["Type", *cols, "Total"], orient="row")

    # Keep integers integral for a tidy display (Julia shows Int64 columns).
    for c in [*cols, "Total"]:
        col = out[c]
        if (col - col.floor() == 0).all():
            out = out.with_columns(pl.col(c).cast(pl.Int64))
        else:
            out = out.with_columns(pl.col(c).cast(pl.Float64))
    return out


# --------------------------------------------------------------------------- #
# Descriptive statistics  (port of StatsBase helpers)
# --------------------------------------------------------------------------- #


def mean_and_std(x: Sequence[float]) -> tuple[float, float]:
    """Return ``(mean, sample_std)`` — sample std uses ``ddof=1``.

    Port of StatsBase ``mean_and_std``.
    """
    a = np.asarray(x, dtype=float)
    return float(a.mean()), float(a.std(ddof=1))


def summarystats(x: Sequence[float]) -> dict[str, float]:
    """Summary statistics (n, mean, min, Q1, median, Q3, max).

    Port of StatsBase ``summarystats`` (``describe``).
    """
    a = np.asarray(x, dtype=float)
    q1, med, q3 = np.quantile(a, [0.25, 0.5, 0.75])
    return {
        "n": len(a),
        "mean": a.mean(),
        "min": a.min(),
        "q1": q1,
        "median": med,
        "q3": q3,
        "max": a.max(),
    }


# --------------------------------------------------------------------------- #
# Test results container
# --------------------------------------------------------------------------- #


@dataclass
class TTestResult:
    """Normalised container for a t/z test result (mirrors HypothesisTests.jl)."""

    name: str = "test"
    parameter: str = "Mean"
    estimate: float = 0.0
    statistic: float = 0.0
    pvalue: float = 1.0
    df: float = 0.0
    se: float = 0.0
    ci_low: float = 0.0
    ci_high: float = 0.0
    n: int | tuple[int, ...] = 0
    mu0: float = 0.0
    level: float = 0.95

    def reject(self, alpha: float = 0.05) -> bool:
        return self.pvalue < alpha

    def summary(self) -> dict[str, Any]:
        """Key/value summary used by the notebooks for great-tables output."""
        return {
            "parameter of interest": self.parameter,
            f"value under h_0": self.mu0,
            "point estimate": round(self.estimate, 6),
            f"{int(self.level * 100)}% confidence interval": (
                f"({round(self.ci_low, 4)}, {round(self.ci_high, 4)})"
            ),
            f"outcome with {int(self.level * 100)}% confidence": (
                "reject h_0" if self.reject() else "fail to reject h_0"
            ),
            "two-sided p-value": self.pvalue,
            "t-statistic": round(self.statistic, 6),
            "degrees of freedom": self.df,
            "empirical standard error": round(self.se, 6),
        }


# --------------------------------------------------------------------------- #
# One-sample tests
# --------------------------------------------------------------------------- #


def one_sample_ttest(x: Sequence[float], mu0: float = 0.0, level: float = 0.95) -> TTestResult:
    """One-sample t-test (port of HypothesisTests ``OneSampleTTest``)."""
    a = np.asarray(x, dtype=float)
    n = len(a)
    res = stats.ttest_1samp(a, mu0)
    se = a.std(ddof=1) / math.sqrt(n)
    ci = res.confidence_interval(level)
    return TTestResult(
        name="One sample t-test",
        parameter="Mean",
        estimate=a.mean(),
        statistic=res.statistic,
        pvalue=res.pvalue,
        df=n - 1,
        se=se,
        ci_low=ci.low,
        ci_high=ci.high,
        n=n,
        mu0=mu0,
        level=level,
    )


def single_sample_ttest(desc: Lock5Table, mu0: float) -> TTestResult:
    """``SingleSampleTTest(desc, μ₀)`` — one-sample t-test on the 1st feature."""
    df = load_data(desc.name).select(desc.feature)
    x = df.to_numpy()[:, 0].astype(float)
    return one_sample_ttest(x, mu0)


def one_sample_ztest(
    xbar: float, se: float, n: int, mu0: float = 0.0, level: float = 0.95
) -> TTestResult:
    """One-sample z-test from summary values (port of ``OneSampleZTest``)."""
    z = (xbar - mu0) / se
    p = 2 * stats.norm.sf(abs(z))
    zcrit = stats.norm.ppf(1 - (1 - level) / 2)
    return TTestResult(
        name="One sample z-test",
        parameter="Mean",
        estimate=xbar,
        statistic=z,
        pvalue=p,
        df=math.inf,
        se=se,
        ci_low=xbar - zcrit * se,
        ci_high=xbar + zcrit * se,
        n=n,
        mu0=mu0,
        level=level,
    )


# --------------------------------------------------------------------------- #
# Two-sample tests
# --------------------------------------------------------------------------- #


def _two_sample_result(name: str, estimate: float, statistic: float, pvalue: float,
                       df: float, se: float, ci_low: float, ci_high: float,
                       n: tuple[int, int], level: float = 0.95) -> TTestResult:
    return TTestResult(
        name=name,
        parameter="Mean difference",
        estimate=estimate,
        statistic=statistic,
        pvalue=pvalue,
        df=df,
        se=se,
        ci_low=ci_low,
        ci_high=ci_high,
        n=n,
        mu0=0.0,
        level=level,
    )


def equal_var_ttest(x: Sequence[float], y: Sequence[float],
                    level: float = 0.95) -> TTestResult:
    """Two-sample t-test assuming equal variance (port of ``EqualVarianceTTest``)."""
    a = np.asarray(x, dtype=float)
    b = np.asarray(y, dtype=float)
    res = stats.ttest_ind(a, b, equal_var=True)
    df = len(a) + len(b) - 2
    sp2 = ((len(a) - 1) * a.var(ddof=1) + (len(b) - 1) * b.var(ddof=1)) / df
    se = math.sqrt(sp2 * (1 / len(a) + 1 / len(b)))
    ci = res.confidence_interval(level)
    return _two_sample_result(
        "Two sample t-test (equal variance)",
        a.mean() - b.mean(), res.statistic, res.pvalue, df, se,
        ci.low, ci.high, (len(a), len(b)), level,
    )


def unequal_var_ttest(x: Sequence[float], y: Sequence[float],
                      level: float = 0.95) -> TTestResult:
    """Welch two-sample t-test (port of ``UnequalVarianceTTest``)."""
    a = np.asarray(x, dtype=float)
    b = np.asarray(y, dtype=float)
    res = stats.ttest_ind(a, b, equal_var=False)
    df = res.df
    se = math.sqrt(a.var(ddof=1) / len(a) + b.var(ddof=1) / len(b))
    ci = res.confidence_interval(level)
    return _two_sample_result(
        "Two sample t-test (unequal variance)",
        a.mean() - b.mean(), res.statistic, res.pvalue, df, se,
        ci.low, ci.high, (len(a), len(b)), level,
    )


def equal_var_ttest_stats(nx: int, ny: int, xbar: float, ybar: float,
                          sx: float, sy: float, level: float = 0.95) -> TTestResult:
    """Two-sample equal-variance t-test from summary statistics.

    Matches HypothesisTests.jl ``EqualVarianceTTest(n_x, n_y, xbar, ybar, sx, sy)``
    where — following the Julia convention — ``sx`` and ``sy`` are the sample
    *variances* (the Julia code passes ``std.(data)`` values into these arguments).
    """
    sp2 = ((nx - 1) * sx + (ny - 1) * sy) / (nx + ny - 2)
    se = math.sqrt(sp2 * (1 / nx + 1 / ny))
    t = (xbar - ybar) / se
    df = nx + ny - 2
    p = 2 * stats.t.sf(abs(t), df)
    tcrit = stats.t.ppf(1 - (1 - level) / 2, df)
    est = xbar - ybar
    return _two_sample_result(
        "Two sample t-test (equal variance)",
        est, t, p, df, se, est - tcrit * se, est + tcrit * se,
        (nx, ny), level,
    )


def pair_ttest(summary_df: pl.DataFrame, level: float = 0.95) -> TTestResult:
    """Two-sample t-test from a 2-row summary DataFrame (port of ``pair_ttest``).

    ``summary_df`` columns must be ``[Group, n, Mean, Stddev]``.
    """
    r1 = summary_df.row(0)
    r2 = summary_df.row(1)
    return equal_var_ttest_stats(int(r1[1]), int(r2[1]), float(r1[2]), float(r2[2]),
                                 float(r1[3]), float(r2[3]), level=level)


def make_ttest(desc: Lock5Table, level: float = 0.95) -> TTestResult:
    """Group a 2-column dataset by the 1st feature and run an equal-var t-test.

    ``groupby`` follows Julia DataFrames.jl's default (``sort=false``), i.e.
    groups keep first-appearance order.
    """
    df = load_csv(desc.name).select(desc.feature)
    key, val = desc.feature[0], desc.feature[1]
    groups = df.group_by(key, maintain_order=True).agg(pl.col(val))
    a = np.asarray(groups.row(0)[1], dtype=float)
    b = np.asarray(groups.row(1)[1], dtype=float)
    return equal_var_ttest(a, b, level=level)


# --------------------------------------------------------------------------- #
# Correlation
# --------------------------------------------------------------------------- #


def pearson_corr_test(x: Sequence[float], y: Sequence[float]) -> TTestResult:
    """Pearson correlation test (port of HypothesisTests ``CorrelationTest``)."""
    a = np.asarray(x, dtype=float)
    b = np.asarray(y, dtype=float)
    r, p = stats.pearsonr(a, b)
    return TTestResult(
        name="Pearson correlation test",
        parameter="Correlation",
        estimate=r,
        statistic=math.sqrt((len(a) - 2) * r * r / max(1 - r * r, 1e-12)),
        pvalue=p,
        df=len(a) - 2,
        se=math.sqrt(max(1 - r * r, 0) / (len(a) - 2)),
        ci_low=float("nan"),
        ci_high=float("nan"),
        n=len(a),
        mu0=0.0,
    )


def make_cor_ttest(desc: Lock5Table) -> TTestResult:
    """Correlation t-test on a two-feature table (port of ``make_cor_ttest``)."""
    if len(desc.feature) != 2:
        raise ValueError("cor_test must setting only two feature!")
    df = load_data(desc.name).select(desc.feature)
    x = df[desc.feature[0]].to_numpy().astype(float)
    y = df[desc.feature[1]].to_numpy().astype(float)
    return pearson_corr_test(x, y)


def pair_corletation(data: pl.DataFrame, dig: int = 2) -> float:
    """Correlation coefficient of a two-column DataFrame (port of ``pair_corletation``)."""
    arr = data.to_numpy().astype(float)
    return round(float(np.corrcoef(arr[:, 0], arr[:, 1])[0, 1]), dig)


def pair_data(name: str, feature: list[str]) -> pl.DataFrame:
    """Select two columns of a dataset (port of ``pair_data``)."""
    return load_data(name).select(feature)


# --------------------------------------------------------------------------- #
# Proportion tests
# --------------------------------------------------------------------------- #


@dataclass
class ProportionTestResult:
    """Normalised container for a binomial / proportion test."""

    name: str = "Binomial test"
    estimate: float = 0.0
    pvalue: float = 1.0
    ci_low: float = 0.0
    ci_high: float = 0.0
    n: int = 0
    success: int = 0
    mu0: float = 0.0
    level: float = 0.95

    def reject(self, alpha: float = 0.05) -> bool:
        return self.pvalue < alpha

    def summary(self) -> dict[str, Any]:
        return {
            "parameter of interest": "Probability of success",
            "value under h_0": self.mu0,
            "point estimate": round(self.estimate, 6),
            f"{int(self.level * 100)}% confidence interval": (
                f"({round(self.ci_low, 4)}, {round(self.ci_high, 4)})"
            ),
            f"outcome with {int(self.level * 100)}% confidence": (
                "reject h_0" if self.reject() else "fail to reject h_0"
            ),
            "two-sided p-value": self.pvalue,
            "number of observations": self.n,
            "number of successes": self.success,
        }


def binomial_test(x: int, n: int, p: float, level: float = 0.95) -> ProportionTestResult:
    """Binomial test (port of HypothesisTests ``BinomialTest(x, n, p)``)."""
    res = stats.binomtest(x, n, p)
    ci = res.proportion_ci(confidence_level=level)
    return ProportionTestResult(
        estimate=res.proportion_estimate,
        pvalue=res.pvalue,
        ci_low=ci.low,
        ci_high=ci.high,
        n=n,
        success=x,
        mu0=p,
        level=level,
    )


def fisher_exact_test(a: int, b: int, c: int, d: int,
                      level: float = 0.95) -> TTestResult:
    """Fisher's exact test on the 2x2 table ``[[a, b], [c, d]]``.

    Port of HypothesisTests ``FisherExactTest(a, b, c, d)``.  The Julia version
    builds the table ``[a b; c d]`` and reports the odds ratio ``a*d/(b*c)``
    (i.e. the ratio of the two proportions ``a/c`` and ``b/d``).
    """
    table = [[a, b], [c, d]]
    odds, p = stats.fisher_exact(table, alternative="two-sided")
    # Woolf log-odds confidence interval (matches HypothesisTests.jl closely).
    with np.errstate(divide="ignore", invalid="ignore"):
        log_se = math.sqrt(1 / a + 1 / b + 1 / c + 1 / d)
    z = stats.norm.ppf(1 - (1 - level) / 2)
    lo = math.exp(math.log(odds) - z * log_se)
    hi = math.exp(math.log(odds) + z * log_se)
    return TTestResult(
        name="Fisher's exact test",
        parameter="Odds ratio",
        estimate=odds,
        statistic=float("nan"),
        pvalue=p,
        df=float("nan"),
        se=log_se,
        ci_low=lo,
        ci_high=hi,
        n=(a, b, c, d),  # type: ignore[assignment]
        mu0=1.0,
        level=level,
    )


# --------------------------------------------------------------------------- #
# z-score / proportion confidence intervals  (port of ch06/confidence-interval…)
# --------------------------------------------------------------------------- #


def get_zscore(level: float = 0.95, double: bool = True) -> float:
    """z-score for a confidence level (port of ``get_zscore``)."""
    r = 2 if double else 1
    return round(float(stats.norm.ppf(1 - (1 - level) / r)), 3)


def get_ci_for_proportion(observation: float | int, n: int, level: float = 0.95) -> tuple[float, float]:
    """z-based CI for a proportion (port of the two ``get_ci_for_proportion`` methods).

    Following the Julia dispatch: an ``Int`` (or a value > 1) is treated as a
    success *count* (divided by ``n``); a ``Real`` in ``[0, 1]`` is treated as a
    proportion already.
    """
    if isinstance(observation, (int, np.integer)) or observation > 1:
        p = observation / n
    else:
        p = observation
    z = get_zscore(level)
    tail = z * math.sqrt(p * (1 - p) / n)
    return round(p - tail, 3), round(p + tail, 3)


def computing_ci(m: float, s: float, n: int, t: float = 1.664, dig: int = 2) -> tuple[float, float]:
    """Confidence interval ``m ± t*s/√n`` (port of ``computing_ci`` in example-c.2)."""
    v = t * s / math.sqrt(n)
    return round(m - v, dig), round(m + v, dig)


# --------------------------------------------------------------------------- #
# Bootstrap  (port of Bootstrap.jl BasicSampling / BasicConfInt)
# --------------------------------------------------------------------------- #


def boot_sampling(data: Sequence[float], n: int = 1000,
                  method: Callable[[np.ndarray], float] = np.mean,
                  seed: int | None = None) -> np.ndarray:
    """Basic bootstrap resampling (port of ``bootstrap(method, data, BasicSampling(n))``)."""
    rng = np.random.default_rng(seed)
    a = np.asarray(data, dtype=float)
    return np.array([method(rng.choice(a, size=len(a), replace=True)) for _ in range(n)])


def basic_confint(boots: np.ndarray, estimate: float,
                  level: float = 0.95) -> tuple[float, float, float]:
    """Basic bootstrap CI ``(estimate, lower, upper)`` (port of ``BasicConfInt``)."""
    alpha = 1 - level
    lo = 2 * estimate - np.quantile(boots, 1 - alpha / 2)
    hi = 2 * estimate - np.quantile(boots, alpha / 2)
    return estimate, float(lo), float(hi)


# --------------------------------------------------------------------------- #
# Group summary table  (port of ``summary_df``)
# --------------------------------------------------------------------------- #


def summary_df(cats: Sequence[str], group_data: Sequence[Sequence[float]]) -> pl.DataFrame:
    """Group summary table ``[Group, n, Mean, Stddev]`` (port of ``summary_df``)."""
    rows = []
    for c, g in zip(cats, group_data):
        g = np.asarray(g, dtype=float)
        rows.append({"Group": str(c), "n": len(g), "Mean": g.mean(), "Stddev": g.std(ddof=1)})
    return pl.DataFrame(rows)


def group_summary(df: pl.DataFrame, key: str, val: str) -> tuple[list[str], list[np.ndarray], pl.DataFrame]:
    """Group ``df`` by ``key`` and return ``(cats, group_data, summary_df)``.

    Uses first-appearance order (Julia DataFrames.jl ``groupby`` default).
    """
    groups = df.group_by(key, maintain_order=True).agg(pl.col(val))
    cats = [str(g[0]) for g in groups.iter_rows()]
    group_data = [np.asarray(g[1], dtype=float) for g in groups.iter_rows()]
    return cats, group_data, summary_df(cats, group_data)


# --------------------------------------------------------------------------- #
# Plotting helpers (matplotlib ports of the GLMakie / UnicodePlots code)
# --------------------------------------------------------------------------- #


def _ensure_ax(ax=None, figsize=(7, 4)):
    import matplotlib.pyplot as plt

    if ax is None:
        fig, ax = plt.subplots(figsize=figsize)
        return fig, ax
    return ax.figure, ax


def plot_level_band(ax, xs, dist, level: float = 0.05, double: bool = True,
                    color: str = "red", alpha: float = 0.5) -> tuple:
    """Shade the significance-level tail region under a distribution curve.

    Port of ``plot_level_band(ax, params::PvalueParams)``.
    """
    lo = min(xs)
    hi = max(xs)
    q_low = dist.ppf(level / 2)
    q_high = dist.ppf(1 - level / 2)
    as1 = np.linspace(lo, q_low, 100)
    as2 = np.linspace(q_high, hi, 100)
    b1 = ax.fill_between(as1, 0, dist.pdf(as1), color=color, alpha=alpha)
    b2 = ax.fill_between(as2, 0, dist.pdf(as2), color=color, alpha=alpha)
    return b1, b2


def plot_dotplot(values, nbins=None, ax=None, figsize=(7, 4), title=None,
                 xlabel=None, ylabel=None, color="lightgreen"):
    """Dot plot of a histogram (port of ``plot_dotplot(h)``).

    Each bin's observations are stacked as dots at the left bin edge, mirroring
    the GLMakie scatter-based dot plot in the Julia code.
    """
    import matplotlib.pyplot as plt

    a = np.asarray(values, dtype=float)
    if nbins is None:
        nbins = max(5, int(np.ceil(np.log2(len(a))) + 1))
    counts, edges = np.histogram(a, bins=nbins)

    fig, ax = _ensure_ax(ax, figsize)
    for i, c in enumerate(counts):
        x = edges[i]
        for y in range(1, int(c) + 1):
            ax.scatter(x, y, s=140, color=color, alpha=0.6,
                       edgecolors="black", linewidths=0.5)
    ax.set_ylim(0, counts.max() + 1)
    ax.set_title(title or "")
    ax.set_xlabel(xlabel or "")
    ax.set_ylabel(ylabel or "")
    return fig, ax


def grouped_boxplot(cats, data, title=None, xlabel=None, ylabel=None,
                    figsize=(7, 4)):
    """Grouped box plot (port of ``UnicodePlots.boxplot``)."""
    import matplotlib.pyplot as plt

    fig, ax = plt.subplots(figsize=figsize)
    ax.boxplot([np.asarray(g, dtype=float) for g in data], vert=False,
               tick_labels=list(cats), patch_artist=True)
    ax.set_title(title or "")
    ax.set_xlabel(xlabel or "")
    ax.set_ylabel(ylabel or "")
    return fig, ax


def scatter_fit(x, y, slope, intercept, ax=None, figsize=(7, 4), title=None,
                xlabel=None, ylabel=None):
    """Scatter plot with a fitted line (port of ``plot_linreg`` / ``plot_reg_data``)."""
    import matplotlib.pyplot as plt

    x = np.asarray(x, dtype=float)
    y = np.asarray(y, dtype=float)
    fig, ax = _ensure_ax(ax, figsize)
    ax.scatter(x, y, s=45, color="lightgreen", alpha=0.7,
               edgecolors="black", linewidths=0.5)
    xs = np.linspace(x.min(), x.max(), 200)
    ax.plot(xs, intercept + slope * xs, color="blue", linewidth=2, label="fitting line")
    ax.legend()
    ax.set_title(title or "")
    ax.set_xlabel(xlabel or "")
    ax.set_ylabel(ylabel or "")
    return fig, ax


def plot_normal_density(dists, xs, colors=None, figsize=(12, 5)):
    """Plot normal PDF curves with translucent bands (port of gaussian-dist.jl)."""
    import matplotlib.pyplot as plt

    fig, axes = plt.subplots(1, 2, figsize=figsize)
    if colors is None:
        colors = ["#FF410D", "#6EE2FF", "#F7C530", "#95CC5E", "#D0DFE6", "#F79D1E"]
    for d, c in zip(dists[0], colors):
        axes[0].plot(xs, d.pdf(xs), color=c, linewidth=3, label=f"{d.mean():g}, {d.std():g}")
        axes[0].fill_between(xs, 0, d.pdf(xs), color=c, alpha=0.1)
    for d, c in zip(dists[1], colors):
        axes[1].plot(xs, d.pdf(xs), color=c, linewidth=3, label=f"{d.mean():g}, {d.std():g}")
        axes[1].fill_between(xs, 0, d.pdf(xs), color=c, alpha=0.1)
    axes[0].set_title("μ change, σ=1"); axes[0].set_xlabel("μ change, σ=1")
    axes[1].set_title("μ=0, σ change"); axes[1].set_xlabel("μ=0, σ change")
    axes[0].legend(); axes[1].legend()
    return fig, axes


# --------------------------------------------------------------------------- #
# great-tables helpers
# --------------------------------------------------------------------------- #


def gt_table(df: pl.DataFrame, title: str | None = None, subtitle: str | None = None,
             decimals: dict[str, int] | None = None):
    """Wrap a polars DataFrame in a great-tables ``GT`` with a header."""
    from great_tables import GT

    t = GT(df)
    if title:
        t = t.tab_header(title=title, subtitle=subtitle or "")
    if decimals:
        for col, d in decimals.items():
            t = t.fmt_number(columns=[col], decimals=d)
    return t


def gt_ttest(result: TTestResult) -> "Any":
    """Render a ``TTestResult`` as a great-tables object."""
    s = result.summary()
    df = pl.DataFrame({"item": list(s.keys()), "value": [str(v) for v in s.values()]})
    return gt_table(df, title=result.name)


def gt_proportion(result: ProportionTestResult) -> "Any":
    """Render a ``ProportionTestResult`` as a great-tables object."""
    s = result.summary()
    df = pl.DataFrame({"item": list(s.keys()), "value": [str(v) for v in s.values()]})
    return gt_table(df, title=result.name)
