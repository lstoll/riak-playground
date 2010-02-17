= Gotchas

Content type for json must be application/javascript, not application/json . Also it must use double quotes for strings, single seemingly will silently fail

If you want to have multiple map phases, the first map phase should return [bucket,key] pairs for the next phase

= Some hints

== Submit a query

    curl -X POST -H "content-type: application/json" http://localhost:8098/mapred --data @-

Then enter the query json, return, ^D

== Connect an erlang process

    # replace linc with your machines hostname
    /usr/local/Cellar/riak/0.8/erts-5.7.4/bin/erl -setcookie riak -name linc@127.0.0.1
    Erlang R13B03 (erts-5.7.4) [source] [64-bit] [smp:2:2] [rq:2] [async-threads:0] [kernel-poll:false]

    Eshell V5.7.4  (abort with ^G)
    (linc@127.0.0.1)1> RiakNode = riak_util:str_to_node(riak).
    'riak@127.0.0.1'
    (linc@127.0.0.1)2> net_adm:ping(RiakNode).
    pong
    (linc@127.0.0.1)3> {ok, C} = riak:client_connect(RiakNode).
    {ok,{riak_client,'riak@127.0.0.1',<<7,217,74,71>>}}

== Bulk delete from an erlang process

This can probably be done more effiecently with key streaming. Look into mapred_bucket

    linc@127.0.0.1)4> {ok, Keys} = C:list_keys(<<"test5">>),
    (linc@127.0.0.1)4> lists:map(fun(Key)->
    (linc@127.0.0.1)4> C:delete(Name, Key, 1)
    (linc@127.0.0.1)4> end, Keys).
    
