== Streamed key log is substandially faster than all-in-one-go (at least innostore)

time curl http://localhost:8098/raw/test4?keys=stream

(~10k keys)

real	0m3.398s
user	0m0.004s
sys	0m0.010s

time curl http://localhost:8098/raw/test4

(~10k keys)

real	1m9.045s
user	0m0.005s
sys	0m0.009s

