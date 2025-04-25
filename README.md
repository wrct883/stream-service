# Usage
- Make sure all the paths, variables and arguments are correct
- Add and enable the systemd service (as user so it can be restarted without root)
- Set up a cron job to run `up-check.sh` as frequently as necessary

# TODO
- Make an env file
- Test
- Dockerize this?

# How to Start on a New Computer
Make sure your computer is connected to both CMU's internet, and the Axia/WRCT infranet (10.216.0.1/24)
```
sudo apt install sox ezstream icecast2 libsox-fmt-mp3 screen

sudo ip route add 239.192.27.89 dev enx086d41e48818
^this ip address is for channel 7001

clone [this rtptools repo](https://github.com/irtlab/rtptools) and `make install`

cp wrct\@stream.service /etc/systemd/system/wcrt\@stream.service

systemctl start wrct\@stream.service

start a screen or tmux service, and run
icecast2 -c icecast.xml
in it, then exit

./up.sh

crontab -e
*/1 * * * * /home/wrct/wrct_keep_alive/up-check.sh
```

Then go on [yxorp](https://github.com/wrct883/yxorp) and modify `stream.wrct.org` and `streamalt.wrct.org` to point to the ip addrss of the new machine

## magic numbers
This uses axia's livewire protocol. As of 2025-04-25, our current broadcast channel is `7001`. In order to stream `7001` we do a few things:

1. Run `sudo ip route add 239.192.27.89 dev enx086d41e48818` on host
    * get the ip address (Python) with channel 7001: f"239.192.{7001 // 256}.{7001 % 256}"
    * `enx086d41e48` is the interface that's connected on the Axia network (10.216.0.0/24). You can find this using `ip a`

2. Modify `0xefc01b59` in `stream.sh`, in the `rtpdump -F payload 0xefc01b59/5004` part of the command
    * get the hex code (Python) with channel 7001: `hex(239*256**3 + 192*256**2 + 7001)`
    * This uses the `rtpdump` command line utility you installed with the `rtptools` repo earlier. This listens on `rtp` to the above ip address, port 5004 (Axia Livewire protocol specification)


