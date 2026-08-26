# marimo — Python port of Lock5Stat UnitC

Marimo notebooks porting the Julia code in `../UnitC` to Python (git `python`
branch).  Phase 1 covers **UnitC** only.

## Environment

```bash
conda create -y -n lock5stat-env python=3.12 pip
conda activate lock5stat-env
python -m pip install -r ../requirements.txt
```

## Layout

| Python (`marimo/`)                                  | Julia source                    |
| --------------------------------------------------- | ------------------------------- |
| `lock5.py` (shared helper module)                   | `../utils.jl`, `../types.jl`    |
| `ch05/*.py`                                         | `../UnitC/ch05/*.jl`            |
| `ch06/*.py`                                         | `../UnitC/ch06/*.jl`            |
| `CaseStudy/GSWarriro2018-2019-Season/*.py`          | `../UnitC/CaseStudy/.../*.jl`   |
| `Exercise/*.py`                                     | `../UnitC/Exercise/*.jl`        |

## Run

```bash
conda activate lock5stat-env
marimo edit marimo            # open the whole folder as an app
# or a single notebook:
marimo edit "marimo/ch06/example-6.18-florida-lakes-alkalinity-ttest.py"
```

Every notebook resolves `lock5.py` and the `./data` directory automatically from
`mo.notebook_location()`, so they run regardless of the working directory.

## Conventions

- **Data** is read with **polars** (`load_data` / `load_csv` in `lock5.py`).
- **EDA tables** use **great-tables** (`GT(...)`).
- **Statistics** wrap `scipy.stats` / `numpy` and reproduce the
  `HypothesisTests.jl` semantics used throughout the Julia code:
  - `one_sample_ttest`, `equal_var_ttest`, `unequal_var_ttest`
  - `equal_var_ttest_stats` (summary-statistics t-test; `sx`, `sy` are
    *variances*, matching `EqualVarianceTTest(n, n, x̄, ȳ, sx, sy)` in Julia)
  - `binomial_test`, `fisher_exact_test`, `one_sample_ztest`, `pearson_corr_test`
  - `boot_sampling` + `basic_confint` (basic bootstrap interval)
- **`groupby`** preserves first-appearance order (`maintain_order=True`),
  matching Julia DataFrames.jl's default `sort=false`.

## Notes on the original Julia source

- `data-6.3-crows-...jl` wrote `444-158` / `922-109` for the "no scold" counts;
  the port uses the correct book counts (444 and 922).
- `example-6.11.jl` used an undefined `Dist(8.0, 10.5)`; ported as
  `Normal(8.0, 10.5)`.
- A few CaseStudy files `include("data.jl")`, which does not exist; the port
  loads `GSWarriors2019` directly.
- `example-5-10.jl` sampled `xs = -10..10` (off the support of `Normal(40,5)`);
  the port uses `20..60` so the tail bands are visible.
