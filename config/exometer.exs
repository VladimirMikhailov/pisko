use Mix.Config

memory_stats = ~w(atom binary ets processes total)a

config :exometer,
   predefined: [
     {
       ~w(erlang memory)a,
       {:function, :erlang, :memory, [], :proplist, memory_stats},
       []
     }
   ],
   report: [
     reporters: [{:exometer_report_statsd, []}],
     subscribers: [
       {
         :exometer_report_statsd,
         [:erlang, :memory], memory_stats, 1_000, true
       }
     ]
   ]
