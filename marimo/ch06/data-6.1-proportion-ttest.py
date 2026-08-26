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
    mo.md(r"""# Proportion tests with `BinomialTest`

Port of `UnitC/ch06/data-6.1-proprotion-ttest.jl`:

1. Rock–Paper–Scissors — is the first throw "rock" with probability 1/3?
2. ESP — can a psychic identify a card suit? (n = 100 and n = 1000).""")
    return


@app.cell
def _(lock5):
    rock = lock5.ProportionTTest(466, "RockPaperScissors",
                                 "Is the first RockPaperScissors throw Rock with probability 1/3?",
                                 [66, 119, 1 / 3])
    esp100 = lock5.ProportionTTest(467, "extrasensory perception (ESP)",
                                   "Can a psychic identify a card suit?",
                                   [29, 100, 0.25])
    esp1000 = lock5.ProportionTTest(467, "extrasensory perception (ESP)",
                                    "Can a psychic identify a card suit?",
                                    [290, 1000, 0.25])
    return rock, esp100, esp1000


@app.cell
def _(esp100, esp1000, lock5, rock):
    rock_res = lock5.binomial_test(*rock.params)
    esp100_res = lock5.binomial_test(*esp100.params)
    esp1000_res = lock5.binomial_test(*esp1000.params)
    return rock_res, esp100_res, esp1000_res


@app.cell
def _(esp100_res, esp1000_res, lock5, mo, rock_res):
    mo.md(f"""### Rock–Paper–Scissors (n = 119)

{lock5.gt_proportion(rock_res).as_raw_html()}

### ESP (n = 100)

{lock5.gt_proportion(esp100_res).as_raw_html()}

### ESP (n = 1000)

{lock5.gt_proportion(esp1000_res).as_raw_html()}

**Conclusion:** there is evidence the first Rock–Paper–Scissors throw favours rock.
""")
    return


if __name__ == "__main__":
    app.run()
