= Gotchas

Content type for json must be application/javascript, not application/json . Also it must use double quotes for strings, single seemingly will silently fail

If you want to have multiple map phases, the first map phase should return [bucket,key] pairs for the next phase

= Some hints

== Submit a query

    curl -X POST -H "content-type: application/json" http://localhost:8098/mapred --data @-

Then enter the query json, return, ^D

