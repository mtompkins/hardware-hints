# Bonded WLAN / LAN example
This is an example of enabling a bonded LAN / WLAN configuration
which may be useful on a laptop where it may or may not be tethered and the WLAN interface should then become (in)active respectively.

Note: Requires ifenslave
```
sudo apt-get install ifenslave
```
The standard location for this file is  `/etc/network/interfaces`

```
source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

## Auto-failover from ethernet to wlan by device ID
#auto bond0
allow-hotplug bond0
	iface bond0 inet dhcp
	bond-slaves enp3s0
	bond-mode active-backup
	bond-miimon 100
	bond-primary enp3s0

allow-hotplug wlx74da3343e2e1
	iface wlx74da3343e2e1 inet manual
	bond-master bond0
	bond-mode active-backup
	bond-miimon 100
	bond-give-a-chance 10
	wpa-bridge bond0
	wpa-scan-ssid 1
	wpa-ap-scan 1
	#wpa-iface wlan0
	wpa-ssid <<WIFI-SSID>>
	wpa-psk "<<WIFI-PASSWORD>>"
```
