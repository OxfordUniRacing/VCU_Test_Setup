# VCU Test Setup

## Connecting to the BeagleBone

Assuming that you have flashed the operating system correctly, you can connect the BeagleBone to your computer through USB and access it in two ways: ssh and the web interface.

### SSH

You can connect to the BeagleBone with the username `debian` and password `temppwd`. It can be reached on IP `192.168.7.2` and port `22`.

### Web Interface

Go to [http://192.168.6.2/](http://192.168.6.2/)

## Internet Passthrough

In order to pass through the internet connection from your computer to the BeagleBone, some more work needs to be done.

If you are on **Windows**, follow this [tutorial](https://www.digikey.co.uk/en/maker/blogs/how-to-connect-a-beaglebone-black-to-the-internet-using-usb).

---

If you are on **Ubuntu Linux**, run these commands on **your computer** (not the BeagleBone) and replace `BEAGLEBONE_INTERFACE` and `INTERFACE_WITH_WORKING_INTERNET` with the correct values:

```
sudo ifconfig BEAGLEBONE_INTERFACE 192.168.7.1
sudo sysctl net.ipv4.ip_forward=1
sudo iptables --table nat --append POSTROUTING --out-interface INTERFACE_WITH_WORKING_INTERNET -j MASQUERADE
sudo iptables --append FORWARD --in-interface BEAGLEBONE_INTERFACE -j ACCEPT
```

Then run these commands on the **BeagleBone**:

```
sudo /sbin/route add default gw 192.168.7.1
echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
```

If you are on **Arch Linux**, follow this [tutorial](https://gmpreussner.com/reference/archlinux-sharing-with-beaglebone-black).

---

If you are on **macos**, run these commands on **your computer** (not the BeagleBone) and replace `BEAGLEBONE_INTERFACE` and `INTERFACE_WITH_WORKING_INTERNET` with the correct values:

```
sudo sysctl net.inet.ip.forwarding=1
echo "nat on INTERFACE_WITH_WORKING_INTERNET from BEAGLEBONE_INTERFACE:network to any -> (INTERFACE_WITH_WORKING_INTERNET)" | sudo pfctl -f - -e
```

Then run these commands on the **BeagleBone**:

```
sudo /sbin/route add default gw 192.168.6.1
echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
```

---

Now you should have internet access on the BeagleBone. This can be tested by running `ping example.com` and you should get something like this:

```
$ ping example.com
PING example.com (93.184.216.34) 56(84) bytes of data.
64 bytes from 93.184.216.34 (93.184.216.34): icmp_seq=1 ttl=43 time=78.7 ms
64 bytes from 93.184.216.34 (93.184.216.34): icmp_seq=2 ttl=43 time=78.4 ms
64 bytes from 93.184.216.34 (93.184.216.34): icmp_seq=3 ttl=43 time=80.1 ms
64 bytes from 93.184.216.34 (93.184.216.34): icmp_seq=4 ttl=43 time=79.5 ms
64 bytes from 93.184.216.34 (93.184.216.34): icmp_seq=5 ttl=43 time=78.5 ms
--- example.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 11ms
rtt min/avg/max/mdev = 78.377/79.036/80.072/0.729 ms
```

## Running the Setup Script

After getting internet access, you can now run the setup script. Run these commands on the BeagleBone through either ssh or the web interface (remember `[debian:temppwd]` are the default credentials):

```
git clone https://github.com/OxfordUniRacing/VCU_Test_Setup.git /home/debian/setup
cd /home/debian/setup
sudo ./install.sh
```
