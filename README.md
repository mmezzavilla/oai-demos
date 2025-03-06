# OAI demos

## Quectel configuration

First, make sure you connect the Quectel to a different machine - cannot be the same machine where you run the gNB.
Also, make sure you launch Ubuntu where you have installed all the drivers (in my case, 5.15.0-1032-realtime, which is the platform used also for O-RAN experimentation).

Then, check if the drivers are correctly loaded: 

```
sudo modprobe qmi_wwan
lsusb -t
```

If that is not the case, run lsusb and note down the bus info: e.g., 
Bus 006 Device 003: ID 2c7c:0801 Quectel Wireless Solutions Co., Ltd. RM520N-GL

```
echo "2c7c 0801" | sudo tee /sys/bus/usb/drivers/qmi_wwan/new_id
```

If this is what you see: 
Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
    |__ Port 2: Dev 2, If 0, Class=Vendor Specific Class, Driver=option, 10000M
    |__ Port 2: Dev 2, If 1, Class=Vendor Specific Class, Driver=option, 10000M
    |__ Port 2: Dev 2, If 2, Class=Vendor Specific Class, Driver=option, 10000M
    |__ Port 2: Dev 2, If 3, Class=Vendor Specific Class, Driver=option, 10000M
    |__ Port 2: Dev 2, If 4, Class=Vendor Specific Class, Driver=qmi_wwan, 10000M

You are ready to launch the quectel-oai script: 
```
sudo ip link set wwan0 up
sudo ./quectel-CM -s oai
```

## OAI gNodeB
```
sudo ./nr-softmodem -O ../../../targets/PROJECTS/GENERIC-NR-5GC/CONF/n310_nyu.conf --nokrnmod --sa --usrp-tx-thread-config 1 --tune-offset 30000000 --gNBs.[0].min_rxtxtime 5
```
## OAI UE
```
sudo ./nr-uesoftmodem -C 3619200000 -r 106 --numerology 1 --ssb 516 --ue-fo-compensation -E --uicc0.imsi 001010000000001 --ue-txgain 10 --ue-rxgain 100 -d
```
