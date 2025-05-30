# WRCT Webstream Service
## How to Start on a New Computer
Make sure your computer is connected to both CMU's internet, and the Axia/WRCT infranet (10.216.0.1/24)
```
sudo apt install git sox ezstream icecast2 libsox-fmt-mp3

sudo ip route add 239.192.27.89 dev enx086d41e48818
^this ip address is for channel 7001

clone [this rtptools repo](https://github.com/irtlab/rtptools) and `make install`

git clone https://github.com/wrct883/stream-service.git /home/wrct/stream
cd /home/wrct/stream
mkdir logs

change all passwords and paths in files

sudo cp ./systemd-services/wrct-icecast.service /etc/systemd/system/
sudo cp ./systemd-services/wrct-stream-* /etc/systemd/system/

sudo systemctl daemon-reload

sudo systemctl enable --now wrct-icecast.service
sudo systemctl enable --now wrct-stream-rtpdump.service
sudo systemctl enable --now wrct-stream-sox.service
sudo systemctl enable --now wrct-stream-ezstream.service
```

Then go on [yxorp](https://github.com/wrct883/yxorp) and modify `stream.wrct.org` and `streamalt.wrct.org` to point to the ip addrss of the new machine

## backup stream
broadcast what's actually playing on radio using rtl-sdr:
```
sudo apt install rtl-sdr

sudo cp ./systemd-services/wrct-broadcast-* /etc/systemd/system/

sudo systemctl daemon-reload

sudo systemctl enable --now wrct-broadcast-rtl.service
sudo systemctl enable --now wrct-broadcast-sox.service
sudo systemctl enable --now wrct-broadcast-ezstream.service
```

# Notes
## magic numbers
This uses axia's livewire protocol. As of 2025-04-25, our current broadcast channel is `7001`. In order to stream `7001` we do a few things:

1. Run `sudo ip route add 239.192.27.89 dev enx086d41e48818` on host
    * get the ip address (Python) with channel 7001: f"239.192.{7001 // 256}.{7001 % 256}"
    * `enx086d41e48` is the interface that's connected on the Axia network (10.216.0.0/24). You can find this using `ip a`

2. Modify `0xefc01b59` in `stream`, in the `rtpdump -F payload 0xefc01b59/5004` part of the command
    * get the hex code (Python) with channel 7001: `hex(239*256**3 + 192*256**2 + 7001)`
    * This uses the `rtpdump` command line utility you installed with the `rtptools` repo earlier. This listens on `rtp` to the above ip address, port 5004 (Axia Livewire protocol specification)

## TODO
- maybe script everything including the variables and passwords but that seems too tedious for something this simple, that will realistically need to be done maybe every couple of years
