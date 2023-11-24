#= 
D.32 Homes for Sale: Chi-Square Test

四个不同地区的大小房子的出售比例是否有关联? 
=#
## 1. load package
include("../../utils.jl")


## 2. data 
table = NamedArray([15 15 21 17; 15 15 9 13 ], ( ["Larger","Small"], ["CA","NJ","NY","Pen"] ), ("condition", "for sale"))
#= 
2×4 Named Matrix{Int64}
condition ╲ for sale │  CA   NJ   NY  Pen
─────────────────────┼───────────────────
Larger               │  15   15   21   17
Small                │  15   15    9   13
=#


## 3. chi square test
ChisqTest(table)

#= 
Pearson's Chi-square Test
-------------------------
Population details:
    parameter of interest:   Multinomial Probabilities
    value under h_0:         [0.141667, 0.108333, 0.141667, 0.108333, 0.141667, 0.108333, 0.141667, 0.108333]
    point estimate:          [0.125, 0.125, 0.125, 0.125, 0.175, 0.075, 0.141667, 0.108333]
    95% confidence interval: [(0.05, 0.2101), (0.05, 0.2101), (0.05, 0.2101), (0.05, 0.2101), (0.1, 0.2601), (0.0, 0.1601), (0.06667, 0.2267), (0.03333, 0.1934)]

Test summary:
    outcome with 95% confidence: fail to reject h_0
    one-sided p-value:           0.3535

Details:
    Sample size:        120
    statistic:          3.2579185520361964
    degrees of freedom: 3
    residuals:          [-0.485071, 0.5547, -0.485071, 0.5547, 0.970143, -1.1094, 0.0, 0.0]
    std. residuals:     [-0.850871, 0.850871, -0.850871, 0.850871, 1.70174, -1.70174, 0.0, 0.0]
=#

## 4. results
#= 
   房子大小比例在四个地区之间没有显著性差异
=#


##  5. anova test 
    n=4
    expected=fill(1/n,n)
### 5.1 larger 
    
    obs_larger=table[1,:]
    ChisqTest(obs_larger, expected)

#= 
outcome with 95% confidence: fail to reject h_0
    one-sided p-value:           0.7028
=#

### 5.2 small
    
obs_small=table[2,:]
ChisqTest(obs_small, expected)
#= 
outcome with 95% confidence: fail to reject h_0
    one-sided p-value:           0.6049
=#

## 6. load data
desc=Lock5Table(708,"HomesForSale","Difference price of house",["State", "Price", "Size", "Beds", "Baths"])
gdf=@pipe load_csv(desc.name)|>select(_,["State","Price"])|>groupby(_,:State)
cats= @pipe keys(gdf).|>values(_)[1] 
group_data=[d.Price for d in gdf]

## 7. box plot 
UnicodePlots.boxplot(cats, group_data, title="house price in 4 citys", xlabel="price", ylabel="city")
#= 
house price in 4 citys           
           ┌                                        ┐ 
              ╷  ┌────┬──┐       ╷                    
        CA    ├──┤    │  ├───────┤                    
              ╵  └────┴──┘       ╵                    
             ╷ ┌─┬─┐    ╷                             
        NJ   ├─┤ │ ├────┤                             
   city      ╵ └─┴─┘    ╵                             
            ╷ ┌─┬──┐                ╷                 
        NY  ├─┤ │  ├────────────────┤                 
            ╵ └─┴──┘                ╵                 
            ╷  ┌┬─┐   ╷                               
        PA  ├──┤│ ├───┤                               
            ╵  └┴─┘   ╵                               
           └                                        ┘ 
            0                1 000             2 000  
                              price   
=#

##  8. oneway anova test
OneWayANOVATest(group_data...)

#= 
One-way analysis of variance (ANOVA) test
-----------------------------------------
Population details:
    parameter of interest:   Means
    value under h_0:         "all equal"
    point estimate:          NaN

Test summary:
    outcome with 95% confidence: reject h_0
    p-value:                     0.0001

Details:
    number of observations: [30, 30, 30, 30]
    F statistic:            7.3547
    degrees of freedom:     (3, 116)

=#

### 8.1 results
#= 
  四个城市的房屋价格有显著性差异
=#


