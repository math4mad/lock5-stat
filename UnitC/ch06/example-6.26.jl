#= 
  lock5stat page 489
=#

## 1. load package
include("../../utils.jl")
using UnicodePlots
## 2. load data 
desc1=Lock5Table(489,"CommuteAtlanta","CommuteAtlanta",["Time"])
desc2=Lock5Table(489,"CommuteStLouis","CommuteStLouis",["Time"])
atlanta_time=@pipe load_csv(desc1.name)
stlouis_time=@pipe load_csv(desc2.name)
data=[atlanta_time.Time,stlouis_time.Time]
## desc table
Group=["Atlanta","StLouis"]
summary_df=DataFrame(Group=Group,
                     n=size.(data,1),
                     Mean=mean.(data),
                     Stddev=std.(data)
                     )
@pt summary_df

#= 
┌─────────┬───────┬─────────┬─────────┐
│   Group │     n │    Mean │  Stddev │
│  String │ Int64 │ Float64 │ Float64 │
├─────────┼───────┼─────────┼─────────┤
│ Atlanta │   500 │   29.11 │ 20.7183 │
│ StLouis │   500 │   21.97 │ 14.2324 │
└─────────┴───────┴─────────┴─────────┘
=#

UnicodePlots.boxplot(Group,data,title="Grouped Boxplot", xlabel="Time",ylabel="City")
"""
                   Grouped Boxplot              
                ┌                                        ┐ 
                 ╷ ┌─┬──┐                           ╷      
        Atlanta  ├─┤ │  ├───────────────────────────┤      
   City          ╵ └─┴──┘                           ╵      
                 ╷┌─┬─┐                   ╷                
        StLouis  ├┤ │ ├───────────────────┤                
                 ╵└─┴─┘                   ╵                
                └                                        ┘ 
                 0                 100                200  
                                   Time                    
"""
