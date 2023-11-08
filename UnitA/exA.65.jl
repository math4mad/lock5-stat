include("../utils.jl")
using StatsBase
## 2. load data
desc = Lock5Table(220, "ToenailArsenic", "Arsenic in Toenails", ["Arsenic"])
df = @pipe load_csv(desc.name) 

## 2. mean_std
@info "mean_and_std"=> mean_and_std(df.Arsenic)

## 2. zscore

@info  "zscore"=>@pipe df.Arsenic|>zscore([maximum(_)],mean_and_std(_)...)


## 3. summarystat

res=summarystats(df.Arsenic)
#= 
 Summary Stats:
Length:         19
Missing Count:  0
Mean:           0.271895
Minimum:        0.073000
1st Quartile:   0.118000
Median:         0.158000
3rd Quartile:   0.334000
Maximum:        0.851000
=#
## 4. 1qr
@info "1qr"=>res.q25

## 5. range
@info "range"=>res.max-res.min


## 6. dotplot
bins=fit(Histogram, df.Arsenic;nbins=12,closed=:right)
function plot_dotplot()
    fig=Figure()
    ax=Axis(fig[1,1],title="dotplot")
    for (idx,edge)  in  enumerate(bins.edges[1])
        scatter!(ax,fill(edge,bins.weights[idx]),cumsum(1:bins.weights[idx]))
       
    end
    fig
end

plot_dotplot()




