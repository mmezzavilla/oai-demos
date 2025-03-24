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
```
Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
    |__ Port 2: Dev 2, If 0, Class=Vendor Specific Class, Driver=option, 10000M
    |__ Port 2: Dev 2, If 1, Class=Vendor Specific Class, Driver=option, 10000M
    |__ Port 2: Dev 2, If 2, Class=Vendor Specific Class, Driver=option, 10000M
    |__ Port 2: Dev 2, If 3, Class=Vendor Specific Class, Driver=option, 10000M
    |__ Port 2: Dev 2, If 4, Class=Vendor Specific Class, Driver=qmi_wwan, 10000M
```

You are ready to launch the quectel-oai script: 
```
sudo ip link set wwan0 up
sudo ./quectel-CM -s oai
```

## OAI gNodeB at FR1 (att_tx=0, att_rx=0)
```
sudo ./nr-softmodem -O ../../../targets/PROJECTS/GENERIC-NR-5GC/CONF/n310_nyu.conf --nokrnmod --usrp-tx-thread-config 1 --tune-offset 30000000 --gNBs.[0].min_rxtxtime 5
```
## OAI UE at FR1 
```
sudo ./nr-uesoftmodem -C 3619200000 -r 106 --numerology 1 --ssb 516 --ue-fo-compensation -E --uicc0.imsi 001010000000001 --ue-txgain 10 --ue-rxgain 85 --time-source 1 --clock-source 1 -d 2>&1 | tee ue_split8.log

```

## OAI gNodeB at FR3 

First and foremost, enable FR3 from usrp_lib.cpp and run
```
sudo ./build_oai -w USRP
```
Then, you can launch the gNodeB with the same command. Make sure you set att_tx = 40 and att_rx = 20 in the config file.   
```
sudo ./nr-softmodem -O ../../../targets/PROJECTS/GENERIC-NR-5GC/CONF/n310_nyu.conf --nokrnmod --usrp-tx-thread-config 1 --tune-offset 30000000 --gNBs.[0].min_rxtxtime 5
```
## OAI UE at FR3 
```
sudo ./nr-uesoftmodem -C 3619200000 -r 106 --numerology 1 --ssb 516 --ue-fo-compensation -E --time-source 1 --clock-source 1 --uicc0.imsi 001010000000001 --ue-txgain 10 --ue-rxgain 100 -d
```

# OAI notes
https://docs.google.com/document/d/117JxyvUStMudBnMqmVWtjznl5dOxheBT28dS8kYadgY/edit?pli=1&tab=t.0


## N310 image 

https://kb.ettus.com/Writing_the_USRP_File_System_Disk_Image_to_a_SD_Card
https://kb.ettus.com/OAI_Reference_Architecture_for_5G_and_6G_Research_with_USRP

```
sudo uhd_images_downloader -t sdimg -t n3xx
```
```
sudo dd if=/usr/local/share/uhd/images/usrp_n3xx_fs.sdimg of=/dev/sda bs=1M
```
