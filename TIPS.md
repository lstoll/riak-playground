# Gotchas

Content type for json must be application/javascript, not application/json . Also it must use double quotes for strings, single seemingly will silently fail

If you want to have multiple map phases, the first map phase should return [bucket,key] pairs for the next phase

# Some hints

## Submit a query

    curl -X POST -H "content-type: application/json" http://localhost:8098/mapred --data @-

Then enter the query json, return, ^D

## Connect an erlang process

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

## Bulk delete from an erlang process

This can probably be done more effiecently with key streaming. Look into mapred_bucket

    linc@127.0.0.1)4> {ok, Keys} = C:list_keys(<<"test5">>),
    (linc@127.0.0.1)4> lists:map(fun(Key)->
    (linc@127.0.0.1)4> C:delete(Name, Key, 1)
    (linc@127.0.0.1)4> end, Keys).


## Install Innostore

    cd ~/tmp
    hg clone https://bitbucket.org/basho/innostore/ && cd innostore
    make
    mkdir /usr/local/Cellar/riak/0.8/lib/innostore
    cp -R ebin priv /usr/local/Cellar/riak/0.8/lib/innostore
    
vi /usr/local/Cellar/riak/0.8/etc/app.config

change
    
    {storage_backend, riak_dets_backend}

to

    {storage_backend, innostore_riak}

Also if you want, you can add a innostore section to the config, like the riak and
sasl sections

    %% Inno db config
    {innostore, [
                  {data_home_dir,            "/mnt/innodb"},
                  {log_group_home_dir,       "/mnt/innodb"},
                  {buffer_pool_size,         2147483648}, %% 2G of buffer
                  {thread_concurrency,       0},
                  {flush_log_at_trx_commit,  2},
                  {max_dirty_pages_pct,      75},
                  {thread_sleep_delay,       10}
                 ]}
     
Personally I used

    {innostore, [
                  {data_home_dir,            "/usr/local/var/lib/riak-innostore"},
                  {log_group_home_dir,       "/usr/local/var/lib/riak-innostore"}
                 ]},

make sure to

    mkdir /usr/local/var/lib/riak-innostore
