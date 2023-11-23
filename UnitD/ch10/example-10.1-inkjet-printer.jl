"""
chapter:
page 655  Example 10.1
data:InkjetPrinters

"""


## 1. load package

include("../../utils.jl")


## 2. load data

desc=Lock5Table(655,"InkjetPrinters","mutliple regression ",["PPM","CostBW","Price"])
df=@pipe load_csv(desc.name)
data=select(df,desc.feature)


## 3. lin reg
model=lm(@formula(Price ~ PPM+CostBW), data)
#round.(coef(res), digits=3)


## 4. plot residuals

@pipe residuals(model)|>zscore|>stem   #plot all  data  residuals
#save("./ch10/imgs/inkjet-printer-multiple-reg.png",fig)

#= 
   Price ~ 1 + PPM + CostBW
    Coefficients:
    ────────────────────────────────────────────────────────────────────────
                    Coef.  Std. Error      t  Pr(>|t|)  Lower 95%  Upper 95%
    ────────────────────────────────────────────────────────────────────────
    (Intercept)   89.205     95.7443    0.93    0.3645  -112.798   291.208
    PPM           58.0993    22.7854    2.55    0.0207    10.0263  106.172
    CostBW       -21.125      9.34077  -2.26    0.0371   -40.8323   -1.41771
    ────────────────────────────────────────────────────────────────────────

    两个参数进行了 t检验, h₀: coef=0, hₐ: coef ≠0  
    结论:
    PPM, CostBW 的 pvalue 在 95% 置信区间下都小于 0.05. 所以系数不为 0
    所以两个参数都参与回归模型的建立
=#

## 


## 4. predict example

kodak=filter(:Model=>==("Kodak ESP Office 2170 All-in-One Printer"),df)

predict(model, kodak;interval= :confidence,level=0.95)

#= 
1×3 DataFrame
 Row │ prediction  lower     upper    
     │ Float64?    Float64?  Float64? 
─────┼────────────────────────────────
   1 │     185.34   158.698   211.982
=#


## 6. nest model
#nest_lms = nestedmodels(LinearModel, @formula(Price ~ PPM*CostBW),data; dropcollinear = false)
#anova(nest_lms)

    