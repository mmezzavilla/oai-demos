# OAI demos

## Quectel configuration

First, make sure you connect the Quectel to a different machine - cannot be the same machine where you run the gNB.
Also, make sure you launch Ubuntu where you have installed all the drivers (in my case, 5.15.0-1032-realtime, which is the platform used also for O-RAN experimentation).

Then, check if the drivers are correctly loaded: 


```
sudo ./nr-softmodem -O ../../../targets/PROJECTS/GENERIC-NR-5GC/CONF/n310_nyu.conf --nokrnmod --sa --usrp-tx-thread-config 1 --tune-offset 30000000 --gNBs.[0].min_rxtxtime 5
```

```
sudo ./nr-softmodem -O ../../../targets/PROJECTS/GENERIC-NR-5GC/CONF/n310_nyu.conf --nokrnmod --sa --usrp-tx-thread-config 1 --tune-offset 30000000 --gNBs.[0].min_rxtxtime 5
```
